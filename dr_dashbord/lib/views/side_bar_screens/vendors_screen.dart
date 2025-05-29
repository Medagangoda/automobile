import 'package:flutter/material.dart';

class VendorsScreen extends StatelessWidget {
  static const String id = '/vendorsScreen';
  const VendorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Vendors Screen',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }
}