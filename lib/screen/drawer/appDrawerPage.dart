import 'package:flutter/material.dart';
import 'package:poswarehouse/screen/category/categoryPage.dart';
import 'package:poswarehouse/screen/order/orderPage.dart';
import 'package:poswarehouse/screen/pickupProduct/pickupProductPage.dart';
import 'package:poswarehouse/screen/product/productsPage.dart';
import 'package:poswarehouse/screen/returnproduct/returnProductPage.dart';
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
          SizedBox(
            height: size.height * 0.02,
          ),
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
            height: size.height * 0.01,
          ),
          Center(
            child: Text('ADMIN',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
          ),          
          
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
         
          // Divider(),
          // ListTile(
          //   title:
          //       Center(child: Text("เช็คสินค้าคงเหลือ", style: TextStyle(fontSize: 16))),
          //   leading: Icon(Icons.output),
          //   trailing: Icon(Icons.arrow_forward_ios),
          //   onTap: () {
          //     Navigator.pop(context);
          //   },
          // ),
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
                Center(child: Text("ประเภทสินค้า", style: TextStyle(fontSize: 16))),
            leading: Icon(Icons.view_column),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoryPage()));
            },
          ),
          Divider(),
          ListTile(
            title:
                Center(child: Text("เบิกสินค้า", style: TextStyle(fontSize: 16))),
            leading: Icon(Icons.settings),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>PickupProductPage()));
            },
          ),
          Divider(),
          ListTile(
            title:
                Center(child: Text("สินค้าชำรุด", style: TextStyle(fontSize: 16))),
            leading: Icon(Icons.settings),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>ReturnProductPage()));
            },
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
