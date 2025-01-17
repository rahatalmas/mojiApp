import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/constant.dart';
import 'package:quizapp/providers/scholarProvider.dart';

import '../../database/models/scholar.dart';

class ScholarUpdateScreen extends StatefulWidget {
  final int scholarId;
  final String name;
  final String schoolName;
  final String classLevel;

  const ScholarUpdateScreen({
    super.key,
    required this.scholarId,
    required this.name,
    required this.schoolName,
    required this.classLevel,
  });

  @override
  State<ScholarUpdateScreen> createState() => _ScholarUpdateScreenState();
}

class _ScholarUpdateScreenState extends State<ScholarUpdateScreen> {
  late ScholarProvider _scholarProvider;
  late TextEditingController _nameController;
  late TextEditingController _schoolNameController;
  late TextEditingController _classLevelController;

  final InputDecoration _textFieldDecoration = InputDecoration(
    labelText: "Type here...",
    hintText: "Enter value",
    hintStyle: const TextStyle(color: Colors.black),
    labelStyle: const TextStyle(color: Colors.black),
    prefixIcon: Padding(
      padding: const EdgeInsets.only(left: 15, right: 5),
      child: Icon(Icons.input, size: 30, color: kColorPrimary),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15.0),
      borderSide: const BorderSide(color: kColorSecondary, width: 2.5),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15.0),
      borderSide: const BorderSide(color: kColorSecondary, width: 2.5),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15.0),
      borderSide: const BorderSide(color: kColorSecondary, width: 2.5),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15.0),
      borderSide: const BorderSide(color: Colors.red, width: 2.5),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15.0),
      borderSide: const BorderSide(color: Colors.red, width: 2.5),
    ),
    fillColor: Colors.white,
    filled: true,
  );

  @override
  void initState() {
    super.initState();
    _scholarProvider = Provider.of<ScholarProvider>(context, listen: false);

    // Initialize controllers with the passed-in values
    _nameController = TextEditingController(text: widget.name);
    _schoolNameController = TextEditingController(text: widget.schoolName);
    _classLevelController = TextEditingController(text: widget.classLevel);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _schoolNameController.dispose();
    _classLevelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isKeyboardVisible = KeyboardVisibilityProvider.isKeyboardVisible(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Update Scholar Info",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: neutralWhite,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 3,
        shadowColor: Colors.grey,
      ),
      backgroundColor: neutralWhite,
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
          : Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16),
              children: [
                SizedBox(height: 16),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/leading1.png",
                      height: 250,
                      width: 250,
                    )
                  ],
                ),
                SizedBox(height: 16),
                // Scholar Name Field
                TextField(
                  controller: _nameController,
                  decoration: _textFieldDecoration.copyWith(
                      labelText: "Name",
                      hintText: "Enter name",
                      prefixIcon: const Icon(Icons.person)),
                ),
                const SizedBox(height: 10),
                // School Name Field
                TextField(
                  controller: _schoolNameController,
                  decoration: _textFieldDecoration.copyWith(
                      labelText: "School Name",
                      hintText: "Enter school name",
                      prefixIcon: const Icon(Icons.school)),
                ),
                const SizedBox(height: 10),
                // Class Level Field
                TextField(
                  controller: _classLevelController,
                  decoration: _textFieldDecoration.copyWith(
                      labelText: "Class Level",
                      hintText: "Enter class level",
                      prefixIcon: const Icon(Icons.class_)),
                ),
              ],
            ),
          ),
          Visibility(
            visible: !isKeyboardVisible,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: InkWell(
                onTap: () async {
                  print("Updated Scholar Details:");
                  print("Name: ${_nameController.text}");
                  print("School Name: ${_schoolNameController.text}");
                  print("Class Level: ${_classLevelController.text}");

                  Scholar updatedScholar = Scholar(
                    scholarId: widget.scholarId,
                    scholarName: _nameController.text,
                    scholarSchool: _schoolNameController.text,
                    classLevel: _classLevelController.text,

                  );

                  bool isSuccess = await _scholarProvider.updateScholar(updatedScholar);

                  if (isSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        duration: Duration.zero,
                        content: Text('Scholar info updated successfully!'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: Duration.zero,
                        content: Text('Failed to update scholar info'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: colorPrimary,
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    "Update",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
