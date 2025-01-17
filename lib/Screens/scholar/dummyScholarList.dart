import 'package:quizapp/Screens/scholar/scholarScreen.dart';
class DummyScholar {
  final String scholarId;
  final String scholarName;
  final String? scholarPicture;
  final String schoolName;
  final String classLevel;

  DummyScholar({
    required this.scholarId,
    required this.scholarName,
    this.scholarPicture,
    required this.schoolName,
    required this.classLevel,
  });
}

List<DummyScholar> scholars = [
  DummyScholar(
    scholarId: '1',
    scholarName: 'Alice Johnson',
    scholarPicture: null,
    schoolName: 'Greenwood High',
    classLevel: 'Grade 10',
  ),
  DummyScholar(
    scholarId: '2',
    scholarName: 'Bob Smith',
    scholarPicture: null,
    schoolName: 'Sunrise Academy',
    classLevel: 'Grade 12',
  ),
  DummyScholar(
    scholarId: '3',
    scholarName: 'Charlie Brown',
    scholarPicture: null,
    schoolName: 'Sujanar Model Pilot High School Pabna',
    classLevel: 'Grade 9',
  ),
];