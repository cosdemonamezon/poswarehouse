import 'package:flutter/material.dart';
import 'package:poswarehouse/screen/login/loginPage.dart';
import 'package:poswarehouse/screen/product/services/productController.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductController()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            elevation: 0,
            backgroundColor: Colors.white,
            centerTitle: true,
            titleTextStyle: TextStyle(
              color: Colors.black,
              //fontFamily: 'Prompt',
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            iconTheme: IconThemeData(color: Colors.black),
          ),
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.white,
              background: Colors.white,
              onBackground: Colors.white),
          scaffoldBackgroundColor: Colors.white,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          //primarySwatch: Colors.blue,
        ),
        home: LoginPage(),
      ),
    );
  }
}
