import 'package:dr_store/provider/cart_provider.dart';
import 'package:dr_store/views/screens/inner_screens/checkout_screen.dart';
import 'package:dr_store/views/screens/main_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:badges/badges.dart' as badges;
import 'package:google_fonts/google_fonts.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cartData = ref.watch(cartProvider);
    final _cartProvider = ref.read(cartProvider.notifier);
    final totalAmount = ref.read(cartProvider.notifier).calculateTotaalAmount();
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
                    Positioned(
                      top: 0,
                      right: 0,
                      child: badges.Badge(
                        badgeStyle: badges.BadgeStyle(
                          badgeColor: const Color.fromARGB(255, 255, 59, 55),
                        ),
                        badgeContent: Text(
                          cartData.length.toString(),
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
              Positioned(
                left: 61,
                top: 51,
                child: Text('My Cart',
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
      body: cartData.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                        'Your shopping cart is empty.\nYou Can add product to cart from the button below. . .',
                        style: GoogleFonts.roboto(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            letterSpacing: 1.7)),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return MainScreen();
                        }));
                      },
                      child: Text('Shop Now',
                          style: GoogleFonts.lato(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 16, 74, 197),
                              letterSpacing: 1.7)))
                ],
              ),
            )
          : SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 49,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          left: 0,
                          top: 0,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 49,
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 180, 170, 170),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 34,
                          height: 55,
                          child: Container(
                            width: 10,
                            height: 10,
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 69,
                          top: 14,
                          child: Text('You Have ${cartData.length} Items.',
                              style: GoogleFonts.lato(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              )),
                        )
                      ],
                    ),
                  ),
                  ListView.builder(
                      itemCount: cartData.length,
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemBuilder: (context, index) {
                        final cartItem = cartData.values.toList()[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            child: SizedBox(
                              height: 200,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 200,
                                    width: 183,
                                    child: Image.network(
                                      cartItem.imageUrl[0],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          cartItem.productName,
                                          style: GoogleFonts.lato(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          cartItem.categoryName,
                                          style: GoogleFonts.lato(
                                            fontSize: 15,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          cartItem.productPrice
                                              .toStringAsFixed(2),
                                          style: GoogleFonts.lato(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            color: const Color.fromARGB(
                                                255, 150, 15, 15),
                                          ),
                                        ),
                                        Text(
                                          'discount \Rs.${cartItem.discount}',
                                          style: GoogleFonts.lato(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 0.3,
                                            color: const Color.fromARGB(
                                                255, 116, 124, 131),
                                            decoration:
                                                TextDecoration.lineThrough,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              height: 40,
                                              width: 120,
                                              decoration: BoxDecoration(
                                                color: const Color.fromARGB(
                                                    255, 224, 137, 137),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Row(
                                                children: [
                                                  IconButton(
                                                    onPressed: () {
                                                      _cartProvider
                                                          .decrementItem(
                                                              cartItem
                                                                  .productId);
                                                    },
                                                    icon: Icon(
                                                        CupertinoIcons.minus),
                                                  ),
                                                  Text(
                                                    cartItem.quantity
                                                        .toString(),
                                                    style: GoogleFonts.lato(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  IconButton(
                                                    onPressed: () {
                                                      _cartProvider
                                                          .incrementItem(
                                                              cartItem
                                                                  .productId);
                                                    },
                                                    icon: Icon(
                                                        CupertinoIcons.plus),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                _cartProvider.removeItem(
                                                    cartItem.productId);
                                              },
                                              icon: Icon(CupertinoIcons.delete),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      })
                ],
              ),
            ),
      bottomNavigationBar: Container(
        width: 416,
        height: 89,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 416,
                height: 89,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Color(0xFFC4C4C4),
                    )),
              ),
            ),
            Align(
              alignment: Alignment(-0.63, -0.26),
              child: Text('SubTotal',
                  style: GoogleFonts.roboto(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 124, 115, 115),
                  )),
            ),
            Align(
              alignment: Alignment(-0.19, -0.23),
              child: Text(
                totalAmount.toStringAsFixed(2),
                style: GoogleFonts.roboto(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: const Color.fromARGB(255, 182, 101, 101),
                ),
              ),
            ),
            Align(
              alignment: Alignment(0.83, -1),
              child: InkWell(
                onTap: () {
                  if (totalAmount == 0.0) {
                    return;
                  } else {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return CheckoutScreen();
                    }));
                  }
                },
                child: Container(
                  width: 166,
                  height: 71,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: totalAmount == 0.0
                        ? Colors.grey
                        : Color.fromARGB(255, 177, 83, 96),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'CheckOut',
                          style: GoogleFonts.lato(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
