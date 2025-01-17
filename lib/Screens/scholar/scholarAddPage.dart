import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/constant.dart';
import 'package:quizapp/database/models/scholar.dart';
import 'package:quizapp/providers/scholarProvider.dart';

class ScholarAddScreen extends StatefulWidget {
  const ScholarAddScreen({super.key, this.scholar});

  final Scholar? scholar;

  @override
  State<ScholarAddScreen> createState() => _ScholarAddScreenState();
}

class _ScholarAddScreenState extends State<ScholarAddScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _schoolNameController = TextEditingController();
  final TextEditingController _classLevelController = TextEditingController();

  File? _selectedImage; // Holds the selected image file

  final InputDecoration _textFieldDecoration = InputDecoration(
    labelText: "Type here...",
    hintText: "Enter value",
    hintStyle: const TextStyle(color: Colors.black),
    labelStyle: const TextStyle(color: Colors.black),
    prefixIcon: const Padding(
      padding: EdgeInsets.only(left: 15, right: 5),
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

  Future<void> _uploadPicture() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedImage =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    }
  }


  @override
  void initState() {
    if (widget.scholar != null) {
      _fullNameController.text = widget.scholar!.scholarName;
      _schoolNameController.text = widget.scholar!.scholarSchool;
      _classLevelController.text = widget.scholar!.classLevel;
    }
    super.initState();
  }
  // @override
  // void didChangeDependencies() {
  //   if (widget.scholar != null) {
  //     _fullNameController.text = widget.scholar!.scholarName;
  //     _schoolNameController.text = widget.scholar!.scholarSchool;
  //     _classLevelController.text = widget.scholar!.classLevel;
  //   }
  //   super.didChangeDependencies();
  // }

  void addScholar() async {
    final scholarProvider =
        Provider.of<ScholarProvider>(context, listen: false);

    // Validate inputs
    if (_fullNameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text("Please enter a name"),
            duration: Duration(milliseconds: 500)),
      );
      return; // Exit function if validation fails
    }

    if (_schoolNameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text("Please enter the school name"),
            duration: Duration(milliseconds: 500)),
      );
      return; // Exit function if validation fails
    }

    if (_classLevelController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text("Please enter the class level"),
            duration: Duration(milliseconds: 500)),
      );
      return; // Exit function if validation fails
    }

    // Create new Scholar object
    Scholar newScholar = Scholar.forPost(
      scholarName: _fullNameController.text,
      scholarSchool: _schoolNameController.text,
      classLevel: _classLevelController.text,
    );

    // Add scholar and handle the result
    bool res = await scholarProvider.addScholar(newScholar);
    if (res) {
      await scholarProvider.getAllScholars();

      // Clear the fields
      _fullNameController.clear();
      _schoolNameController.clear();
      _classLevelController.clear();

      // Show success Snackbar with a short duration
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text("New scholar added"),
            duration: Duration(milliseconds: 500)),
      );
      print("New scholar added from screen add scholar");
    } else {
      // Show error Snackbar with a short duration
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text("Something went wrong, try again."),
            duration: Duration(milliseconds: 500)),
      );
      print("Something went wrong");
    }
  }

  void updateScholar() async {
    final scholarProvider =
        Provider.of<ScholarProvider>(context, listen: false);

    // Validate inputs
    if (_fullNameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text("Please enter a name"),
            duration: Duration(milliseconds: 500)),
      );
      return; // Exit function if validation fails
    }

    if (_schoolNameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text("Please enter the school name"),
            duration: Duration(milliseconds: 500)),
      );
      return; // Exit function if validation fails
    }

    if (_classLevelController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text("Please enter the class level"),
            duration: Duration(milliseconds: 500)),
      );
      return; // Exit function if validation fails
    }

    // Create new Scholar object
    Scholar newScholar = Scholar(
      scholarId: widget.scholar!.scholarId,
      scholarName: widget.scholar!.scholarName,
      scholarSchool: widget.scholar!.scholarSchool,
      classLevel: widget.scholar!.classLevel,
    );
    print(newScholar.scholarName);
    // Add scholar and handle the result
    bool res = await scholarProvider.updateScholar(newScholar);
    if (res) {
      await scholarProvider.getAllScholars();

      // Clear the fields
      _fullNameController.clear();
      _schoolNameController.clear();
      _classLevelController.clear();

      // Show success Snackbar with a short duration
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text("New scholar added"),
            duration: Duration(milliseconds: 500)),
      );
      print("New scholar added from screen add scholar");
    } else {
      // Show error Snackbar with a short duration
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text("Something went wrong, try again."),
            duration: Duration(milliseconds: 500)),
      );
      print("Something went wrong");
    }
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _schoolNameController.dispose();
    _classLevelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isKeyboardVisible =
        KeyboardVisibilityProvider.isKeyboardVisible(context);
    final scholarProvider =
        Provider.of<ScholarProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.scholar != null ? "Edit Scholar" : "Add Scholar",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: neutralWhite,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 3,
        shadowColor: Colors.grey,
      ),
      backgroundColor: neutralWhite,
      body: scholarProvider.isLoading
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
                    padding: const EdgeInsets.all(16),
                    children: [
                      const SizedBox(height: 16),
                      // Scholar Picture Upload
                      GestureDetector(
                        onTap: _uploadPicture,
                        child: Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            shape: BoxShape.circle,
                            border: Border.all(color: kColorPrimary, width: 2),
                            image: _selectedImage != null
                                ? DecorationImage(
                                    image: FileImage(_selectedImage!),
                                    fit: BoxFit.cover,
                                  )
                                : null,
                          ),
                          child: _selectedImage == null
                              ? const Icon(
                                  Icons.camera_alt,
                                  size: 50,
                                  color: kColorPrimary,
                                )
                              : null,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Full Name Field
                      TextField(
                        controller: _fullNameController,
                        decoration: _textFieldDecoration.copyWith(
                          labelText: "Full Name",
                          hintText: "Enter scholar's full name",
                          prefixIcon: const Icon(Icons.person),
                        ),
                      ),
                      const SizedBox(height: 10),

                      // School Name Field
                      TextField(
                        controller: _schoolNameController,
                        decoration: _textFieldDecoration.copyWith(
                          labelText: "School Name",
                          hintText: "Enter school name",
                          prefixIcon: const Icon(Icons.school),
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Class Level Field
                      TextField(
                        controller: _classLevelController,
                        decoration: _textFieldDecoration.copyWith(
                          labelText: "Class Level",
                          hintText: "Enter class level (e.g., Grade 10)",
                          prefixIcon: const Icon(Icons.grade),
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: !isKeyboardVisible,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: InkWell(
                      onTap: widget.scholar!=null ? updateScholar :addScholar,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: colorPrimary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text(
                          "Save",
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
                ),
              ],
            ),
    );
  }
}
