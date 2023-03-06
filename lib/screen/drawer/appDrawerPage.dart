import 'package:flutter/material.dart';
import 'package:poswarehouse/screen/category/categoryPage.dart';
import 'package:poswarehouse/screen/order/orderPage.dart';
import 'package:poswarehouse/screen/product/productsPage.dart';
import 'package:poswarehouse/screen/saleItems/saleItemsPage.dart';
import 'package:poswarehouse/screen/warehouse/wareHousePage.dart';

class AppDrawerPage extends StatefulWidget {
  AppDrawerPage({Key? key}) : super(key: key);

  @override
  State<AppDrawerPage> createState() => _AppDrawerPageState();
}

class _AppDrawerPageState extends State<AppDrawerPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Drawer(
      width: size.width * 0.3,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios_new))
            ],
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          Center(
            child: Text('ADMIN'),
          ),
          ListTile(
            title:
                Center(child: Text("ภาพรวม", style: TextStyle(fontSize: 16))),
            leading: Icon(Icons.output),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          Divider(),
          ListTile(
            title: Center(
                child: Text("รายการขาย", style: TextStyle(fontSize: 16))),
            leading: Icon(Icons.note_alt),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>SaleItemsPage()));
            },
          ),
          Divider(),
          ListTile(
            title: Center(
                child: Text("คำสั่งซื้อ", style: TextStyle(fontSize: 16))),
            leading: Icon(Icons.file_open_rounded),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderPage()));
            },
          ),
          Divider(),
          ListTile(
            title:
                Center(child: Text("สินค้า", style: TextStyle(fontSize: 16))),
            leading: Icon(Icons.apps),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductsPage()));
            },
          ),
          Divider(),
          ListTile(
            title: Center(
                child: Text("คลังสินค้า", style: TextStyle(fontSize: 16))),
            leading: Icon(Icons.storefront),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>WareHousePage()));
            },
          ),
          Divider(),
          ListTile(
            title:
                Center(child: Text("หมวดหมู่", style: TextStyle(fontSize: 16))),
            leading: Icon(Icons.view_column),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoryPage()));
            },
          ),
          Divider(),
          ListTile(
            title:
                Center(child: Text("ตั้งค่า", style: TextStyle(fontSize: 16))),
            leading: Icon(Icons.settings),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {},
          ),
          Divider(),
          ListTile(
            title: Center(
                child: Text("ออกจากระบบ", style: TextStyle(fontSize: 16))),
            leading: Icon(Icons.logout),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
