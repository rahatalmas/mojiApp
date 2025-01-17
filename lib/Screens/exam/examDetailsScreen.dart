import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constant.dart';
import '../../providers/examProvider.dart';
import 'examCreatePage.dart';

class ExamDetailsScreen extends StatefulWidget {
  ExamDetailsScreen({super.key,required this.examId});

  int examId;

  @override
  _ExamDetailsScreenState createState() => _ExamDetailsScreenState();
}

class _ExamDetailsScreenState extends State<ExamDetailsScreen> {
  int? _expandedIndex;
  late ExamProvider _examProvider;

  // @override
  // void initState(){
  //   super.initState();
  //   _examProvider = context.watch<ExamProvider>();
  //   _examProvider.getAllExams();
  // }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   _examProvider = context.watch<ExamProvider>();
  //   //if (!_examProvider.dataUpdated) {
  //     WidgetsBinding.instance.addPostFrameCallback((_) {
  //       _examProvider.getExamDetails(widget.examId);
  //     });
  //   //}
  // }

  void _showBottomModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.delete, color: Colors.redAccent),
                title: Text('Remove'),
                onTap: () {
                  Navigator.pop(context);
                  // Add your remove functionality here
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.cancel, color: Colors.grey),
                title: Text('Cancel'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _deleteExam() {
    // Add your delete functionality here
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Delete Exam"),
          content: Text("Are you sure you want to delete this exam?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                // Handle delete confirmation logic here
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Exam deleted successfully!")),
                );
              },
              child: Text("Delete", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final examprovider = Provider.of<ExamProvider>(context,listen: true);

    // // Check if selectedExamDetails is null
    // if (examprovider.selectedExamDetails == null) {
    //   return Scaffold(
    //     appBar: AppBar(
    //       title: const Text('Exam Details'),
    //       centerTitle: true,
    //       elevation: 3,
    //       backgroundColor: neutralWhite,
    //     ),
    //     body: const Center(
    //       child: CircularProgressIndicator(), // Show loading spinner
    //     ),
    //   );
    // }

    return Scaffold(
      appBar: AppBar(
        title: Text('Exam Details'),
        centerTitle: true,
        elevation: 3,
        shadowColor: Colors.grey,
        backgroundColor: neutralWhite,
        actions: [
          InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ExamCreatePage()),
            ),
            child: const Icon(Icons.add),
          ),
          SizedBox(width: 16),
        ],
      ),
      backgroundColor: neutralWhite,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  // Top Container (Exam Details)
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: brandMinus3,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                //examprovider.selectedExamDetails!.examName,
                                "hello",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: colorPrimary,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                print("Info tapped");
                              },
                              child: const Icon(
                                Icons.new_releases_outlined,
                                size: 24,
                                color: colorPrimary,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.date_range,
                                size: 20, color: colorPrimary),
                            SizedBox(width: 8),
                            Text('Date: 12/12/24'),
                          ],
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.location_on_outlined,
                                size: 20, color: colorPrimary),
                            SizedBox(width: 8),
                            Text('Location: Daffodil International University'),
                          ],
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.supervisor_account,
                                size: 20, color: colorPrimary),
                            SizedBox(width: 8),
                            Text("Total candidates: 100"),
                          ],
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.discount,
                                size: 20, color: colorPrimary),
                            SizedBox(width: 8),
                            Text("Total Questions: 5"),
                          ],
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.man,
                                size: 20, color: colorPrimary),
                            SizedBox(width: 8),
                            Text('Registered: 80'),
                          ],
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.fact_check_outlined,
                                size: 20, color: colorPrimary),
                            SizedBox(width: 8),
                            Text('Result Checked: 60'),
                          ],
                        ),
                        SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.check_circle,
                                    size: 20, color: Colors.green),
                                SizedBox(width: 4),
                                Text('Passed: 50'),
                              ],
                            ),
                            SizedBox(width: 8),
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 8,
                                  backgroundColor: Colors.redAccent,
                                  child: Icon(
                                    Icons.close,
                                    size: 12,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(width: 4),
                                Text('Fail: 10'),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  // List Header
                  const Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [Icon(Icons.list), Text("Candidates")],
                      ),
                      Row(
                        children: [
                          Text("filter"),
                          Icon(
                            Icons.arrow_drop_down_outlined,
                            size: 24,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 2),
                  // Candidate List
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 40,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                        decoration: BoxDecoration(
                          color: neutralWhite,
                          boxShadow: [
                            BoxShadow(
                              spreadRadius: 2,
                              blurRadius: 1,
                              color: Colors.black12,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 2, horizontal: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        "assets/images/man.png",
                                        width: 14,
                                        height: 14,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        "Rahat Almas",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: colorPrimary,
                                        ),
                                      ),
                                    ],
                                  ),
                                  InkWell(
                                    onTap: () {
                                      _showBottomModal(context);
                                    },
                                    child: Icon(
                                      Icons.filter_vintage,
                                      size: 16,
                                    ),
                                  ),
                                ],
                              ),
                              Text("Serial number: 1001"),
                              Text("Daffodil International University"),
                              Text("Class Level: 10th Semester"),
                              Text("Grade: A+"),
                              if (_expandedIndex == index) ...[
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.list_alt_outlined, size: 16),
                                        Text("All Answers: 40"),
                                      ],
                                    ),
                                    SizedBox(width: 8),
                                    Row(
                                      children: [
                                        Row(
                                          children: [
                                            Icon(Icons.check_circle,
                                                size: 16, color: Colors.green),
                                            Text("Correct: 40"),
                                          ],
                                        ),
                                        SizedBox(width: 8),
                                        Row(
                                          children: [
                                            Icon(Icons.cancel,
                                                size: 16,
                                                color: Colors.redAccent),
                                            Text("Incorrect: 0"),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                )
                              ],
                              Align(
                                alignment: Alignment.centerRight,
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      _expandedIndex =
                                      _expandedIndex == index ? null : index;
                                    });
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(width: 2,),
                                          Container(
                                            width: 8,
                                            height: 8,
                                            decoration: BoxDecoration(
                                                color: Colors.indigo,
                                                borderRadius: BorderRadius.circular(1)
                                            ),
                                          ),
                                          SizedBox(width: 4,),
                                          Container(
                                            width: 8,
                                            height: 8,
                                            decoration: BoxDecoration(
                                                color: Colors.purple,
                                                borderRadius: BorderRadius.circular(1)
                                            ),
                                          ),
                                          SizedBox(width: 4,),
                                          Container(
                                            width: 8,
                                            height: 8,
                                            decoration: BoxDecoration(
                                                color: Colors.green,
                                                borderRadius: BorderRadius.circular(1)
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            _expandedIndex == index
                                                ? "Hide details"
                                                : "Show details",
                                            style: TextStyle(color: colorPrimary),
                                          ),
                                          Icon(
                                            _expandedIndex == index
                                                ? Icons.expand_less
                                                : Icons.expand_more,
                                            color: colorPrimary,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            // Fixed Delete Button at the Bottom
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: (){

                },
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: Colors.red[900]),
                  padding: EdgeInsets.all(8),
                  child: Text("Delete Exam",style: TextStyle(color: neutralWhite),),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
