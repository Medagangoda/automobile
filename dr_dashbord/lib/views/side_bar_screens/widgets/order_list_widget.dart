import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderListWidget extends StatelessWidget {
  const OrderListWidget({super.key});

  Widget orderDisplayData(Widget widget, int? flex) {
    return Expanded(
      flex: flex!,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 218, 216, 216),
          ),
          child: Padding(
            padding: EdgeInsets.all(8),
            child: widget,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _ordersStream =
        FirebaseFirestore.instance.collection('orders').snapshots();

    return StreamBuilder<QuerySnapshot>(
      stream: _ordersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return LinearProgressIndicator();
        }

        return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data!.size,
            itemBuilder: (context, index) {
              final orderData = snapshot.data!.docs[index];
              return Row(
                children: [
                  orderDisplayData(
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: Image.network(
                          orderData['productImage'],
                        ),
                      ),
                      1),
                  orderDisplayData(Text(orderData['fullName']), 3),
                  orderDisplayData(
                      Text('${orderData['state']} ${orderData['locality']}'),
                      2),
                  orderDisplayData(
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                          ),
                          onPressed: () async {
                            await FirebaseFirestore.instance
                                .collection('orders')
                                .doc(orderData['orderId'])
                                .update({
                              'delivered': true,
                              'processing': false,
                              'deliveredCount': FieldValue.increment(1),
                            });
                          },
                          child: orderData['delivered'] == true
                              ? Text('Delivered',
                                  style: TextStyle(color: Colors.white))
                              : Text('Mark Delivered',
                                  style: TextStyle(color: Colors.white))),
                      1),
                  orderDisplayData(
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          onPressed: () async {
                            await FirebaseFirestore.instance
                                .collection('orders')
                                .doc(orderData['orderId'])
                                .update({
                              'processing': false,
                              'delivered': false,
                            });
                          },
                          child: Text(
                            'Cancel',
                            style: TextStyle(color: Colors.white),
                          )),
                      1),
                ],
              );
            });
      },
    );
  }
}
