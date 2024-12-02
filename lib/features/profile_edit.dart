import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileEdit extends StatefulWidget {
  const ProfileEdit({super.key});

  @override
  _ProfileEditState createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController(text: 'Yebe');
  final TextEditingController usernameController = TextEditingController(text: '@loveyebe');
  final TextEditingController emailController = TextEditingController(text: 'yebedebi@gmail.com');
  final TextEditingController bioController = TextEditingController(text: 'Enter bio here.');
  File? _profileImage;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        backgroundColor: Colors.lightBlue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: _profileImage != null
                      ? FileImage(_profileImage!) as ImageProvider
                      : AssetImage('assets/logo.png'),
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.white70,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _buildEditable(nameController, 'Name'),
              const SizedBox(height: 16),
              _buildEditable(usernameController, 'Username'),
              const SizedBox(height: 16),
              _buildEditable(emailController, 'Email'),
              const SizedBox(height: 16),
              _buildEditable(bioController, 'Bio'),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    Navigator.pop(context, {
                      'name': nameController.text,
                      'username': usernameController.text,
                      'email': emailController.text,
                      'bio': bioController.text,
                      'profileImage': _profileImage,
                    });
                  }
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEditable(TextEditingController controller, String label) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: label, border: OutlineInputBorder()),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
    );
  }
}
