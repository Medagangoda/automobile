import 'package:badges/badges.dart' as badges;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dr_store/views/screens/inner_screens/order_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';

import 'edit_profile_screen.dart';


class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final ImagePicker _picker = ImagePicker();

  Uint8List? _imageBytes;

  Future<void> _pickAndUploadImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      _imageBytes = await image.readAsBytes();
      final downloadUrl = await FirebaseStorage.instance
          .ref('profileImages/${_auth.currentUser!.uid}')
          .putData(_imageBytes!)
          .then((snapshot) => snapshot.ref.getDownloadURL());

      await _firestore.collection('buyers').doc(_auth.currentUser!.uid).update({
        'profileImage': downloadUrl,
      });

      setState(() {});
    }
  }

  PreferredSize buildProfileAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(130),
      child: Container(
        width: double.infinity,
        height: 130,
        clipBehavior: Clip.hardEdge,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/searchBanner.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              left: 20,
              top: 52,
              child: Icon(Icons.person_outline,
                  color: Colors.white, size: 28),
            ),
            Positioned(
              left: 61,
              top: 51,
              child: Text(
                'PROFILE',
                style: GoogleFonts.lato(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1.5,
                ),
              ),
            ),
            Positioned(
              right: 20,
              top: 50,
              child: Stack(
                children: [
                  Image.asset(
                    'assets/icons/message.png',
                    width: 42,
                    height: 45,
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: badges.Badge(
                      badgeStyle: badges.BadgeStyle(
                        badgeColor: const Color.fromARGB(255, 255, 59, 55),
                      ),
                      badgeContent: Text(
                        '0', // ← Replace with dynamic wishlist count if needed
                        style: GoogleFonts.lato(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_auth.currentUser == null) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.yellow.shade800,
          title: const Text("PROFILE"),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              // Navigate to login screen
            },
            child: const Text("Login to view profile"),
          ),
        ),
      );
    }

    final userDoc = _firestore.collection('buyers').doc(_auth.currentUser!.uid);

    return Scaffold(
      appBar: buildProfileAppBar(),
      body: StreamBuilder<DocumentSnapshot>(
        stream: userDoc.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final userData = snapshot.data!.data() as Map<String, dynamic>;

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const SizedBox(height: 20),
                CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.yellow.shade800,
                  backgroundImage: userData['profileImage'] != ""
                      ? NetworkImage(userData['profileImage'])
                      : null,
                  child: userData['profileImage'] == ""
                      ? const Icon(Icons.person, size: 50, color: Colors.white)
                      : null,
                ),
                TextButton(
                  onPressed: _pickAndUploadImage,
                  child: Text(
                    "Change Profile Image",
                    style: GoogleFonts.lato(fontSize: 14),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  userData['fullName'] ?? "No Name",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  userData['email'] ?? "No Email",
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  icon: const Icon(Icons.edit),
                  label: const Text("Edit Profile"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow.shade800,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              EditProfileScreen(userData: userData)),
                    );
                  },
                ),
                const SizedBox(height: 10),
                ElevatedButton.icon(
                  icon: const Icon(Icons.shopping_bag),
                  label: const Text("My Orders"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) =>  OrderScreen()));
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
