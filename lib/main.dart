import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:poswarehouse/screen/category/services/categoryController.dart';
import 'package:poswarehouse/screen/login/loginPage.dart';
import 'package:poswarehouse/screen/order/services/ordersController.dart';
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
    initializeDateFormatting('th');
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductController()),
        ChangeNotifierProvider(create: (context) => CategoryController()),
        ChangeNotifierProvider(create: (context) => OrdersController()),
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
