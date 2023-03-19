import 'package:flutter/material.dart';
import 'package:poswarehouse/models/homereport.dart';
import 'package:poswarehouse/models/report.dart';
import 'package:poswarehouse/screen/home/services/homeApi.dart';

class HomeController extends ChangeNotifier {
  HomeController({this.api = const HomeApi()});

  HomeApi api;

  List<dynamic> homeReport = [];

  Future<void> getAllReports(String year) async {
    homeReport = await HomeApi.getReport(year);
    notifyListeners();
  }
}