import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:poswarehouse/screen/category/services/categoryController.dart';
import 'package:poswarehouse/screen/home/services/homeController.dart';
import 'package:poswarehouse/screen/login/loginPage.dart';
import 'package:poswarehouse/screen/order/services/ordersController.dart';
import 'package:poswarehouse/screen/pickupProduct/services/pickupProductController.dart';
import 'package:poswarehouse/screen/product/services/productController.dart';
import 'package:poswarehouse/screen/returnproduct/returnProductController.dart';
import 'package:poswarehouse/screen/warehouse/services/wareHouseController.dart';
import 'package:provider/provider.dart';

void main() {

  HttpOverrides.global = MyHttpOverrides();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('th');
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HomeController()),
        ChangeNotifierProvider(create: (context) => ProductController()),
        ChangeNotifierProvider(create: (context) => CategoryController()),
        ChangeNotifierProvider(create: (context) => OrdersController()),
        ChangeNotifierProvider(create: (context) => WareHouseController()),
        ChangeNotifierProvider(create: (context) => PickupProductController()),
        ChangeNotifierProvider(create: (context) => ReturnProductController()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        // debugShowCheckedModeBanner: false,
        //   localizationsDelegates: [
        //     SfGlobalLocalizations.delegate
        //   ],
        //   supportedLocales: [
        //     const Locale('en'),
        //     const Locale('th'),
        //   ],
        //   locale: const Locale('th'),
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

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
