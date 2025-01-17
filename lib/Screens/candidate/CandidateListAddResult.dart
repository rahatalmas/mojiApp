import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/Screens/scholar/scholarAddPage.dart';
import 'package:quizapp/constant.dart';
import 'package:quizapp/database/models/candidate.dart';
import 'package:quizapp/providers/examProvider.dart';
import 'package:quizapp/providers/scholarProvider.dart';

class CandidateListAddResult extends StatelessWidget {
  List<Candidate> candidates;
  final int count;

  CandidateListAddResult(
      {super.key, required this.candidates, required this.count});

  @override
  Widget build(BuildContext context) {
    final scholarProvider = Provider.of<ScholarProvider>(context,listen:true);
    final examProvider = Provider.of<ExamProvider>(context,listen: true);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Registration Update",
          style: TextStyle(color: appTextPrimary),
        ),
        centerTitle: true,
        backgroundColor: kColorPrimary,
        iconTheme: const IconThemeData(color: appTextPrimary),
        elevation: 3,
        shadowColor: Colors.grey,
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
      backgroundColor: neutralWhite,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // success container
            Container(
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(horizontal: 12,vertical: 16),
              decoration: BoxDecoration(
                color: brandMinus3,
                borderRadius: BorderRadius.circular(8),
                //border: Border.all(color: brandP,width: 2.5)
              ),
              child: Column(
                children: [
                  Lottie.asset("assets/images/success1.json",width: 112),
                  Text('Registration Successful',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: colorPrimary),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Requested: ${candidates.length}',style: TextStyle(color: colorPrimary)),
                      SizedBox(width: 4,),
                      Text('Added: ${count}',style: TextStyle(color: colorPrimary)),
                      SizedBox(width: 4,),
                      Text('Failed: ${candidates.length-count}',style: TextStyle(color: colorPrimary)),
                    ],
                  ),
                  SizedBox(height: 8,),
                  InkWell(
                      onTap: (){
                        candidates = [];
                        Navigator.pop(context,candidates);
                        scholarProvider.getFilteredScholars(examProvider.selectedExam!.id);
                      },
                    child: Container(
                      alignment: Alignment.center,
                      width: 100,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: colorPrimary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text("Done",style: TextStyle(color: neutralWhite,fontWeight: FontWeight.w500),),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 8,),
            const Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.list,size: 21,),
                    Text("Requested List")
                  ],
                ),
                Row(
                  children: [
                    Text("Filter"),
                    Icon(Icons.filter_vintage_rounded,size: 18,),
                  ],
                )
              ],
            ),
            SizedBox(height: 4,),
            Expanded(
                child: ListView.builder(
              itemCount: candidates.length,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 4,horizontal: 2.5),
                      padding:EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: neutralWhite,
                        boxShadow: [BoxShadow(color: Colors.black12,blurRadius: 1,spreadRadius: 1)],
                        borderRadius: BorderRadius.circular(6)
                      ),

                      //Card for candidates
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset("assets/images/man.png",width: 50,),
                              SizedBox(width: 4,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Name: ${candidates[index].name}'),
                                  Text('Serial Number: ${candidates[index].serialNumber}'),
                                ],
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: index<count
                                ?
                            Column(
                              children: [
                                Icon(Icons.cloud_done,color: Colors.green,),
                                Text("saved",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500,color: Colors.green),)
                              ],
                            )
                                :
                            Column(
                              children: [
                                Icon(Icons.cancel_rounded,color: Colors.red,),
                                Text("Canceled",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500,color: Colors.red),)
                              ],
                            )
                            ,
                          ),
                        ],
                      ),
                    ),
                    if (index == count - 1) ...[
                      Row(
                        children: [
                          Icon(
                            Icons.cancel_schedule_send,size: 16,
                          ),
                          SizedBox(width: 8,),
                          Text("Rejected"),
                          SizedBox(width: 8,),
                          Expanded(
                            flex: 4,
                              child: Container(
                                height: 2,
                                color: brandMinus3,
                              )
                          ),
                        ],
                      ),
                    ]
                  ],
                );
              },
            )),
            SizedBox(height: 8,),
            InkWell(
              onTap: (){
                candidates = [];
                Navigator.pop(context,candidates);
                scholarProvider.getFilteredScholars(examProvider.selectedExam!.id);
              },
              child: Container(
                alignment: Alignment.center,
                width: double.maxFinite,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: colorPrimary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text("Back",style: TextStyle(color: neutralWhite,fontWeight: FontWeight.w500),),
              ),
            )
          ],
        ),
      ), // Display the selected widget
    );
  }
}
