// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:dr_store/provider/cart_provider.dart';
// import 'package:dr_store/provider/favorite_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:get/get_connect/http/src/utils/utils.dart';
// import 'package:google_fonts/google_fonts.dart';

// class ProductDetailsScreen extends ConsumerStatefulWidget {
//   final dynamic productData;

//   const ProductDetailsScreen({super.key, required this.productData});

//   @override
//   _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
// }

// class _ProductDetailsScreenState extends ConsumerState<ProductDetailsScreen> {
//   @override
//   Widget build(BuildContext context) {
//     final cartProviderData = ref.read(cartProvider.notifier);
//     final favoriteProviderData = ref.read(favoriteProvider.notifier);
//     ref.watch(favoriteProvider);
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               'Product Details',
//               textAlign: TextAlign.center,
//               style: GoogleFonts.lato(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: Color(0xff363330),
//               ),
//             ),
//             IconButton(
//               onPressed: () {
//                 favoriteProviderData.addProductToFavorite(
//                   productName: widget.productData['productName'],
//                   productId: widget.productData['productId'],
//                   imageUrl: widget.productData['productImage'],
//                   productPrice: widget.productData['productPrice'],
//                 );

//                 ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                   margin: const EdgeInsets.all(15),
//                   behavior: SnackBarBehavior.floating,
//                   backgroundColor: Colors.grey,
//                   content: Text(widget.productData['productName']),
//                 ));
//               },
//               icon: favoriteProviderData.getFavoriteItem
//                       .containsKey(widget.productData['productId'])
//                   ? Icon(
//                       Icons.favorite,
//                       color: Colors.red,
//                     )
//                   : Icon(
//                       Icons.favorite_border,
//                       color: Colors.red,
//                     ),
//             ),
//           ],
//         ),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             width: 260,
//             height: 274,
//             clipBehavior: Clip.hardEdge,
//             decoration: BoxDecoration(),
//             child: Stack(
//               clipBehavior: Clip.none,
//               children: [
//                 Positioned(
//                   left: 0,
//                   top: 50,
//                   child: Container(
//                     width: 260,
//                     height: 260,
//                     clipBehavior: Clip.hardEdge,
//                     decoration: BoxDecoration(
//                       color: Color(0xFFD8DDFF),
//                       borderRadius: BorderRadius.circular(130),
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   left: 22,
//                   top: 50,
//                   child: Container(
//                     width: 216,
//                     height: 274,
//                     clipBehavior: Clip.hardEdge,
//                     decoration: BoxDecoration(
//                       color: Color(0xFF9CA8FF),
//                       borderRadius: BorderRadius.circular(14),
//                     ),
//                     child: SizedBox(
//                       height: 300,
//                       child: PageView.builder(
//                         scrollDirection: Axis.horizontal,
//                         itemCount: widget.productData['productImage'].length,
//                         itemBuilder: (context, index) {
//                           return Image.network(
//                             widget.productData['productImage'][index],
//                             width: 198,
//                             height: 225,
//                             fit: BoxFit.cover,
//                           );
//                         },
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   widget.productData['productName'],
//                   style: GoogleFonts.roboto(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     letterSpacing: 1,
//                     color: Color(0xff363330),
//                   ),
//                 ),
//                 Text(
//                   "\$${widget.productData['productPrice'].toStringAsFixed(2)}",
//                   style: GoogleFonts.roboto(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     letterSpacing: 1,
//                     color: Color.fromARGB(255, 240, 94, 50),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(
//               widget.productData['category'],
//               style: GoogleFonts.roboto(
//                 fontSize: 16,
//                 fontWeight: FontWeight.normal,
//                 color: Color(0xff363330),
//               ),
//             ),
//           ),
//           widget.productData['rating'] == 0
//               ? Text('')
//               : Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: Row(
//                     children: [
//                       Icon(
//                         Icons.star,
//                         color: Color.fromARGB(255, 202, 199, 7),
//                         size: 18,
//                       ),
//                       Text(widget.productData['rating'].toString(),
//                           style: TextStyle(
//                               fontSize: 16, fontWeight: FontWeight.bold)),
//                       Text(
//                         '(${widget.productData['totalReviews']})',
//                         style:
//                             TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                       ),
//                     ],
//                   ),
//               ),
//           Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Size',
//                   style: GoogleFonts.roboto(
//                       fontSize: 16,
//                       fontWeight: FontWeight.normal,
//                       color: Color(0xff363330),
//                       letterSpacing: 1.0),
//                 ),
//                 SizedBox(
//                   height: 50,
//                   child: ListView.builder(
//                     shrinkWrap: true,
//                     scrollDirection: Axis.horizontal,
//                     itemCount: widget.productData['productSize'].length,
//                     itemBuilder: (context, index) {
//                       return Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: InkWell(
//                           onTap: () {},
//                           child: Container(
//                             decoration: BoxDecoration(
//                               color: Color(0xFF126881),
//                             ),
//                             child: Padding(
//                               padding: EdgeInsets.all(8),
//                               child: Text(
//                                 widget.productData['productSize'][index],
//                                 style: GoogleFonts.lato(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.normal,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'About',
//                 style: GoogleFonts.lato(
//                     color: Color(0xFF363330), fontSize: 16, letterSpacing: 1),
//               ),
//               Text(
//                 widget.productData['description'],
//               )
//             ],
//           )
//         ],
//       ),
//       bottomSheet: Padding(
//         padding: EdgeInsets.all(8),
//         child: InkWell(
//           onTap: () {
//             cartProviderData.addProductToCart(
//               productName: widget.productData['productName'],
//               productPrice: widget.productData['productPrice']?.toDouble(),
//               imageUrl: widget.productData['productImage'],
//               productSize: '',
//               categoryName: widget.productData['category'],
//               quantity: 1,
//               instock: 1,
//               productId: widget.productData['productId'],
//               discount: widget.productData['discount'],
//               description: widget.productData['description'],
//             );
//             ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//               margin: const EdgeInsets.all(15),
//               behavior: SnackBarBehavior.floating,
//               backgroundColor: Colors.grey,
//               content: Text(widget.productData['productName']),
//             ));
//           },
//           child: Container(
//             width: 386,
//             height: 48,
//             clipBehavior: Clip.hardEdge,
//             decoration: BoxDecoration(
//               color: Color.fromARGB(255, 37, 37, 41),
//               borderRadius: BorderRadius.circular(24),
//             ),
//             child: Center(
//               child: Text(
//                 'Add to Cart',
//                 style: GoogleFonts.lato(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }



