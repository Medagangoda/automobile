import 'package:dr_store/controllers/category_controller.dart';
import 'package:dr_store/views/screens/authentication_screens/login_screen.dart';
import 'package:dr_store/views/screens/authentication_screens/register_screen.dart';
import 'package:dr_store/views/screens/main_screen.dart';
import 'package:dr_store/views/screens/nav_screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp( const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent)); // screen stetus bar remove
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MainScreen(),
      initialBinding: BindingsBuilder(() {
        Get.put<CategoryController>(CategoryController());
      }),
    );
  }
}
