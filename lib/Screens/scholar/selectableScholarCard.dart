import 'package:flutter/material.dart';
import 'package:quizapp/constant.dart';

class SelectableScholarCard extends StatelessWidget {
  final int scholarId;
  final String scholarName;
  final String? scholarPicture;
  final String schoolName;
  final String classLevel;
  final bool isMarked;

  const SelectableScholarCard({
    Key? key,
    required this.scholarId,
    required this.scholarName,
    required this.scholarPicture,
    required this.schoolName,
    required this.classLevel,
    required this.isMarked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 4),
      color: neutralWhite,
      shadowColor: Colors.black87,
      elevation: 4,
      child: ListTile(
        leading: CircleAvatar(backgroundImage: AssetImage("assets/images/man.png")),
        title: Text(scholarName),
        subtitle: Text('$schoolName, $classLevel'),
        trailing: isMarked
            ? const Icon(Icons.check_circle, color: Colors.green)
            : const Icon(Icons.circle_outlined, color: Colors.grey),
      ),
    );
  }
}