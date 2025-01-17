import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:quizapp/Screens/result/models/ErrorResponse.dart';
import 'package:quizapp/Screens/result/models/successResponse.dart';
import 'package:quizapp/Screens/result/resultScreen.dart';
import 'package:quizapp/constant.dart';

class PaperProcessingResult extends StatelessWidget {
  final List<SuccessResponse> success;
  final List<ErrorResponse> errors;
  const PaperProcessingResult(
      {super.key, required this.success, required this.errors});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Paper Processing Output",
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
                    MaterialPageRoute(builder: (context) => ResultScreen()),
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
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              decoration: BoxDecoration(
                color: brandMinus3,
                borderRadius: BorderRadius.circular(8),
                //border: Border.all(color: brandP,width: 2.5)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: Lottie.asset("assets/images/animations/summary.json",height: 112),),
                  Expanded(
                    flex: 2,
                      child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Checking Summary',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: colorPrimary),
                        ),
                        Text(
                            'Total Papers: ${success.length + errors.length}',
                            style: TextStyle(color: colorPrimary)
                        ),
                        Text('Valid: ${success.length}',
                            style: TextStyle(color: colorPrimary)),
                        Text('Invalid: ${errors.length}',
                            style: TextStyle(color: colorPrimary)),
                    ],
                  ))
                ],
              ),
            ),

            Expanded(
                child: ListView(
              children: [
                //valid papers
                SizedBox(
                  height: 8,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 2,
                        ),
                        Icon(
                          Icons.list,
                          size: 20,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text("Valid Papers"),
                      ],
                    ),
                    Icon(
                      Icons.info,
                      color: colorPrimary,
                      size: 20,
                    )
                  ],
                ),
                SizedBox(
                  height: 4,
                ),
                success.length == 0
                    ? Center(
                        child: Column(
                          children: [
                            Lottie.asset("assets/images/animations/novalidpaper.json",height: 200),
                            Text("No Valid Papers")
                          ],
                        ),
                    )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: success.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 4, horizontal: 2.5),
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                color: neutralWhite,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 2,
                                      spreadRadius: 1)
                                ],
                                borderRadius: BorderRadius.circular(6)),
                            //Card for candidates result
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      "assets/images/man.png",
                                      width: 50,
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                            'Serial Number: ${success[index].serialNumber}'),
                                        Row(
                                          children: [
                                            Text(
                                                'Correct: ${success[index].correctAnswers}'),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Text(
                                                'Out Of: ${success[index].totalQuestion}'),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Column(
                                      children: [
                                        Icon(
                                          Icons.cloud_done,
                                          color: Colors.green,
                                        ),
                                        Text(
                                          "saved",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.green),
                                        )
                                      ],
                                    )),
                              ],
                            ),
                          );
                        },
                      ),
                SizedBox(
                  height: 4,
                ),

                //invalid papers...
                SizedBox(
                  height: 8,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 2,
                        ),
                        Icon(
                          Icons.cancel_schedule_send_outlined,
                          size: 20,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text("Invalid Papers"),
                      ],
                    ),
                    Icon(
                      Icons.info,
                      color: colorPrimary,
                      size: 20,
                    )
                  ],
                ),
                SizedBox(
                  height: 4,
                ),

                errors.length == 0
                    ?  Center(
                  child: Column(
                    children: [
                      Lottie.asset("assets/images/animations/novalidpaper.json",height: 200),
                      Text("No Invalid Papers")
                    ],
                  ),
                )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: errors.length,
                        itemBuilder: (context, index) {
                          return Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 2.5),
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                  color: neutralWhite,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 2,
                                        spreadRadius: 1)
                                  ],
                                  borderRadius: BorderRadius.circular(6)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      //Image.asset("assets/images/man.png",width: 50,),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                              'Serial Number: ${errors[index].serialNumber}'),
                                          Row(
                                            children: [
                                              Text(
                                                '${ errors[index].message.length > 40?
                                                    errors[index].message.substring(0,40)+"...":
                                                    errors[index].message
                                                }',
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,// This will prevent overflow and add ellipsis
                                              ),
                                              SizedBox(width: 8),
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Column(
                                      children: [
                                        Icon(
                                          Icons.cancel_rounded,
                                          color: Colors.red,
                                        ),
                                        Text(
                                          "Canceled",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.red),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ));
                        },
                      ),
                SizedBox(
                  height: 8,
                ),
              ],
            )),

            InkWell(
              onTap: () {
                Navigator.popUntil(context, (route) => route.isFirst);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ResultScreen()));
              },
              child: Container(
                alignment: Alignment.center,
                width: double.maxFinite,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: colorPrimary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "Results",
                  style: TextStyle(
                      color: neutralWhite, fontWeight: FontWeight.w500),
                ),
              ),
            )
          ],
        ),
      ), // Display the selected widget
    );
  }
}
