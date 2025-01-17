import 'package:flutter/material.dart';
import 'package:quizapp/Screens/candidate/candidatepage.dart';
import 'package:quizapp/Screens/exam/examCreatePage.dart';
import 'package:quizapp/Screens/exam/examScreen.dart';
import 'package:quizapp/Screens/omr/omrCreatePage.dart';
import 'package:quizapp/Screens/result/resultAddScreen.dart';
import 'package:quizapp/Screens/result/resultScreen.dart';
import 'package:quizapp/Screens/scholar/scholarAddPage.dart';
import 'package:quizapp/Screens/scholar/scholarScreen.dart';
import 'package:quizapp/Widgets/examCard.dart';
import 'package:quizapp/Widgets/menuButton.dart';
import 'package:quizapp/Screens/question/questionCreatePage.dart';
import 'package:quizapp/Widgets/shortcutButton.dart';
import 'package:quizapp/constant.dart';
import 'package:collection/collection.dart';

import '../handler/apis/login.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});
  String getDayShortForm() {
    DateTime now = DateTime.now();
    String weekdayName = '';

    switch (now.weekday) {
      case 1:
        weekdayName = 'Mon';
        break;
      case 2:
        weekdayName = 'Tue';
        break;
      case 3:
        weekdayName = 'Wed';
        break;
      case 4:
        weekdayName = 'Thu';
        break;
      case 5:
        weekdayName = 'Fri';
        break;
      case 6:
        weekdayName = 'Sat';
        break;
      case 7:
        weekdayName = 'Sun';
        break;
      default:
        weekdayName = 'Unknown';
    }

    return weekdayName.toUpperCase();
  }

  void main() {
    print(getDayShortForm()); // This will print the current weekday in uppercase, e.g., 'MON'
  }

  @override
  Widget build(BuildContext context) {
    List _menuOptions = [
      {
        "title": "New Exam",
        "image": "assets/images/thirteen.svg",
      },
      {
        "title": "Register Candidate",
        "image": "assets/images/fourteen.svg",
      },
      {
        "title": "Create Question",
        "image": "assets/images/sixteen.svg",
      },
      {
        "title": "OMR Generate",
        "image": "assets/images/three.svg",
      },
      {
        "title": "Add Scholar",
        "image": "assets/images/seven.svg",
      },
      {
        "title": "Add Result",
        "image": "assets/images/six.svg",
      },
    ];
    List _shortcutMenu = [
      {
        "title": "Scholars",
        "image": "assets/images/two.svg",
      },
      {
        "title": "Exams",
        "image": "assets/images/one.svg",
      },
      {
        "title": "Results",
        "image": "assets/images/eleven.svg",
      },
    ];

    final List<Widget> _menuoptions = [
      const ExamCreatePage(),
      const CandidateCreatePage(),
      const QuestionCreatePage(),
      const OmrCreatePage(),
      const ScholarAddScreen(),
      const ResultAddScreen(),
    ];

    final List<Widget> _shortcutOptions = [
      const ScholarScreen(),
      ExamScreen(),
      ResultScreen(),
    ];

    return ListView(
      children: [
        // Container(
        //   padding: const EdgeInsets.all(15),
        //   width: MediaQuery.of(context).size.width,
        //   decoration: BoxDecoration(
        //     color: neutralBG,
        //     borderRadius: const BorderRadius.all(
        //       Radius.circular(15),
        //     ),
        //   ),
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       Row(
        //         children: [
        //           Image.asset("assets/images/leading2.png", width: 50),
        //           const Text(
        //             "Search Query",
        //             style: TextStyle(
        //                 fontWeight: FontWeight.bold,
        //                 fontSize: 15,
        //                 color: Colors.black),
        //           ),
        //         ],
        //       ),
        //       const SizedBox(height: 5),
        //       TextField(
        //         decoration: InputDecoration(
        //           labelText: "type here...",
        //           hintText: "O Level Final",
        //           hintStyle: const TextStyle(color: Colors.black),
        //           labelStyle: const TextStyle(color: Colors.black),
        //           prefixIcon: Padding(
        //             padding: const EdgeInsets.only(left: 15, right: 5),
        //             child: Icon(Icons.terminal_sharp,
        //                 size: 30, color: Colors.brown[800]),
        //           ),
        //           border: OutlineInputBorder(
        //             borderRadius: BorderRadius.circular(25.0),
        //             borderSide:
        //                 const BorderSide(color: Colors.black, width: 3.5),
        //           ),
        //           enabledBorder: OutlineInputBorder(
        //             borderRadius: BorderRadius.circular(25.0),
        //             borderSide:
        //                 const BorderSide(color: Colors.black, width: 3.5),
        //           ),
        //           focusedBorder: OutlineInputBorder(
        //             borderRadius: BorderRadius.circular(25.0),
        //             borderSide:
        //                 const BorderSide(color: Colors.black, width: 3.5),
        //           ),
        //           errorBorder: OutlineInputBorder(
        //             borderRadius: BorderRadius.circular(25.0),
        //             borderSide: const BorderSide(color: Colors.red, width: 3.5),
        //           ),
        //           focusedErrorBorder: OutlineInputBorder(
        //             borderRadius: BorderRadius.circular(25.0),
        //             borderSide: const BorderSide(color: Colors.red, width: 3.5),
        //           ),
        //           fillColor: Colors.white,
        //           filled: true,
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        // const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(15),
          width: MediaQuery.of(context).size.width,
          decoration:const BoxDecoration(
            color: brandMinus3,
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text(
                        'Hello, ${ Auth().loginData!.username}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 26,
                            color: colorPrimary
                        ),
                      ),
                    ],
                  ),
                  Text("Have a great day,",style: TextStyle(),),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text("Manage you exam plans",style: TextStyle())
                    ],
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text("Today",style: TextStyle(fontSize:20),),
                      SizedBox(width: 4,),
                      Icon(Icons.calendar_month,size: 24,color: colorPrimary,)
                    ],
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          DateTime.now().day > 10 ?
                          Text('${DateTime.now().day}',style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500,color: Colors.blue[500],)) :
                          Text('0${DateTime.now().day}',style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500,color: Colors.blue[500],),),
                          DateTime.now().month > 10 ?
                          Text('${DateTime.now().month}',style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500,color: Colors.indigo,)) :
                          Text('0${DateTime.now().month}',style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500,color: Colors.indigo,),),
                        ],
                      ),
                      SizedBox(width: 4,),
                      Container(child: Text('${getDayShortForm()}',style: TextStyle(fontSize: 36,fontWeight: FontWeight.w500,color: Colors.orange[500],letterSpacing: 0),)),
                    ],
                  ),
                ],
              )
            ],
          )
        ),
        const SizedBox(height: 12),
        //menu
        Row(
          children: [
            Row(
              children: [
                Icon(Icons.menu_open, color: appTextPrimary),
                Text(
                  "Menu",
                  style: TextStyle(
                      color: appTextPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 12),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
          child: Wrap(
            spacing: 10.0,
            runSpacing: 10.0,
            children: _menuOptions.mapIndexed((index, e) {
              return MenuButton(
                title: e['title'],
                image: e['image'],
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => _menuoptions[index]),
                ),
              );
            }).toList(),
          ),
        ),

        const SizedBox(height: 12),
        Row(
          children: [
            Row(
              children: [
                Icon(Icons.shortcut, color: colorPrimary),
                SizedBox(
                  width: 3,
                ),
                Text(
                  "Shortcuts",
                  style: TextStyle(
                      color: appTextPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
              ],
            ),
          ],
        ),

        //shortcuts ...
        const SizedBox(height: 7),
        SizedBox(
          height: 116,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: _shortcutOptions.length,
            itemBuilder: (BuildContext context, int index) {
              //will replaced by shortcut buttons
              return Row(
                children: [
                  ShortcutButton(
                    title: _shortcutMenu[index]['title'],
                    image: _shortcutMenu[index]['image'],
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => _shortcutOptions[index]),
                    ),
                  ),
                  //SizedBox(width: 10,)
                ],
              );
            },
          ),
        ),

        //most recent activities
        const SizedBox(
          height: 7,
        ),
        Row(
          children: [
            Row(
              children: [
                Icon(Icons.manage_history, color: colorPrimary),
                SizedBox(
                  width: 3,
                ),
                Text(
                  "Recent Activity",
                  style: TextStyle(
                      color: appTextPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 7,
        ),
        ExamCard(
          examId: 1,
          examName: "Space X Journey To Mars",
          examDate: DateTime.parse("2024-12-30T18:00:00.000Z"),
          examLocation: "Planet Earth",
          examDuration: 5,
          questionCount: 100,
          candidateCount: 100,
          onDelete: (){},
        )
      ],
    );
  }
}
