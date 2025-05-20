import 'package:dr_store/provider/favorite_provider.dart';
import 'package:dr_store/views/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:badges/badges.dart' as badges;

class FavoriteScreen extends ConsumerWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wishItemData = ref.watch(favoriteProvider);
    final favoriteData = ref.read(favoriteProvider.notifier);

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
                            wishItemData.length.toString(),
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
        body: wishItemData.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                          'Your wish List is empty.\nYou Can add product to your WishList from the button below. . .',
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
                        child: Text('Add Now',
                            style: GoogleFonts.lato(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: const Color.fromARGB(255, 16, 74, 197),
                                letterSpacing: 1.7)))
                  ],
                ),
              )
            : ListView.builder(
                itemCount: wishItemData.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final wishData = wishItemData.values.toList()[index];
                  return Padding(
                    padding: EdgeInsets.all(8),
                    child: Center(
                      child: Container(
                        width: 335,
                        height: 96,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(),
                        child: SizedBox(
                          width: double.infinity,
                          child: Stack(clipBehavior: Clip.none, children: [
                            Positioned(
                              left: 0,
                              top: 0,
                              child: Container(
                                width: 335,
                                height: 97,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    width: 0.8,
                                    color: Color(0xFFEFF0F2),
                                  ),
                                  borderRadius: BorderRadius.circular(9),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 13,
                              top: 9,
                              child: Container(
                                width: 78,
                                height: 78,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 187, 185, 176),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 275,
                              top: 16,
                              child: Text(
                                wishData.productPrice.toRadixString(2),
                                style: GoogleFonts.getFont(
                                  'Lato',
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.3,
                                  color: const Color.fromARGB(255, 19, 47, 70),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 101,
                              top: 14,
                              child: SizedBox(
                                width: 162,
                                child: Text(
                                  wishData.productName,
                                  style: GoogleFonts.getFont(
                                    'Lato',
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.3,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 21,
                              top: 14,
                              child: Image.network(
                                wishData.imageUrl[0],
                                width: 62,
                                height: 67,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              top: 61,
                              left: 295,
                              child: InkWell(
                                onTap: () {
                                  favoriteData.removeItem(wishData.productId);
                                },
                              child: Image.asset('assets/icons/delete.png',
                                width: 22,
                                height: 22,
                                fit: BoxFit.cover,
                              ),
                              )
                            )
                          ]),
                        ),
                      ),
                    ),
                  );
                }));
  }
}
