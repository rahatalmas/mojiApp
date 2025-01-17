import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/Screens/scholar/scholarAddPage.dart';
import 'package:quizapp/Screens/scholar/scholarUpdateScreen.dart';
import 'package:quizapp/constant.dart';
import 'package:quizapp/database/models/scholar.dart';
import 'package:quizapp/providers/scholarProvider.dart';

class ScholarCard extends StatelessWidget {
  final int scholarId;
  final String scholarName;
  final String schoolName;
  final String classLevel;
  final String? scholarPicture; // Nullable

  final Scholar scholar;

  const ScholarCard({
    Key? key,
    required this.scholarId,
    required this.scholarName,
    required this.schoolName,
    required this.classLevel,
    this.scholarPicture,
    required this.scholar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scholarProvider = Provider.of<ScholarProvider>(context, listen: true);
    return Container(
      //shadowColor: Colors.black87,
      //elevation: 4,
      decoration: BoxDecoration(
        border:
            BorderDirectional(bottom: BorderSide(width: 3, color: neutralBG)),
        color: neutralWhite,
      ),
      margin: EdgeInsets.symmetric(vertical: 4),
      child: Slidable(
        key: Key(scholar.scholarId.toString()),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          dismissible: null,
          children: [
            // Edit Button
            SlidableAction(
              onPressed: (context) {
                // Handle edit action
                print("Edit button clicked for $scholarId");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ScholarUpdateScreen(scholarId: scholarId, name: scholarName, schoolName: schoolName, classLevel: classLevel),
                  ),
                );
              },
              backgroundColor: colorPrimary,
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: 'Edit',
            ),
            // Delete Button
            SlidableAction(
              // borderRadius: BorderRadius.only(
              //     topRight:Radius.circular(12),
              //     bottomRight:Radius.circular(12)
              // ),
              onPressed: (context) async {
                // Handle delete action
                print("Delete button clicked for $scholar.scholarId");
                bool res =
                    await scholarProvider.deleteScholar(scholar.scholarId);
                if (res) {
                  print("Scholar deleted");
                }
              },
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profile Picture with Border
              Container(
                width: 75,
                height: 75,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.blueAccent.withOpacity(0.5),
                    width: 3,
                  ),
                  image: scholar.scholarPicture != null
                      ? DecorationImage(
                          image: NetworkImage(scholar.scholarPicture!),
                          fit: BoxFit.cover,
                        )
                      : const DecorationImage(
                          image: AssetImage('assets/images/man.png'),
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      scholar.scholarName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: colorPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'School: ${scholar.scholarSchool}',
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    const SizedBox(height: 1),
                    Text(
                      'Class Level: ${scholar.classLevel}',
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              //swipe icon
              Icon(
                Icons.arrow_back_ios_new_rounded,
                color: colorPrimary,
                size: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
