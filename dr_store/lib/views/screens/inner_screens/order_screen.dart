import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dr_store/views/screens/inner_screens/order_details_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderScreen extends StatelessWidget {
  OrderScreen({super.key});

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> ordersStream = FirebaseFirestore.instance
        .collection('orders')
        .where('buyerId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.2),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 118,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/searchBanner.jpg'),
                fit: BoxFit.cover),
          ),
          child: Stack(
            children: [
              Positioned(
                left: 322,
                top: 52,
                child: Stack(
                  children: [
                    Image.asset(
                      'assets/icons/message.png',
                      width: 42,
                      height: 45,
                    ),
                    // Positioned(
                    //   top: 0,
                    //   right: 0,
                    //   child: badges.Badge(
                    //     badgeStyle: badges.BadgeStyle(
                    //       badgeColor: const Color.fromARGB(255, 255, 59, 55),
                    //     ),
                    //     badgeContent: Text(
                    //       cartData.length.toString(),
                    //       style: GoogleFonts.lato(
                    //         fontSize: 12,
                    //         fontWeight: FontWeight.bold,
                    //         color: Colors.white,
                    //       ),
                    //     ),
                    //   ),
                    // )
                  ],
                ),
              ),
              Positioned(
                left: 61,
                top: 51,
                child: Text('My Order',
                    style: GoogleFonts.lato(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    )),
              ),
            ],
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: ordersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text(
                'You Have No Orders Yet',
                style: GoogleFonts.lato(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final orderData = snapshot.data!.docs[index];
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context, 
                    MaterialPageRoute(builder: (context) {
                      return OrderDetailsScreen(orderData: orderData,);
                    }));
                  },
                  child: Container(
                    width: 335,
                    height: 153,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(),
                    child: SizedBox(
                      width: double.infinity,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                            left: 0,
                            top: 0,
                            child: Container(
                              width: 336,
                              height: 154,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    color: const Color.fromARGB(
                                        255, 224, 224, 224)),
                                borderRadius: BorderRadius.circular(9),
                              ),
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Positioned(
                                    left: 13,
                                    top: 9,
                                    child: Container(
                                      width: 78,
                                      height: 78,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 223, 223, 223),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Stack(
                                        clipBehavior: Clip.none,
                                        children: [
                                          Positioned(
                                            left: 10,
                                            top: 5,
                                            child: Image.network(
                                                orderData['productImage'],
                                                width: 58,
                                                height: 67,
                                                fit: BoxFit.cover),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 101,
                                    top: 14,
                                    child: SizedBox(
                                      width: 216,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: SizedBox(
                                              width: double.infinity,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  SizedBox(
                                                    width: double.infinity,
                                                    child: Text(
                                                      orderData['productName'],
                                                      style: GoogleFonts.lato(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: const Color
                                                            .fromARGB(
                                                            255, 0, 0, 0),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      orderData['category'],
                                                      style: GoogleFonts.lato(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: const Color
                                                            .fromARGB(
                                                            255, 0, 0, 0),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 2,
                                                  ),
                                                  Text(
                                                    '\Rs.${orderData["price"]}',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color:
                                                          const Color.fromARGB(
                                                              255, 90, 23, 23),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 13,
                                    top: 113,
                                    child: Container(
                                      width: 77,
                                      height: 25,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        color: orderData['delivered'] == true
                                            ? const Color.fromARGB(
                                                255, 35, 129, 175)
                                            : orderData['processing'] == true
                                                ? Colors.purple
                                                : Colors.red,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Stack(
                                        clipBehavior: Clip.none,
                                        children: [
                                          Positioned(
                                            left: 9,
                                            top: 3,
                                            child: Text(
                                              orderData['delivered'] == true
                                                  ? 'Delivered'
                                                  : orderData['processing'] ==
                                                          true
                                                      ? 'Processing'
                                                      : 'Cancelled',
                                              style: GoogleFonts.lato(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.white,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 115,
                                    left: 298,
                                    child: Container(
                                      width: 20,
                                      height: 20,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(),
                                      child: Stack(
                                        clipBehavior: Clip.none,
                                        children: [
                                          Positioned(
                                            top: 0,
                                            left: 0,
                                            child: InkWell(
                                              onTap: () async {
                                                await _firestore
                                                .collection('orders')
                                                .doc(orderData['orderId'])
                                                .delete();
                                              },
                                              child: Image.asset(
                                                  'assets/icons/delete.png',
                                                  width: 20,
                                                  height: 20),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
