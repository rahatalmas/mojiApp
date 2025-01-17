import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/Screens/admin/adminPage.dart';
import 'package:quizapp/Screens/exam/examScreen.dart';
import 'package:quizapp/Screens/home.dart';
import 'package:quizapp/Screens/result/paperProcessingResult.dart';
import 'package:quizapp/Screens/result/resultChecking.dart';
import 'package:quizapp/Screens/result/resultScreen.dart';
import 'package:quizapp/handler/apis/login.dart';
import 'package:quizapp/providers/actionProvider.dart';
import 'package:quizapp/providers/adminProvider.dart';
import 'package:quizapp/providers/answerProvider.dart';
import 'package:quizapp/providers/candidateProvider.dart';
import 'package:quizapp/providers/examProvider.dart';
import 'package:quizapp/providers/questionProvider.dart';
import 'package:quizapp/providers/resultProvider.dart';
import 'package:quizapp/providers/scholarProvider.dart';
import 'package:quizapp/routes.dart';

import 'constant.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AdminProvider()),
        ChangeNotifierProvider(create: (context) => ExamProvider()),
        ChangeNotifierProvider(create: (context) => CandidateProvider()),
        ChangeNotifierProvider(create: (context) => ScholarProvider()),
        ChangeNotifierProvider(create: (context) => AnswerProvider()),
        ChangeNotifierProvider(create: (context) => ResultProvider()),
        ChangeNotifierProvider(create: (context) => QuestionProvider()),
        ChangeNotifierProvider(create: (context) => ActionStatusProvider())
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityProvider(
      child: KeyboardDismissOnTap(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Moji OMR',
          theme: ThemeData(
            useMaterial3: true,
          ),
          onGenerateRoute: (RouteSettings routeSettings) {
            return routes(routeSettings);
          },
        ),
      ),
    );
  }
}

class Root extends StatefulWidget {
  const Root({super.key, required this.title});

  final String title;

  @override
  State<Root> createState() => _Root();
}

class _Root extends State<Root> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Widget> _children = [
    const Dashboard(),
    const ResultCheckScreen(),
  ];

  // Global key to access the scaffold state
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    // Ensure the TabController length matches the number of tabs and views
    _tabController = TabController(length: _children.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool editModeOn =
        Provider.of<ActionStatusProvider>(context, listen: true).actionInfo;

    return Scaffold(
      key: _scaffoldKey,
      // Assign the scaffold key
      backgroundColor: neutralWhite,
      appBar: AppBar(
        centerTitle: true,
        elevation: 3,
        shadowColor: Colors.black,
        backgroundColor: neutralWhite,
        leading: IconButton(
          icon: Icon(Icons.menu, color: appTextPrimary, size: 28),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        title: Text(
          "Home",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 25, color: appTextPrimary),
        ),
        actions: [
          Icon(Icons.content_paste_search, color: appTextPrimary),
          const SizedBox(width: 10),
          editModeOn
              ? InkWell(
                  child: Icon(Icons.sunny, color: appTextPrimary),
                  onTap: () {
                    Provider.of<ActionStatusProvider>(context, listen: false)
                        .turnActionStatusOff();
                  },
                )
              : Icon(Icons.mode_night, color: appTextPrimary),
          const SizedBox(width: 15),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: TabBarView(
          controller: _tabController,
          children: _children,
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        decoration: BoxDecoration(
            color: neutralBG, borderRadius: BorderRadius.circular(12)),
        child: TabBar(
          controller: _tabController,
          dividerColor: Colors.transparent,
          indicator: BoxDecoration(
            color: brandMinus2, // Green color for the selected tab
            borderRadius: BorderRadius.circular(12), // Optional rounded corners
          ),
          indicatorSize: TabBarIndicatorSize.tab,
          // Ensures the indicator spans the full tab width
          labelPadding: EdgeInsets.zero,
          // Removes padding around the label
          labelColor: brandPlus2,
          // Text and icon color for the selected tab
          unselectedLabelColor: Colors.grey,
          // Text and icon color for unselected tabs
          tabs: const [
            Tab(icon: Icon(Icons.home), text: "Home"),
            Tab(icon: Icon(Icons.sailing), text: "Result"),
          ],
        ),
      ),
      drawer: Drawer(
        backgroundColor: neutralWhite,
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: colorPrimary,
              ),
              accountName: Text('${Auth().loginData!.username}'),
              accountEmail: Text('Role: ${Auth().loginData!.permission==1?"Admin":"Editor"}'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: kColorPrimary,
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/man2.png',
                    //width: 50,
                    //height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text("Profile"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AdminPage()),
                );
                _tabController.animateTo(0); // Navigate to the Admin Page
              },
            ),
            ListTile(
              leading: Icon(Icons.article),
              title: Text("All Exams"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> ExamScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text("All Results"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> ResultScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text("Logout"),
              onTap: () async {
                Auth().logout().then((value) {
                  if (!context.mounted) return;
                  if (value) {
                    Navigator.pushNamedAndRemoveUntil(context,
                        RouteNames.landing, (Route<dynamic> route) => false);
                  } else {
                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Logout failed. Please try again.'),
                      ),
                    );
                  }
                });
              },
            ),
            ListTile(
              leading: Icon(Icons.question_answer),
              title: Text("TestPage"),
              onTap: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context)=>PaperProcessingResult(success: [], errors: []))
                // );
              },
            ),
          ],
        ),
      ),
    );
  }
}
