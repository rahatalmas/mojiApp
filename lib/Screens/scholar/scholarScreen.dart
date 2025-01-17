import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/Screens/scholar/dummyScholarList.dart';
import 'package:quizapp/Screens/scholar/scholarAddPage.dart';
import 'package:quizapp/Screens/scholar/scholarCard.dart';
import 'package:quizapp/constant.dart';
import 'package:quizapp/providers/scholarProvider.dart';

class ScholarScreen extends StatefulWidget {
  const ScholarScreen({Key? key}) : super(key: key);

  @override
  _ScholarScreenState createState() => _ScholarScreenState();
}

class _ScholarScreenState extends State<ScholarScreen> {
  late ScholarProvider _scholarProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _scholarProvider = context.watch<ScholarProvider>();
    if (!_scholarProvider.dataUpdated) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scholarProvider.getAllScholars();
      });
    }
  }

  List<String> selectedSchools = [];
  String? selectedSortOption;
  bool isAscending = true;

  void toggleSchoolSelection(String school) {
    setState(() {
      if (selectedSchools.contains(school)) {
        selectedSchools.remove(school);
      } else {
        selectedSchools.add(school);
      }
    });
  }

  void sortScholars() {
    setState(() {
      scholars.sort((a, b) {
        int comparison = 0;

        // Sorting based on selected option
        if (selectedSortOption == 'Name') {
          comparison = a.scholarName.compareTo(b.scholarName);
        } else if (selectedSortOption == 'School') {
          comparison = a.schoolName.compareTo(b.schoolName);
        } else if (selectedSortOption == 'Class Level') {
          comparison = a.classLevel.compareTo(b.classLevel);
        }

        // Ascending or Descending sorting
        if (!isAscending) {
          comparison = -comparison;
        }

        return comparison;
      });
    });
  }

  // Filtered scholars based on selected schools
  List<DummyScholar> get filteredScholars {
    if (selectedSchools.isEmpty) {
      return scholars;
    } else {
      return scholars
          .where((scholar) => selectedSchools.contains(scholar.schoolName))
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: neutralWhite,
      appBar: AppBar(
        title: Text('Scholars'),
        centerTitle: true,
        elevation: 3,
        shadowColor: Colors.grey,
        backgroundColor: neutralWhite,
        actions: [
          InkWell(
              onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ScholarAddScreen()),
                  ),
              child: Icon(Icons.add)),
          SizedBox(width: 16),
        ],
      ),
      body: _scholarProvider.isLoading
          ? Center(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset("assets/images/animations/geometryloader.json", height: 125),
                ],
              ),
          )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Filters Row
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        // Row(
                        //   children: [
                        //     GestureDetector(
                        //       onTap: () => showSchoolFilterDialog(context),
                        //       child: Row(
                        //         children: [
                        //           Text("School"),
                        //           Icon(Icons.arrow_drop_down),
                        //         ],
                        //       ),
                        //     ),
                        //     SizedBox(width: 16),
                        //     GestureDetector(
                        //       onTap: () => showSortOptionsDialog(context),
                        //       child: Row(
                        //         children: [
                        //           Text("all"),
                        //           Icon(Icons.arrow_drop_down),
                        //         ],
                        //       ),
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  // Scholar List
                  Expanded(
                    child: ListView.builder(
                      itemCount: _scholarProvider.scholars.length,
                      itemBuilder: (context, index) {
                        final scholar = _scholarProvider.scholars[index];
                        print(_scholarProvider.scholars.length);
                        return ScholarCard(
                          scholarId: scholar.scholarId,
                          scholarName: scholar.scholarName,
                          schoolName: scholar.scholarSchool,
                          classLevel: scholar.classLevel,
                          scholarPicture: null,
                          scholar: _scholarProvider.scholars[index],
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ScholarAddScreen()));
                    },
                    child: Ink(
                      width: double.maxFinite,
                      height: 48,
                      decoration: BoxDecoration(
                          color: colorPrimary,
                          borderRadius: BorderRadius.circular(12)),
                      child: const Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Add New",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),
                    ),
                  )

                ],
              ),
            ),
    );
  }

  // School filter dialog
  void showSchoolFilterDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Column(
              children: [
                ...scholars.map((scholar) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 4.0, horizontal: 16.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          toggleSchoolSelection(scholar.schoolName);
                        });
                      },
                      child: Row(
                        children: [
                          Checkbox(
                            value: selectedSchools.contains(scholar.schoolName),
                            onChanged: (bool? value) {
                              setState(() {
                                toggleSchoolSelection(scholar.schoolName);
                              });
                            },
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(scholar.schoolName),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
                // Done Button
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // Close the dialog
                    },
                    child: Text("Done"),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // Sort options dialog
  void showSortOptionsDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Column(
              children: [
                ListTile(
                  title: Text("Sort by Name"),
                  onTap: () {
                    setState(() {
                      selectedSortOption = 'Name';
                    });
                    sortScholars();
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text("Sort by School"),
                  onTap: () {
                    setState(() {
                      selectedSortOption = 'School';
                    });
                    sortScholars();
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text("Sort by Class Level"),
                  onTap: () {
                    setState(() {
                      selectedSortOption = 'Class Level';
                    });
                    sortScholars();
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text("Ascending"),
                  onTap: () {
                    setState(() {
                      isAscending = true;
                    });
                    sortScholars();
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text("Descending"),
                  onTap: () {
                    setState(() {
                      isAscending = false;
                    });
                    sortScholars();
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}
