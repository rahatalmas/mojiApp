import 'package:flutter/material.dart';
import 'package:quizapp/Screens/question/QuestionTemplate.dart';
import 'package:quizapp/Screens/question/questionEditor.dart';
import 'package:quizapp/constant.dart';

class QuestionCreatePage extends StatefulWidget {
  const QuestionCreatePage({super.key});

  @override
  State<QuestionCreatePage> createState() => _QuestionCreatePage();
}

class _QuestionCreatePage extends State<QuestionCreatePage>
    with SingleTickerProviderStateMixin {

  late TabController _tabController; // Declare the TabController
  final List<Widget> _widgetOptions = <Widget>[
    QuestionEditor(),
    QuestionTemplate()
  ];

  @override
  void initState() {
    super.initState();
    // Ensure the TabController length matches the number of tabs and views
    _tabController = TabController(length: _widgetOptions.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        shadowColor: Colors.black,
        backgroundColor: neutralWhite,
        title: const Text(
          "Question Creation",
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      backgroundColor: neutralWhite,
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: TabBarView(
            controller: _tabController,
            children: _widgetOptions,
          )
      ), // Display the selected widget
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: neutralBG,
        ),
        child: TabBar(
          controller: _tabController,
          dividerColor: Colors.transparent,
          indicator: BoxDecoration(
            color: brandMinus2, // Green color for the selected tab
            borderRadius: BorderRadius.circular(10), // Optional rounded corners
          ),
          indicatorSize: TabBarIndicatorSize
              .tab, // Ensures the indicator spans the full tab width
          labelPadding: EdgeInsets.zero, // Removes padding around the label
          labelColor: colorPrimary, // Text and icon color for the selected tab
          unselectedLabelColor:
              Colors.grey, // Text and icon color for unselected tabs
          tabs: const [
            Tab(icon: Icon(Icons.edit_note), text: "Editor"),
            Tab(icon: Icon(Icons.preview), text: "Preview"),
          ],
        ),
      ),
    );
  }
}
