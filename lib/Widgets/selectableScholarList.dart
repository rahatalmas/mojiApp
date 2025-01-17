import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/Screens/candidate/CandidateListAddResult.dart';
import 'package:quizapp/Screens/scholar/selectableScholarCard.dart';
import 'package:quizapp/constant.dart';
import 'package:quizapp/database/models/candidate.dart';
import 'package:quizapp/database/models/scholar.dart';
import 'package:quizapp/providers/examProvider.dart';
import 'package:quizapp/providers/scholarProvider.dart';

import '../providers/candidateProvider.dart';

class ScholarList2 extends StatefulWidget {
  final int examId;
  const ScholarList2({Key? key,required this.examId}) : super(key: key);

  @override
  _ScholarList2State createState() => _ScholarList2State();
}

class _ScholarList2State extends State<ScholarList2> {
  late ScholarProvider _scholarProvider;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _scholarProvider = context.watch<ScholarProvider>();
    if (!_scholarProvider.filterDataUpdated) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scholarProvider.getFilteredScholars(widget.examId);
      });
    }
  }

  final Set<int> _markedScholars = {}; // To store selected scholar IDs
  List<Candidate> _selectedCandidates = [];
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
      _scholarProvider.scholars.sort((a, b) {
        int comparison = 0;

        // Sorting based on selected option
        if (selectedSortOption == 'Name') {
          comparison = a.scholarName.compareTo(b.scholarName);
        } else if (selectedSortOption == 'School') {
          comparison = a.scholarSchool.compareTo(b.scholarSchool);
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
  List<Scholar> get filteredScholars {
    if (selectedSchools.isEmpty) {
      return _scholarProvider.scholars;
    } else {
      return _scholarProvider.scholars
          .where((scholar) => selectedSchools.contains(scholar.scholarSchool))
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    ExamProvider examProvider = Provider.of<ExamProvider>(context,listen: true);
    CandidateProvider candidateProvider = Provider.of<CandidateProvider>(context,listen: true);
    return Column(
      children: [
        // Filters Row
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.list),
                  SizedBox(width: 3),
                  Text("Scholar list")
                ],
              ),
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
              //           Text("Sort"),
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
        candidateProvider.isLoading ? Column(
          children: [
            Lottie.asset("assets/images/fileAdding.json", height: 110),
          ],
        ):
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _scholarProvider.filteredScholars.length,
          itemBuilder: (context, index) {
            final scholar = _scholarProvider.filteredScholars[index];
            final isMarked = _markedScholars.contains(scholar.scholarId);

            return GestureDetector(
              onTap: () {
                setState(() {
                  if (isMarked) {
                    _markedScholars.remove(scholar.scholarId);
                    print(_selectedCandidates.length);
                  } else {
                    _markedScholars.add(scholar.scholarId);
                    int len = candidateProvider.candidates.length;
                    int serialNumber;
                    if(len == 0){
                      serialNumber = 1000+_selectedCandidates.length+1;
                    }else{
                      serialNumber = candidateProvider.candidates[len-1].serialNumber+_selectedCandidates.length+1;
                    }
                    Candidate candidate = Candidate(
                        serialNumber: serialNumber,
                        name: scholar.scholarName,
                        schoolName: scholar.scholarName,
                        classLevel: scholar.classLevel,
                        scholarId: scholar.scholarId,
                        examId: examProvider.selectedExam!.id
                    );
                    _selectedCandidates.add(candidate);
                  }
                });
              },
              child: SelectableScholarCard(
                scholarId: scholar.scholarId,
                scholarName: scholar.scholarName,
                scholarPicture: scholar.scholarPicture,
                schoolName: scholar.scholarSchool,
                classLevel: scholar.classLevel,
                isMarked: isMarked,
              ),
            );
          },
        ),
        const SizedBox(height: 16),
        InkWell(
          onTap: () async {
            //print(_markedScholars);
            if(_selectedCandidates.isEmpty){
              print("Nothing selected");
              print(examProvider.selectedExam!.name);
            }else{
              if(examProvider.selectedExam != null){
                int c = 1;
                c = await candidateProvider.addMultipleCandidate(_selectedCandidates,examProvider.selectedExam!.id);
                //print("popped "+c.toString());
                if (c > 0) {
                  final a = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context){
                        return CandidateListAddResult(candidates: _selectedCandidates, count: c);
                      }
                    )
                  );
                  print("popped "+a.toString());
                  setState(() {
                    _selectedCandidates = a;
                  });
                }
              }
            }
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: colorPrimary,
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              border: Border.all(color: Colors.black87, width: 2),
            ),
            child:
            candidateProvider.isLoading?
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "saving...",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(width: 3),
                Icon(Icons.connecting_airports, color: Colors.white),
              ],
            ):
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Save",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(width: 3),
                Icon(Icons.save_as, color: Colors.white),
              ],
            ),
          ),
        ),
      ],
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
                ..._scholarProvider.scholars.map((scholar) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          toggleSchoolSelection(scholar.scholarSchool);
                        });
                      },
                      child: Row(
                        children: [
                          Checkbox(
                            value: selectedSchools.contains(scholar.scholarSchool),
                            onChanged: (bool? value) {
                              setState(() {
                                toggleSchoolSelection(scholar.scholarSchool);
                              });
                            },
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(scholar.scholarSchool), // Corrected to scholarSchool
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