//new update code

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dr_store/provider/cart_provider.dart';
import 'package:dr_store/provider/favorite_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductDetailsScreen extends ConsumerStatefulWidget {
  final dynamic productData;

  const ProductDetailsScreen({super.key, required this.productData});

  @override
  ConsumerState<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends ConsumerState<ProductDetailsScreen> {
  String selectedSize = '';

  @override
  Widget build(BuildContext context) {
    final cartProviderData = ref.read(cartProvider.notifier);
    final favoriteProviderData = ref.read(favoriteProvider.notifier);
    ref.watch(favoriteProvider);

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Product Details',
          style: GoogleFonts.lato(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.black87,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              favoriteProviderData.getFavoriteItem
                      .containsKey(widget.productData['productId'])
                  ? Icons.favorite
                  : Icons.favorite_border,
              color: Colors.red,
            ),
            onPressed: () {
              favoriteProviderData.addProductToFavorite(
                productName: widget.productData['productName'],
                productId: widget.productData['productId'],
                imageUrl: widget.productData['productImage'],
                productPrice: widget.productData['productPrice'],
              );

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${widget.productData['productName']} added to favorites'),
                  backgroundColor: Colors.grey.shade800,
                  behavior: SnackBarBehavior.floating,
                  margin: const EdgeInsets.all(10),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        children: [
          SizedBox(
            height: 260,
            child: PageView.builder(
              itemCount: widget.productData['productImage'].length,
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    imageUrl: widget.productData['productImage'][index],
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          Text(
            widget.productData['productName'],
            style: GoogleFonts.roboto(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: const Color(0xff222222),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            widget.productData['category'],
            style: GoogleFonts.roboto(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                'Rs. ${widget.productData['productPrice'].toStringAsFixed(2)}',
                style: GoogleFonts.lato(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.red.shade700,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'Rs. ${widget.productData['discount']}',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            ],
          ),
          // if (widget.productData['rating'] != 0) ...[
          //   const SizedBox(height: 6),
          //   Row(
          //     children: [
          //       const Icon(Icons.star, size: 18, color: Colors.amber),
          //       const SizedBox(width: 4),
          //       Text(
          //         widget.productData['rating'].toString(),
          //         style: const TextStyle(fontWeight: FontWeight.bold),
          //       ),
          //       const SizedBox(width: 4),
          //       Text("(${widget.productData['totalReviews']} reviews)"),
          //     ],
          //   ),
          // ],
          const Divider(height: 30, thickness: 1),
          Text(
            'Available Sizes',
            style: GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            children: List.generate(widget.productData['productSize'].length, (index) {
              String size = widget.productData['productSize'][index];
              return ChoiceChip(
                label: Text(size),
                selectedColor: Colors.blue.shade700,
                selected: selectedSize == size,
                onSelected: (selected) {
                  setState(() {
                    selectedSize = selected ? size : '';
                  });
                },
              );
            }),
          ),
          const SizedBox(height: 20),
          Text(
            'Product Description',
            style: GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Text(
            widget.productData['description'],
            style: GoogleFonts.lato(fontSize: 14, color: Colors.grey[800]),
          ),
          const SizedBox(height: 80),
        ],
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(12),
        color: Colors.white,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black87,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 34),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: () {
            cartProviderData.addProductToCart(
              productName: widget.productData['productName'],
              productPrice: widget.productData['productPrice']?.toDouble(),
              imageUrl: widget.productData['productImage'],
              productSize: selectedSize,
              categoryName: widget.productData['category'],
              quantity: 1,
              instock: 1,
              productId: widget.productData['productId'],
              discount: widget.productData['discount'],
              description: widget.productData['description'],
            );

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${widget.productData['productName']} added to cart'),
                backgroundColor: Colors.green.shade700,
                behavior: SnackBarBehavior.floating,
                margin: const EdgeInsets.all(10),
              ),
            );
          },
          child: const Text(
            'Add to Cart',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
