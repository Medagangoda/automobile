import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class EditProfileScreen extends StatefulWidget {
  final Map<String, dynamic> userData;
  const EditProfileScreen({super.key, required this.userData});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final ImagePicker _picker = ImagePicker();

  late TextEditingController _fullNameController;
  late TextEditingController _emailController;
  Uint8List? _imageBytes;
  String? _profileImageUrl;

  @override
  void initState() {
    super.initState();
    _fullNameController =
        TextEditingController(text: widget.userData['fullName']);
    _emailController = TextEditingController(text: widget.userData['email']);
    _profileImageUrl = widget.userData['profileImage'];
  }

  Future<void> _pickAndUploadImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      _imageBytes = await image.readAsBytes();
      final downloadUrl = await FirebaseStorage.instance
          .ref('profileImages/${_auth.currentUser!.uid}')
          .putData(_imageBytes!)
          .then((snapshot) => snapshot.ref.getDownloadURL());

      setState(() {
        _profileImageUrl = downloadUrl;
      });
    }
  }

  Future<void> _saveChanges() async {
    await _firestore.collection('buyers').doc(_auth.currentUser!.uid).update({
      'fullName': _fullNameController.text,
      'email': _emailController.text,
      'profileImage': _profileImageUrl ?? "",
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red.shade800,
        title: Text('Edit Profile'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: _pickAndUploadImage,
              child: CircleAvatar(
                radius: 60,
                backgroundImage: _profileImageUrl != null && _profileImageUrl!.isNotEmpty
                    ? NetworkImage(_profileImageUrl!)
                    : null,
                child: _profileImageUrl == null || _profileImageUrl!.isEmpty
                    ? Icon(Icons.person, size: 50)
                    : null,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _fullNameController,
              decoration: InputDecoration(
                labelText: 'Full Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 15),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: _saveChanges,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
              child: Text('Save Changes', style: TextStyle(color: Colors.white)),
            )
          ],
        ),
      ),
    );
  }
}
