import 'package:flutter/material.dart';

class ProfileEdit extends StatefulWidget {
  const ProfileEdit({super.key});

  @override
  _ProfileEditState createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Text controllers for editing fields
  final TextEditingController nameController = TextEditingController(text: 'Yebe');
  final TextEditingController usernameController = TextEditingController(text: '@loveyebe');
  final TextEditingController emailController = TextEditingController(text: 'yebedebi@gmail.com');
  final TextEditingController bioController = TextEditingController(text: 'Enter bio here.');

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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profile Picture
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/logo.png'),
                backgroundColor: Colors.grey[300],
              ),
              const SizedBox(height: 16),

              // Editable Name Field
              _buildEditable(nameController, 'Name'),

              // Editable Username Field
              const SizedBox(height: 16),
              _buildEditable(usernameController, 'Username'),

              // Editable Email Field
              const SizedBox(height: 16),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an email';
                  }
                  return null;
                },
              ),

              // Editable Bio Field
              const SizedBox(height: 16),
              _buildEditable(bioController, 'Bio'),

              const SizedBox(height: 32),

              // Save button 
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Profile saved!')),
                    );
                  }
                },
                child: const Text('Save', style: TextStyle(color: Colors.black)), 
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue, 
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0), 
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 40.0), 
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Method to build editable text fields with validation for empty values
  Widget _buildEditable(TextEditingController controller, String label) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
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
