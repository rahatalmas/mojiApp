import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/Screens/candidate/ItemWrapper.dart';
import 'package:quizapp/Screens/exam/dummyExamList.dart';
import 'package:quizapp/Widgets/examFilter.dart';
import 'package:quizapp/Widgets/selectableScholarList.dart';
import 'package:quizapp/constant.dart';
import 'package:quizapp/database/models/candidate.dart';
import 'package:quizapp/providers/candidateProvider.dart';
import 'package:quizapp/providers/examProvider.dart';

class CandidateEditor extends StatefulWidget {
  const CandidateEditor({super.key});

  @override
  State<CandidateEditor> createState() => _CandidateEditor();
}

class _CandidateEditor extends State<CandidateEditor> {

  final TextEditingController _serialNumberController = TextEditingController();
  final TextEditingController _candidateNameController = TextEditingController();
  final TextEditingController _schoolNameController = TextEditingController();
  final TextEditingController _classLevelController = TextEditingController();

  int _selectedMode = 0; // Selected mode (default value)
  final List<String> _modes = ["Default Editing", "Add from database", "Upload File"];
  final List<Widget> _modeScreens = []; // for later adjustments ...

  File? _selectedFile; // Store selected file

  // Open bottom modal for mode selection
  void _showModeSelectionModal() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Select Mode",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text("Default Editing"),
                onTap: () {
                  setState(() {
                    _selectedMode = 0;
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.storage),
                title: const Text("Add from Database"),
                onTap: () {
                  setState(() {
                    _selectedMode = 1;
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.upload_file),
                title: const Text("Upload File"),
                onTap: () {
                  setState(() {
                    _selectedMode = 2;
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // Open file picker for selecting file (CSV or Excel)
  void _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv', 'xls', 'xlsx'],
    );

    if (result != null) {
      setState(() {
        _selectedFile = File(result.files.single.path!);
      });
    }
  }

  // Method to add a candidate
  void _addCandidate() async{
    final serialNumber = _serialNumberController.text;
    final candidateName = _candidateNameController.text;
    final schoolName = _schoolNameController.text;
    final classLevel = _classLevelController.text;

    if (serialNumber.isEmpty ||
        candidateName.isEmpty ||
        schoolName.isEmpty ||
        classLevel.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }
    final candidateProvider = Provider.of<CandidateProvider>(context,listen: false);
    final examProvider = Provider.of<ExamProvider>(context, listen: false);
    Candidate newCandidate = Candidate(
        serialNumber: int.parse(serialNumber),
        name: candidateName,
        schoolName: schoolName,
        classLevel: classLevel,
        examId: examProvider.selectedExam!.id
    );
    bool res = await candidateProvider.addCandidate(newCandidate);
    if(res){
      await candidateProvider.getAllCandidates(examProvider.selectedExam!.id);
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('failed to add candidate')),
      );
    }
    // Clear the input fields after adding the candidate
    setState(() {
      _serialNumberController.clear();
      _candidateNameController.clear();
      _schoolNameController.clear();
      _classLevelController.clear();
    });
  }

  // Input field decoration (used for all fields)
  final InputDecoration _textFieldDecoration = InputDecoration(
    labelText: "Type here...",
    hintText: "Enter value",
    hintStyle: const TextStyle(color: Colors.black),
    labelStyle: const TextStyle(color: Colors.black),
    prefixIcon: const Icon(Icons.input, size: 20, color: appTextPrimary),
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

  // Build text field with the provided label, controller, and icon
  Widget _buildTextField(String label, TextEditingController controller, IconData icon) {
    return TextField(
      controller: controller,
      decoration: _textFieldDecoration.copyWith(
        labelText: label,
        hintText: "Enter $label",
        prefixIcon: Icon(icon, size: 20, color: appTextPrimary),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final examProvider = Provider.of<ExamProvider>(context, listen: true);
    final candidateProvider = Provider.of<CandidateProvider>(context,listen: true);
    return
      ListView(
      children: [
        ExamFilterWidget(),
        const SizedBox(height: 10),
        examProvider.selectedExam == null
            ?
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min, // Ensures the column takes minimal space
            children: [
              const SizedBox(height: 100),
              Image.asset(
                "assets/images/student.png",
                height: 200,
                width: 200,
              ),
              const SizedBox(height: 25),
              const Text(
                "Select an exam to add Candidate",
                //style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ),
            ],
          ),
        )
            :
        examProvider.selectedExam!.numberOfCandidates == candidateProvider.candidates.length
            ?
        Center(
            child:Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 100),
                Lottie.asset("assets/images/complete2.json",height: 150),
                Text("Registration Complete",style: TextStyle(fontSize:20,color: colorPrimary,fontWeight: FontWeight.w500),),
                Text('Total Candidates: ${examProvider.selectedExam!.totalQuestions}'),
                Text('Exam Date: 20/12/24')
              ],
            )
        )
            :
        Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          decoration:const BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              color: neutralBG),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Mode and info
              InkWell(
                onTap: _showModeSelectionModal,
                child: Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  decoration: const BoxDecoration(
                    border: BorderDirectional(
                      bottom: BorderSide(color: Colors.green, width: 5),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const CircleAvatar(
                                radius: 4,
                                backgroundColor: Colors.purple,
                              ),
                              const SizedBox(width: 4),
                              const CircleAvatar(
                                radius: 4,
                                backgroundColor: Colors.indigo,
                              ),
                              const SizedBox(width: 4),
                              const CircleAvatar(
                                radius: 4,
                                backgroundColor: Colors.cyan,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                _modes[_selectedMode],
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                          const Icon(Icons.edit_road)
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Candidate - ${candidateProvider.candidates.length+1}',
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                          ),
                          Row(
                            children: [
                              Text(
                                'Total: ${examProvider.selectedExam!.numberOfCandidates}',
                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Remaining: ${(examProvider.selectedExam!.numberOfCandidates)-(candidateProvider.candidates.length)}',
                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Response from server
              Container(
                height: 150,
                width: double.maxFinite,
                decoration: BoxDecoration(
                    color: neutralWhite,
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: candidateProvider.candidates.length > 0 ?
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/man.png",height: 100,width: 100,),
                      SizedBox(height: 8,),
                      Text('last Added: ${candidateProvider.candidates[candidateProvider.candidates.length-1].serialNumber}'),
                    ],
                  )
                      :
                  Center(child: Text("no candidates added yet"))
                ),
              ),
              const SizedBox(height: 16),
              // Mode selection
              _selectedMode == 0
                  ?
              Column(
                children: [
                  _buildTextField("Serial Number", _serialNumberController, Icons.confirmation_number),
                  const SizedBox(height: 10),
                  _buildTextField("Candidate Name", _candidateNameController, Icons.person),
                  const SizedBox(height: 10),
                  _buildTextField("School Name", _schoolNameController, Icons.school),
                  const SizedBox(height: 10),
                  _buildTextField("Class Level", _classLevelController, Icons.grade),
                  const SizedBox(height: 16),
                  InkWell(
                    onTap: _addCandidate,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: colorPrimary,
                        borderRadius: const BorderRadius.all(Radius.circular(15)),
                        border: Border.all(color: Colors.black87, width: 2),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Add",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Icon(Icons.add, color: Colors.white),
                        ],
                      ),
                    ),
                  ),
                ],
              )
                  :
              _selectedMode == 2
                  ?
              Column(
                  children: [
                    InkWell(
                      onTap: _pickFile,
                      child: Container(
                      width: double.maxFinite,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: brandMinus3,
                        borderRadius: BorderRadius.circular(8)
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.file_copy_rounded),
                          const SizedBox(height: 8),
                          const Text(
                            "Pick a file (CSV/Excel)",
                            style: TextStyle(fontSize: 16, color: colorPrimary),
                          ),
                        ],
                      ),
                    )
                    ),
                    SizedBox(height: 16,),
                    InkWell(
                      onTap: (){
                        print("file upload");
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: colorPrimary,
                          borderRadius: const BorderRadius.all(Radius.circular(15)),
                          border: Border.all(color: Colors.black87, width: 2),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Save",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            SizedBox(width: 3,),
                            Icon(Icons.save_as, color: Colors.white),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
                  :
              ScholarList2(examId:examProvider.selectedExam!.id),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _serialNumberController.dispose();
    _candidateNameController.dispose();
    _schoolNameController.dispose();
    _classLevelController.dispose();
    super.dispose();
  }
}
