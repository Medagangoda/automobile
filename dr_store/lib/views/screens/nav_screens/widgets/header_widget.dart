import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          // Background banner
          Image.asset(
            'assets/images/searchBanner.jpg',
            width: MediaQuery.of(context).size.width,
            height: 140,
            fit: BoxFit.cover,
          ),

          // Search box
          Positioned(
            left: 16,
            right: 100,
            top: 65,
            child: Container(
              height: 48,
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
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search products',
                  hintStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image.asset('assets/icons/search.png', width: 20, height: 20),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: Image.asset('assets/icons/camera.png', width: 24, height: 24),
                  ),
                ),
              ),
            ),
          ),

          // Bell icon
          Positioned(
            top: 70,
            right: 55,
            child: IconButton(
              onPressed: () {},
              icon: Image.asset('assets/icons/bell.png', width: 24, height: 24),
            ),
          ),

          // Message icon
          Positioned(
            top: 70,
            right: 15,
            child: IconButton(
              onPressed: () {},
              icon: Image.asset('assets/icons/message.png', width: 24, height: 24),
            ),
          ),
        ],
      ),
    );
  }
}
