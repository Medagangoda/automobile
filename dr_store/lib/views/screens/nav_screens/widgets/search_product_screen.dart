import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dr_store/views/screens/nav_screens/widgets/product_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchProductScreen extends StatefulWidget {
  const SearchProductScreen({super.key});

  @override
  State<SearchProductScreen> createState() => _SearchProductScreenState();
}

class _SearchProductScreenState extends State<SearchProductScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _productsStream = FirebaseFirestore.instance
        .collection('products')
        .where('productName', isGreaterThanOrEqualTo: _searchQuery)
        .snapshots();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: BackButton(color: Colors.black),
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: "Search product...",
            hintStyle: GoogleFonts.lato(color: Colors.grey),
            border: InputBorder.none,
            suffixIcon: IconButton(
              icon: Icon(Icons.clear, color: Colors.grey),
              onPressed: () {
                _searchController.clear();
                setState(() {
                  _searchQuery = '';
                });
              },
            ),
          ),
          onChanged: (value) {
            setState(() {
              _searchQuery = value.trim();
            });
          },
        ),
      ),
      body: _searchQuery.isEmpty
          ? Center(
              child: Text(
                'Search for products by name',
                style: GoogleFonts.lato(fontSize: 16),
              ),
            )
          : StreamBuilder<QuerySnapshot>(
              stream: _productsStream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error fetching data'));
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                final results = snapshot.data!.docs.where((doc) {
                  final productName = doc['productName'].toString().toLowerCase();
                  return productName.contains(_searchQuery.toLowerCase());
                }).toList();

                if (results.isEmpty) {
                  return Center(child: Text('No products found'));
                }

                return GridView.builder(
                  padding: const EdgeInsets.all(8.0),
                  itemCount: results.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 160 / 260,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    return ProductItemWidget(productData: results[index]);
                  },
                );
              },
            ),
    );
  }
}
