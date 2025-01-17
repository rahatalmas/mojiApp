import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/constant.dart';
import 'package:quizapp/database/models/admin.dart';
import 'package:quizapp/providers/adminProvider.dart';

class AdminAddScreen extends StatefulWidget {
  const AdminAddScreen({super.key});

  @override
  State<AdminAddScreen> createState() => _AdminAddScreenState();
}

class _AdminAddScreenState extends State<AdminAddScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _selectedRole; // To store the selected role
  final List<String> _roles = ["Admin", "Editor", "User"];
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

  // Function to upload the image
  Future<void> _uploadPicture() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    }
  }

  // Function to show the role selection modal
  void _showRoleSelectionModal() {
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
                "Select Role",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              ..._roles.map((role) {
                return ListTile(
                  leading: const Icon(Icons.person),
                  title: Text(role),
                  onTap: () {
                    setState(() {
                      _selectedRole = role;
                    });
                    Navigator.pop(context);
                  },
                );
              }).toList(),
            ],
          ),
        );
      },
    );
  }

  // Function to add the admin user
  void _addAdminUser() async {
    final provider = Provider.of<AdminProvider>(context,listen:false);
    final username = _usernameController.text;
    final password = _passwordController.text;

    if (username.isEmpty || password.isEmpty || _selectedRole == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields and select a role')),
      );
      return;
    }
    Admin newAdmin = Admin(adminUsername: username,password: password, adminRoleKey: _selectedRole!);
    print(newAdmin.adminRoleKey);
    bool res = await provider.addAdmin(newAdmin);
    if(res){
      // Logic to save the user (you can implement your save logic here)
      setState(() {
        _usernameController.clear();
        _passwordController.clear();
        _selectedRole = null;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('added successfully')),
      );
      await provider.getAllAdmins();
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('error occured')),
      );
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add New",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: neutralWhite,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 3,
        shadowColor: Colors.grey,
      ),
      backgroundColor: neutralWhite,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 16),

          // Profile Picture Upload
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

          // Username Field
          TextField(
            controller: _usernameController,
            decoration: _textFieldDecoration.copyWith(
              labelText: "Username",
              hintText: "Enter username",
              prefixIcon: const Icon(Icons.person),
            ),
          ),
          const SizedBox(height: 10),

          // Password Field
          TextField(
            controller: _passwordController,
            obscureText: true,
            decoration: _textFieldDecoration.copyWith(
              labelText: "Password",
              hintText: "Enter password",
              prefixIcon: const Icon(Icons.lock),
            ),
          ),
          const SizedBox(height: 10),

          // Role Selection
          InkWell(
            onTap: _showRoleSelectionModal,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              decoration: BoxDecoration(
                color: neutralWhite,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: kColorSecondary, width: 2),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _selectedRole ?? "Select Role",
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  const Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Add Button
          InkWell(
            onTap: _addAdminUser,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: colorPrimary,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.black87, width: 2),
              ),
              child: const Center(
                child: Text(
                  "Add",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
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
