import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShippingAddressScreen extends StatefulWidget {
  const ShippingAddressScreen({super.key});

  @override
  State<ShippingAddressScreen> createState() => _ShippingAddressScreenState();
}

class _ShippingAddressScreenState extends State<ShippingAddressScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String state;
  late String city;
  late String locality;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.95),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white.withOpacity(0.95),
        title: Text(
          'Delivery',
          style: GoogleFonts.roboto(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: const Color(0xff363330),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                  'Where will your order \nbe shipped',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff363330),
                      letterSpacing: 2),
                ),
                TextFormField(
                  onChanged: (value) {
                    state = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'enter filed';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'State',
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  onChanged: (value) {
                    city = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'enter filed';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'City',
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  onChanged: (value) {
                    locality = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'enter filed';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'Locality',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: InkWell(
          onTap: () async {
            if (_formKey.currentState!.validate()) {
              // Perform the action to add the address
              _showDialog(context);
              await _firestore
                  .collection('buyers')
                  .doc(_auth.currentUser!.uid)
                  .update({
                'state': state,
                'city': city,
                'locality': locality,
              }).whenComplete(() {
                Navigator.of(context).pop();
                setState(() {
                  _formKey.currentState!.validate();
                });
              });
            } else {
              // Show an error message or handle validation failure
            }
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 89, 90, 90),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                'Add Address',
                style: GoogleFonts.lato(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false, // user most tap button
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Updating Address'),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 20),
                Text('Please wait while we update your address.'),
              ],
            ),
          );
        });

    Future.delayed(Duration(seconds: 3), () {
      Navigator.of(context).pop();
    });
  }
}
