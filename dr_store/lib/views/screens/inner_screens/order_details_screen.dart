import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderDetailsScreen extends StatefulWidget {
  final dynamic orderData;
  OrderDetailsScreen({super.key, required this.orderData});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  final TextEditingController _reviewController = TextEditingController();
  double rating = 0;

  Future<bool> hasUserReviewedProduct(String productId) async {
    final user = FirebaseAuth.instance.currentUser;
    final querySnapshot = await FirebaseFirestore.instance
        .collection('productReviews')
        .where('productId', isEqualTo: productId)
        .where('buyerId', isEqualTo: user!.uid)
        .get();
    return querySnapshot.docs.isNotEmpty;
  }

  //rating with the product collection
  Future<void> updateProductRating(String productId) async {
    final QuerySnapshot = await FirebaseFirestore.instance
        .collection('productReviews')
        .where('productId', isEqualTo: productId)
        .get();

    double totalRating = 0;
    int totalReviews = QuerySnapshot.docs.length;

    for (final doc in QuerySnapshot.docs) {
      totalRating += doc['rating'];
    }

    final double averageRating = totalReviews > 0 ? totalRating / totalReviews : 0;

    await FirebaseFirestore.instance
    .collection('products')
    .doc(productId)
    .update({
      'rating': averageRating,
      'totalReviews': totalReviews,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.orderData['productName'],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
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
                              color: const Color.fromARGB(255, 224, 224, 224)),
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
                                  color:
                                      const Color.fromARGB(255, 223, 223, 223),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Positioned(
                                      left: 10,
                                      top: 5,
                                      child: Image.network(
                                          widget.orderData['productImage'],
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
                                              MainAxisAlignment.spaceBetween,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            SizedBox(
                                              width: double.infinity,
                                              child: Text(
                                                widget.orderData['productName'],
                                                style: GoogleFonts.lato(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: const Color.fromARGB(
                                                      255, 0, 0, 0),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 3,
                                            ),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                widget.orderData['category'],
                                                style: GoogleFonts.lato(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  color: const Color.fromARGB(
                                                      255, 0, 0, 0),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 2,
                                            ),
                                            Text(
                                              '\Rs.${widget.orderData["price"]}',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color: const Color.fromARGB(
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
                                  color: widget.orderData['delivered'] == true
                                      ? const Color.fromARGB(255, 35, 129, 175)
                                      : widget.orderData['processing'] == true
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
                                        widget.orderData['delivered'] == true
                                            ? 'Delivered'
                                            : widget.orderData['processing'] == true
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
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Container(
              width: 336,
              height: 180,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Color(0xFFEFF0F2),
                ),
                borderRadius: BorderRadius.circular(9),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(padding: EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Delivery Address',
                        style: GoogleFonts.lato(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        widget.orderData['locality'] + ', ' + widget.orderData['state'],
                        style: GoogleFonts.lato(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: const Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      Text(
                       widget.orderData['city'],
                        style: GoogleFonts.lato(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: const Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      Text(
                        "To-  ${widget.orderData['fullName']}",
                        style: GoogleFonts.lato(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: const Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      
                    ],
                  ),

                  ),
                  widget.orderData['delivered'] == true
                  ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () async {
                      final productId = widget.orderData['productId'];
                      final hasReviewed = await hasUserReviewedProduct(productId);
                      if(hasReviewed) {
                        showDialog(context: context, builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Update Review'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextFormField(
                                controller: _reviewController,
                                decoration: InputDecoration(
                                  labelText: 'Update your Review',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: RatingBar.builder(
                                  initialRating: rating,
                                  minRating: 1,
                                  maxRating: 5,
                                  allowHalfRating: true,
                                  itemSize: 24,
                                  itemCount: 5,
                                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                  itemBuilder: (context, _) {
                                    return Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    );
                                  }, onRatingUpdate: (value) {
                                    rating = value;
                                    print(rating);
                                  }),
                              )
                            ],
                          ),
                          actions: [
                            TextButton(onPressed: () async {
                              final review = _reviewController.text;
                              await FirebaseFirestore.instance.
                              collection('productReviews').doc(widget.orderData['orderId'])
                              .update({
                                'reviewId': widget.orderData['orderId'],
                                'productId': widget.orderData['productId'],
                                'fullName': widget.orderData['fullName'],
                                'email': widget.orderData['email'],
                                'buyerId': FirebaseAuth.instance.currentUser!.uid,
                                'rating':rating,
                                'review': review,
                                'timeStamp': Timestamp.now(),
                              }).whenComplete(() {
                                updateProductRating(productId);
                                Navigator.of(context).pop();
                                _reviewController.clear();
                                rating = 0;
                              });
                            }, 
                            child: Text('Submit'))
                          ],
                          
                        );
                      });


                      //  Show a dialog indicating that the user has already reviewed the product------
                      //review ekk add kalahama aphu add karnn bari wenn pahala thiyen ek dala hadnn


                      // showDialog(context: context, 
                      //   builder: (context) {
                      //     return AlertDialog(
                      //       title: Text('Already Reviewed'),
                      //       content: Text('You have already reviewed this product.'),
                      //       actions: [
                      //         TextButton(
                      //           onPressed: () {
                      //             Navigator.of(context).pop();
                      //           },
                      //           child: Text('OK'),
                      //         ),
                      //       ],
                      //     );
                      //   });

                      //--------------------------------------------------
                      } else {
                        showDialog(context: context, builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Leave a Review'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextFormField(
                                controller: _reviewController,
                                decoration: InputDecoration(
                                  labelText: 'Your Review',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: RatingBar.builder(
                                  initialRating: rating,
                                  minRating: 1,
                                  maxRating: 5,
                                  allowHalfRating: true,
                                  itemSize: 24,
                                  itemCount: 5,
                                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                  itemBuilder: (context, _) {
                                    return Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    );
                                  }, onRatingUpdate: (value) {
                                    rating = value;
                                    print(rating);
                                  }),
                              )
                            ],
                          ),
                          actions: [
                            TextButton(onPressed: () async {
                              final review = _reviewController.text;
                              await FirebaseFirestore.instance.
                              collection('productReviews').doc(widget.orderData['orderId'])
                              .set({
                                'reviewId': widget.orderData['orderId'],
                                'productId': widget.orderData['productId'],
                                'fullName': widget.orderData['fullName'],
                                'email': widget.orderData['email'],
                                'buyerId': FirebaseAuth.instance.currentUser!.uid,
                                'rating':rating,
                                'review': review,
                                'timeStamp': Timestamp.now(),
                              }).whenComplete(() {
                                updateProductRating(productId);
                                Navigator.of(context).pop();
                                _reviewController.clear();
                                rating = 0;
                              });
                            }, 
                            child: Text('Submit'))
                          ],
                          
                        );
                      });
                      }
                    }, 
                    child: Text('Review')),
                  )
                  : SizedBox()
                ],
              )
            ),
          ),
        ],
      ),
    );
  }
}
