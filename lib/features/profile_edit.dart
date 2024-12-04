import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileEdit extends StatefulWidget {
  const ProfileEdit({super.key});

  @override
  _ProfileEditState createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController(text: 'Yebe');
  final TextEditingController _usernameController = TextEditingController(text: '@loveyebe');
  final TextEditingController _emailController = TextEditingController(text: 'yebedebi@gmail.com');
  final TextEditingController _bioController = TextEditingController(text: 'Enter bio here.');
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
      appBar: _buildAppBar(),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF003366), // Deep blue
              Color(0xFF006699), // Lighter deep blue
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: _profileImage != null
                        ? FileImage(_profileImage!) as ImageProvider
                        : AssetImage('assets/yebe.png'),
                    backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                    child: Icon(
                      Icons.camera_alt,
                      color: Colors.white70,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Name
                _buildEditableField(_nameController, 'Name'),
                const SizedBox(height: 16),

                // Username
                _buildEditableField(_usernameController, 'Username'),
                const SizedBox(height: 16),

                // Email Address
                _buildEditableField(_emailController, 'Email'),
                const SizedBox(height: 16),

                // Bio
                _buildEditableField(_bioController, 'Bio'),
                const SizedBox(height: 32),

                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.pop(context, {
                        'name': _nameController.text,
                        'username': _usernameController.text,
                        'email': _emailController.text,
                        'bio': _bioController.text,
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
      ),
    );
  }

  // Method for AppBar
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Text(
        "Edit Profile",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      backgroundColor: const Color(0xFF003366), // Deep Blue background
      elevation: 0,
      centerTitle: true,
      automaticallyImplyLeading: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.save),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              Navigator.pop(context, {
                'name': _nameController.text,
                'username': _usernameController.text,
                'email': _emailController.text,
                'bio': _bioController.text,
                'profileImage': _profileImage,
              });
            }
          },
        ),
      ],
    );
  }

  // Method for editable fields with neon style
  Widget _buildEditableField(TextEditingController controller, String label) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white), // Neon white color
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 255, 255, 255), width: 2), // Neon border
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 255, 255, 255), width: 2), // Neon focus border
        ),
        border: const OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
    );
  }
}
