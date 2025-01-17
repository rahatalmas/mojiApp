import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/Screens/admin/adminAddScreen.dart';
import 'package:quizapp/constant.dart';
import 'package:quizapp/handler/apis/login.dart';

import '../../providers/adminProvider.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {

  late AdminProvider _adminProvider;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _adminProvider = context.watch<AdminProvider>();
    if (!_adminProvider.dataUpdated) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _adminProvider.getAllAdmins();
      });
    }
  }

  // Profile owner data
  String profileOwnerName = Auth().loginData!.username;
  String profileOwnerRole =
      Auth().loginData!.permission == 1 ? "Admin" : "Editor";

  // Selected filter
  String selectedFilter = "All";

  // Method to show the filter bottom sheet
  void showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              ListTile(
                title: const Text("All"),
                onTap: () {
                  setState(() {
                    selectedFilter = "All";
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text("Admin"),
                onTap: () {
                  setState(() {
                    selectedFilter = "Admin";
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text("Editor"),
                onTap: () {
                  setState(() {
                    selectedFilter = "Editor";
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text("Moderator"),
                onTap: () {
                  setState(() {
                    selectedFilter = "Moderator";
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

  @override
  Widget build(BuildContext context) {

    final adminProvider = Provider.of<AdminProvider>(context,listen:true);
    final roles = {
      "admin_key":"Admin",
      "editor_key":"Editor"
    };
    final filteredList = selectedFilter == "All"
        ? adminProvider.admins
        :
    //adminProvider.admins;
    adminProvider.admins.where((admin) => roles[admin.adminRoleKey] == selectedFilter).toList();


    return Scaffold(
      backgroundColor: neutralWhite,
      appBar: AppBar(
        title: Text("admin"),
        backgroundColor: neutralWhite,
        elevation: 3,
        shadowColor: Colors.grey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Profile Owner Section
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: BoxDecoration(
                color: neutralBG,
                borderRadius: BorderRadius.circular(15),
                //border: Border.all(color:kColorPrimary, width: 3),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        child: Image.asset("assets/images/man2.png"),
                        radius: 35,
                        backgroundColor: Colors.white,
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  profileOwnerName,
                                  style: TextStyle(
                                    color: Colors.brown[800],
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                // GestureDetector(
                                //   onTap: () => {print("profile edit button")},
                                //   // Edit profile
                                //   child: Row(
                                //     children: [
                                //       Text(
                                //         "edit",
                                //         style: TextStyle(
                                //             color: Colors.black87,
                                //             fontSize: 16,
                                //             fontWeight: FontWeight.w400),
                                //       ),
                                //       Icon(
                                //         Icons.edit_note,
                                //         color: Colors.black87,
                                //       ),
                                //     ],
                                //   ),
                                // ),
                              ],
                            ),
                            Text(
                              "Role: $profileOwnerRole",
                              style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(height: 10),
                            InkWell(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AdminAddScreen()),
                              ), // Add New User
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: colorPrimary,
                                  //border: Border.all(color: Colors.indigo, width: 1),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text(
                                      "Add New",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Icon(
                                      Icons.new_label_outlined,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            // Admin List Header
            GestureDetector(
              onTap: showFilterBottomSheet, // Open filter bottom sheet
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: const [
                      Text("Admin List"),
                      SizedBox(width: 5),
                      Icon(Icons.list),
                    ],
                  ),
                  Row(
                    children: const [
                      Text("Filter"),
                      SizedBox(width: 2),
                      Icon(Icons.filter_alt_outlined),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            // Admin List
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: filteredList.length,
              itemBuilder: (context, index) {
                final admin = filteredList[index];
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 5,horizontal: 4),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: neutralWhite,
                      borderRadius: BorderRadius.circular(12),
                      //border: Border.all(color: Colors.deepPurple, width: 1),
                      boxShadow: [
                        BoxShadow(color: Colors.black26, blurRadius: 1)
                      ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage("assets/images/man.png"),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              admin.adminUsername,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.brown[800],
                              ),
                            ),
                            Text(
                              "Role: ${roles[admin.adminRoleKey]}",
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (profileOwnerRole == "Admin")
                        Row(
                          children: [
                            // IconButton(
                            //   onPressed: () {
                            //     print('edit button');
                            //   },
                            //   icon:
                            //   Icon(Icons.edit, color: colorPrimary),
                            // ),
                            IconButton(
                              onPressed: ()async {
                                print('delete button');
                                bool res = await adminProvider.deleteAdmin(filteredList[index].adminId!);
                                print(res);
                              },
                              icon:
                                  Icon(Icons.delete, color: Colors.red[900]),
                            ),
                          ],
                        ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
