import 'package:dr_store/views/screens/nav_screens/widgets/banner_widget.dart';
import 'package:dr_store/views/screens/nav_screens/widgets/category_item.dart';
import 'package:dr_store/views/screens/nav_screens/widgets/recommended_product_widget.dart';
import 'package:dr_store/views/screens/nav_screens/widgets/reuseable_text_widget.dart';
import 'package:dr_store/views/screens/nav_screens/widgets/search_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/searchBanner.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          padding: const EdgeInsets.only(top: 35, left: 16, right: 16, bottom: 10),
          child: Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SearchProductScreen()),
                    );
                  },
                  child: Container(
                    height: 42,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 5,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: IgnorePointer(
                      child: TextField(
                        enabled: false,
                        decoration: InputDecoration(
                          hintText: 'Search products...',
                          hintStyle: GoogleFonts.lato(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                          ),
                          border: InputBorder.none,
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Image.asset('assets/icons/search.png', width: 20, height: 20),
                          ),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Image.asset(
                              'assets/icons/camera.png',
                              width: 24,
                              height: 24,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              IconButton(
                onPressed: () {},
                icon: Image.asset('assets/icons/bell.png', width: 24, height: 24),
              ),
              IconButton(
                onPressed: () {},
                icon: Image.asset('assets/icons/message.png', width: 24, height: 24),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            BannerWidget(),
            CategoryItem(),
            SizedBox(height: 10),
            ReuseableTextWidget(title: 'Recommended For You', subtitle: 'View All'),
            RecommendedProductWidget(),
            SizedBox(height: 10),
            ReuseableTextWidget(title: 'Popular Product', subtitle: 'View All'),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
