import 'package:flutter/material.dart';
import 'package:poswarehouse/models/allwarehouses.dart';
import 'package:poswarehouse/models/warehouse.dart';
import 'package:poswarehouse/screen/warehouse/services/wareHouseApi.dart';

class WareHouseController extends ChangeNotifier {
  WareHouseController({this.api = const WareHouseApi()});

  WareHouseApi api;

  AllWareHouses? allWareHouses;
  WareHouse? wareHouse;
  WareHouse? editwareHouse;

  getListWareHouses({
    int start = 0,
    int length = 10,
  }) async {
    allWareHouses = await WareHouseApi.getSubCategorys(
      start: start,
      length: length,
    );
    notifyListeners();
  }

  createNewWareHouse(String category_product_id, String name) async {
    wareHouse = await WareHouseApi.createSubCategory(category_product_id, name);
    notifyListeners();
  }

  editWareHouse(int id, String name) async {
    editwareHouse = await WareHouseApi.editSubCategory(id, name);
    notifyListeners();
  }
}
