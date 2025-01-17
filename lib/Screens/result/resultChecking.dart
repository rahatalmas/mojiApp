import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/Screens/result/models/ErrorResponse.dart';
import 'package:quizapp/Screens/result/models/successResponse.dart';
import 'package:quizapp/Screens/result/paperProcessingResult.dart';
import 'package:quizapp/Widgets/examFilter.dart';
import 'dart:io';
import 'package:quizapp/constant.dart';
import 'package:http/http.dart' as http;
import 'package:quizapp/providers/answerProvider.dart';
import 'package:quizapp/providers/examProvider.dart';
import 'package:quizapp/providers/resultProvider.dart';

class ResultCheckScreen extends StatefulWidget {
  const ResultCheckScreen({super.key});

  @override
  State<ResultCheckScreen> createState() => _ResultCheckScreen();
}

class _ResultCheckScreen extends State<ResultCheckScreen> {
  bool _isloading = false;
  int counter = 0;
  final ImagePicker _picker = ImagePicker();
  List<XFile>? selectedImages = [];

  List<SuccessResponse> _results = [];
  List<ErrorResponse> _errors = [];
  late AnswerProvider answerProvider;
  late ResultProvider resultProvider;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      answerProvider = Provider.of<AnswerProvider>(context, listen: false);
      resultProvider = Provider.of<ResultProvider>(context,listen: false);
    });
  }
  Future<void> _pickImage() async {
    final List<XFile> pickedFiles = await _picker.pickMultiImage();

    setState(() {
      selectedImages!.addAll(pickedFiles);
    });
  }

  void _resetResults() {
    setState(() {
      _results.clear();
      _errors.clear();
    });
  }
  //omr cheking function ...
  Future<void> _uploadImages(int examId) async {
    if (selectedImages == null || selectedImages!.isEmpty) {
      print("No images selected");
      return;
    }
    answerProvider.getAllAnswers(examId);
    if (answerProvider.answers.length == 0) {
      // Show Snackbar
      Future.delayed(Duration.zero, () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('There are answers available!'),
            duration: Duration(seconds: 1),
          ),
        );
      });
      return;
    }

    List<SuccessResponse> successResponses = [];
    List<ErrorResponse> errorResponses = [];
    setState(() {
      _isloading = true;
    });
    for (XFile image in selectedImages!) {
      setState(() {
        counter = counter+1;
      });
      try {
        print("Uploading: ${image.name}");
        final request = http.MultipartRequest(
          'POST',
          Uri.parse('$OMR_URL/getomr'),
        );

        request.fields['examId'] = examId.toString();
        request.files.add(await http.MultipartFile.fromPath('image', image.path));

        final response = await request.send();
        final responseBody = await response.stream.bytesToString();
        final Map<String, dynamic> jsonData = json.decode(responseBody);

        if (response.statusCode == 200) {
          final successResponse = SuccessResponse.fromJson(jsonData);
          successResponses.add(successResponse);
        } else {
          final errorResponse = ErrorResponse.fromJson(jsonData);
          errorResponses.add(errorResponse);
        }
      } catch (e) {
        errorResponses.add(ErrorResponse(
          message: "Error uploading ${image.name}: $e",
          serialNumber: 0,
        ));
      }
    }
    await resultProvider.getAllResults();
    if (mounted) {
      setState(() {
        _results.addAll(successResponses);
        _errors.addAll(errorResponses);
        selectedImages = [];
        counter=0;
        _isloading = false;
      });

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PaperProcessingResult(
            success: _results,
            errors: _errors,
          ),
        ),
      ).then((_) {
        print("paper processing popped");
        _resetResults();
      });

    }
  }



  void _viewAllImages() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ImageListScreen(
          images: selectedImages ?? [],
          onImageRemoved: (index) {
            setState(() {
              selectedImages!.removeAt(index);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int imageCount = selectedImages?.length ?? 0;
    final _examProvider = Provider.of<ExamProvider>(context, listen: true);
    return
      _isloading?
          Column(
            children: [
              Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Lottie.asset("assets/images/animations/resultCheckingLoader.json",width: 350,height: 350),
                      Text("Checking Papers...",style: TextStyle(fontSize: 18),),
                      Text('Completed: ${counter}/${selectedImages!.length}')
                    ],
                  )
              )
            ],
          ):
      ListView(
      children: [
        ExamFilterWidget(),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: brandMinus3,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: imageCount > 0
                      ? Image.file(
                    File(selectedImages![0].path),
                    fit: BoxFit.cover,
                  )
                      : const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.filter),
                        Text("No Image Selected")
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 5),
            Expanded(
              flex: 1,
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: _pickImage,
                    child: const Center(
                      child: Icon(
                        Icons.add_a_photo,
                        size: 30,
                        color: colorPrimary,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 2),
        Row(
          children: [
            if (imageCount > 1)
              Expanded(
                flex: 2,
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.green[100],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.file(
                      File(selectedImages![1].path),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            const SizedBox(width: 2),
            if (imageCount > 2)
              Expanded(
                flex: 2,
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.green[100],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.file(
                      File(selectedImages![2].path),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            const SizedBox(width: 2),
            if (imageCount > 3)
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: _viewAllImages,
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.green[100],
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Text(
                        '+${imageCount - 3}',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 10),
        selectedImages!.length > 0
            ? InkWell(
          child: Container(
            padding: EdgeInsets.all(8),
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: colorPrimary,
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: Text(
              "Check Papers",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
          onTap: (){
            print(selectedImages);
            _examProvider.selectedExam != null
                ? _uploadImages(_examProvider.selectedExam!.id)
                : print("No exam selected");
          },
        )
            : Center(
          child: Column(
            children: [
              Lottie.asset("assets/images/animation3.json"),
              Text("Select Answer papers")
            ],
          ),
        )
      ],
    );
  }
}




// all images
class ImageListScreen extends StatefulWidget {
  final List<XFile> images;
  final Function(int) onImageRemoved;

  const ImageListScreen({super.key, required this.images, required this.onImageRemoved});

  @override
  _ImageListScreenState createState() => _ImageListScreenState();
}

class _ImageListScreenState extends State<ImageListScreen> {
  late List<XFile> currentImages;

  @override
  void initState() {
    super.initState();
    currentImages = List.from(widget.images);
  }

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final List<XFile>? pickedFiles = await _picker.pickMultiImage();

    if (pickedFiles != null) {
      setState(() {
        currentImages.addAll(pickedFiles);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selected Images'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_a_photo),
            onPressed: _pickImage,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: currentImages.length,
        itemBuilder: (context, index) {
          return ListTile(
            contentPadding: const EdgeInsets.all(8.0),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.file(
                File(currentImages[index].path),
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            ),
            title: Text('Image ${index + 1}'),
            trailing: IconButton(
              icon: const Icon(Icons.remove_circle, color: Colors.red),
              onPressed: () {
                setState(() {
                  currentImages.removeAt(index); // Update the current list
                  widget.onImageRemoved(index); // Notify parent about removal
                });
              },
            ),
          );
        },
      ),
    );
  }
}
