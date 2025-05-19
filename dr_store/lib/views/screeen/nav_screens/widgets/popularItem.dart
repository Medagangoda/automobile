import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dr_store/views/screens/inner_screens/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PopularItem extends StatelessWidget {
  const PopularItem({
    super.key,
    required this.productData,
  });

  final QueryDocumentSnapshot<Object?> productData;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ProductDetailsScreen(productData: productData,);
        }));
      },
      child: SizedBox(
        width: 110,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Container(
                width: 87,
                height: 81,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 190, 187, 187),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Image.network(productData['productImage'][0],
                  width: 87,
                  height: 81,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 8,),
            Text('Discount: \Rs.${productData['discount']}',
              style: GoogleFonts.lato(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: const Color.fromARGB(255, 192, 21, 21),
              ),
            ),
            Text(productData['productName'],
              style: GoogleFonts.lato(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 32, 32, 32),
              ),
            ),
            Text('Price: \Rs.${productData['productPrice']}',
              style: GoogleFonts.lato(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: const Color.fromARGB(255, 32, 32, 32),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
