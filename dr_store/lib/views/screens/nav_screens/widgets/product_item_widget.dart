import 'package:cached_network_image/cached_network_image.dart';
import 'package:dr_store/views/screens/inner_screens/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductItemWidget extends StatelessWidget {
  final dynamic productData;

  const ProductItemWidget({super.key, required this.productData});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ProductDetailsScreen(productData: productData,);
        }));
      },
      child: Container(
        width: 146,
        height: 245,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              left: 0,
              height: 0,
              child: Container(
                width: 146,
                height: 245,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        spreadRadius: 0,
                        offset: Offset(0, 18),
                        blurRadius: 30,
                      ),
                    ]),
              ),
            ),
            Positioned(
              left: 18,
              top: 130,
              child: Text(
                productData['productName'],
                style: GoogleFonts.lato(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.3,
                  color: const Color.fromARGB(255, 19, 47, 70),
                ),
              ),
            ),
            Positioned(
              left: 19,
              top: 152,
              child: Text(
                productData['category'],
                style: GoogleFonts.lato(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.2,
                  color: const Color.fromARGB(255, 116, 124, 131),
                ),
              ),
            ),
            Positioned(
              left: 12,
              top: 180,
              child: Text(
                '\Rs.${productData['productPrice']}',
                style: GoogleFonts.lato(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.3,
                  color: const Color.fromARGB(255, 19, 47, 70),
                ),
              ),
            ),
            Positioned(
              left: 82,
              top: 180,
              child: Text(
                '\Rs.${productData['discount']}',
                style: GoogleFonts.lato(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.3,
                  color: const Color.fromARGB(255, 116, 124, 131),
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            ),
            Positioned(
              left: 9,
              top: 9,
              child: Container(
                width: 120,
                height: 108,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      left: -1,
                      top: -1,
                      child: Container(
                        width: 130,
                        height: 110,
                        decoration: BoxDecoration(
                          color: Color(0xFFFFF5C3),
                          border: Border.all(
                            width: 0.8,
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 14,
                      top: 4,
                      child: Container(
                        width: 100,
                        height: 100,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          color: Color(0xFFFFF44F),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 6,
                      top: -7,
                      child: CachedNetworkImage(
                        imageUrl: productData['productImage'][0],
                        width: 109,
                        height: 120,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 56,
              top: 168,
              child: Text('500+ sold',
                  style: GoogleFonts.lato(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.2,
                    color: Color.fromARGB(255, 197, 194, 22),
                  )),
            ),
            // Positioned(
            //   left: 20,
            //   top: 171,
            //   child: Text(
            //     productData['rating'] == 0
            //     ? ""
            //     : productData['rating'].toString(),
            //       style: GoogleFonts.lato(
            //         fontSize: 12,
            //         fontWeight: FontWeight.w400,
            //       )),
            // ),
            // productData['rating'] == 0
            // ? SizedBox()
            // : Positioned(
            //   left: 8,
            //   top: 171,
            //   child: Icon(
            //     Icons.star,
            //     color: Color.fromARGB(255, 202, 199, 7),
            //     size: 12,
            //   ),
            // ),

            

            Positioned(
              left: 106,
              top: 12,
              child: Container(
                width: 25,
                height: 25,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 247, 40, 40),
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 104, 0, 0),
                      spreadRadius: 0,
                      blurRadius: 15,
                      offset: Offset(0, 7),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              right: 3,
              top: 1,
              child: IconButton(
                onPressed: () {},
                icon: Icon(Icons.favorite_border, color: Colors.white70),
              ),
            )
          ],
        ),
      ),
    );
  }
}
