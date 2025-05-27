import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dr_store/provider/cart_provider.dart';
import 'package:dr_store/views/screens/inner_screens/shipping_address_screen.dart';
import 'package:dr_store/views/screens/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';

class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({super.key});

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  String _selectedPaymentMethod = 'stripe';
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLoading = false;

  //get user this information
  String state = '';
  String city = '';
  String locality = '';

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  void getUserData() {
    Stream<DocumentSnapshot> userDataStream =
        _firestore.collection('buyers').doc(_auth.currentUser!.uid).snapshots();

    userDataStream.listen((DocumentSnapshot userData) {
      if (userData.exists) {
        setState(() {
          state = userData.get('state');
          city = userData.get('city');
          locality = userData.get('locality');
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartProviderData = ref.read(cartProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('CheckOut'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ShippingAddressScreen();
                  }));
                },
                child: SizedBox(
                  width: 346,
                  height: 74,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                          width: 346,
                          height: 74,
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                color: Color.fromARGB(255, 182, 182, 182)),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 70,
                        top: 17,
                        child: SizedBox(
                          width: 215,
                          height: 41,
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Positioned(
                                left: -1,
                                top: -1,
                                child: SizedBox(
                                  width: 219,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'Add Address',
                                          style: GoogleFonts.lato(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: const Color.fromARGB(
                                                255, 104, 100, 100),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'Enter City',
                                          style: GoogleFonts.lato(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: const Color.fromARGB(
                                                255, 104, 100, 100),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 16,
                        top: 16,
                        child: SizedBox.square(
                          dimension: 42,
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Positioned(
                                left: 0,
                                top: 0,
                                child: Container(
                                  width: 43,
                                  height: 43,
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFFBF7F5),
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: Stack(
                                    clipBehavior: Clip.hardEdge,
                                    children: [
                                      Positioned(
                                        left: 11,
                                        top: 11,
                                        child: Image.asset(
                                          'assets/icons/location.png',
                                          width: 20,
                                          height: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 305,
                        top: 18,
                        child: Image.asset(
                          'assets/icons/editelocation.png',
                          width: 40,
                          height: 40,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'My item',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Flexible(
                child: ListView.builder(
                    itemCount: cartProviderData.length,
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemBuilder: (context, index) {
                      final cartItem = cartProviderData.values.toList()[index];

                      return InkWell(
                        onTap: () {},
                        child: Container(
                          width: 336,
                          height: 91,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                color: Color.fromARGB(255, 182, 182, 182)),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Positioned(
                                left: 6,
                                top: 6,
                                child: SizedBox(
                                  width: 311,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: 78,
                                        height: 78,
                                        clipBehavior: Clip.hardEdge,
                                        decoration: BoxDecoration(
                                          color: Color.fromARGB(
                                              255, 187, 185, 176),
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        child: Image.network(
                                          cartItem.imageUrl[0],
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 11,
                                      ),
                                      Expanded(
                                        child: Container(
                                          height: 78,
                                          alignment: Alignment(0, -0.51),
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
                                                    cartItem.productName,
                                                    style: GoogleFonts.lato(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: const Color
                                                            .fromARGB(
                                                            255, 158, 62, 62)),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 4,
                                                ),
                                                Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    cartItem.categoryName,
                                                    style: GoogleFonts.lato(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              104,
                                                              100,
                                                              100),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 16,
                                      ),
                                      Text(
                                        cartItem.discount.toStringAsFixed(2),
                                        style: GoogleFonts.lato(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 0.3,
                                          color: const Color.fromARGB(
                                              255, 19, 47, 70),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Choose Payment Method',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 26, 113, 185)),
              ),
              RadioListTile<String>(
                title: Text(
                  'Stripe',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                value: 'stripe',
                groupValue: _selectedPaymentMethod,
                onChanged: (String? value) {
                  setState(
                    () {
                      _selectedPaymentMethod = value!;
                    },
                  );
                },
              ),
              RadioListTile<String>(
                title: Text(
                  'Cash on Delivery',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                value: 'cashOnDelivery',
                groupValue: _selectedPaymentMethod,
                onChanged: (String? value) {
                  setState(
                    () {
                      _selectedPaymentMethod = value!;
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomSheet: state == ""
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return ShippingAddressScreen();
                        },
                      ),
                    );
                  },
                  child: Text('Add Address')),
            )
          : Padding(
              padding: const EdgeInsets.all(10.0),
              child: InkWell(
                onTap: () async {
                  if (_selectedPaymentMethod == 'stripe') {
                  } else {
                    setState(() {
                      isLoading = true;
                    });
                    for (var item
                        in ref.read(cartProvider.notifier).getCartItem.values) {
                      DocumentSnapshot userDoc = await _firestore
                          .collection('buyers')
                          .doc(_auth.currentUser!.uid)
                          .get();

                      CollectionReference orderRefer =
                          _firestore.collection('orders');
                      final orderId = Uuid().v4();
                      await orderRefer.doc(orderId).set({
                        'orderId': orderId,
                        'productName': item.productName,
                        'productId': item.productId,
                        'size': item.productSize,
                        'quantity': item.quantity,
                        'price': item.quantity * item.productPrice,
                        'category': item.categoryName,
                        'productImage': item.imageUrl[0],
                        'state':
                            (userDoc.data() as Map<String, dynamic>)['state'],
                        'email':
                            (userDoc.data() as Map<String, dynamic>)['email'],
                        'locality': (userDoc.data()
                            as Map<String, dynamic>)['locality'],
                        'fullName': (userDoc.data()
                            as Map<String, dynamic>)['fullName'],
                        'buyerId': _auth.currentUser!.uid,
                        'deliveredCount': 0,
                        'delivered': false,
                        'processing': true,
                        'city':
                            (userDoc.data() as Map<String, dynamic>)['city'],
                      }).whenComplete(() {
                        cartProviderData.clear();
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                          return MainScreen();
                        }));
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.blueGrey,
                            content: Text('Order Placed Successfully'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                        setState(() {
                          isLoading = false;
                        });
                      });
                    }
                  }
                },
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width - 50,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 95, 95, 95),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: isLoading
                        ? CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : Text(
                            'PLACE ORDER',
                            style: GoogleFonts.lato(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                height: 1.4),
                          ),
                  ),
                ),
              ),
            ),
    );
  }
}
