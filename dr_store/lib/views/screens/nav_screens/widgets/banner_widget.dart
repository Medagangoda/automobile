import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dr_store/controllers/banner_controller.dart';
import 'package:flutter/material.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({super.key});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  final BannerController _bannerController = BannerController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 170,
        decoration: BoxDecoration(color: const Color(0xFFF7F7F7), boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 4,
            blurRadius: 5,
            offset: const Offset(0, 2),
          )
        ]),
        child: StreamBuilder<List<String>>(
            stream: _bannerController.getBannerUrls(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.blue,
                  ),
                );
              } else if (snapshot.hasError) {
                return const Icon(Icons.error);
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(
                  child: Text(
                    "No Banners Avilable . . .",
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                );
              } else {
                return Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    PageView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return CachedNetworkImage(
                          imageUrl: snapshot.data![index],
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                             const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                            const  Icon(Icons.error),
                        );
                      },
                    ),
                    _buildPageIndicator(snapshot.data!.length)
                  ],
                );
              }
            }),
      ),
    );
  }

  Widget _buildPageIndicator(int pageCount) {
    //page indecaters
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(pageCount, (index) {
          return Container(
            width: 8.0,
            height: 8.0,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration:
                BoxDecoration(color: Colors.white, shape: BoxShape.circle),
          );
        }),
      ),
    );
  }
}
