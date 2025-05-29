
import 'package:flutter/material.dart';

class BuyersScreen extends StatelessWidget {
  static const String id = '/BuyersScreen';
  const BuyersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Buyers Screen',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

}