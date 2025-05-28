import 'package:dr_dashbord/views/side_bar_screens/widgets/order_list_widget.dart';
import 'package:flutter/material.dart';

class OrdersScreen extends StatelessWidget {
  static const String id = 'orders-screen';
  const OrdersScreen({super.key});

  Widget rowHeader(int flex, String text) {
    return Expanded(
      flex: flex,
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 219, 217, 217),
          border: Border.all(color: const Color.fromARGB(255, 0, 0, 0)),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(255, 0, 0, 0),
          ),
        ),
      ),);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              alignment: Alignment.topLeft,
              child: Text(
                'Manage Order',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            ),
          ),
          Row(
            children: [
              rowHeader(1, 'Image'),
              rowHeader(3, 'Full Name'),
              rowHeader(2, 'Address'),
              rowHeader(1, 'Action'),
              rowHeader(1, 'Reject'),
            ],
          ),
          OrderListWidget(),
        ],
      ),
    );
  }
}