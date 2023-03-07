import 'package:flutter/material.dart';
import 'package:poswarehouse/constants/constants.dart';
import 'package:poswarehouse/screen/login/widgets/appTextForm.dart';

class AddProducts extends StatefulWidget {
  AddProducts({Key? key}) : super(key: key);

  @override
  State<AddProducts> createState() => _AddProductsState();
}

class _AddProductsState extends State<AddProducts> {
  final GlobalKey<FormState> addProductFormKey = GlobalKey<FormState>();
  final TextEditingController productId = TextEditingController();
  final TextEditingController productName = TextEditingController();
  final TextEditingController originPrice = TextEditingController();
  final TextEditingController retailPrice = TextEditingController();
  final TextEditingController wholesalePrice = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('เพิ่มสินค้าใหม่'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.02,
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: size.height * 0.40,
                    //color: Colors.blue,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 2),
                          child: Text(
                            'รหัสสินค้า',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                        SizedBox(
                            height: size.height * 0.08,
                            width: size.width * 0.45,
                            child: appTextFormField(
                              controller: productId,
                              sufPress: () {},
                              vertical: 25.0,
                              horizontal: 10.0,
                            )),
                        Container(
                          height: size.height * 0.12,
                          width: size.width * 0.45,
                          child: SizedBox(
                            height: size.height * 0.12,
                            child: Row(
                              children: [
                                Container(
                                  width: size.width * 0.12,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.add),
                                      Text(
                                        'เลือกรูปภาพ',
                                        style: TextStyle(fontSize: 16.0),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: Text('xxxxxx.png'),
                                )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 2),
                          child: Text(
                            'ราคาทุน',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                        SizedBox(
                            height: size.height * 0.08,
                            width: size.width * 0.45,
                            child: appTextFormField(
                              controller: originPrice,
                              sufPress: () {},
                              vertical: 25.0,
                              horizontal: 10.0,
                            )),
                      ],
                    ),
                  ),
                  //------------------
                  Container(
                    height: size.height * 0.40,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 2),
                          child: Text(
                            'ชื่อสินค้า',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                        SizedBox(
                            height: size.height * 0.08,
                            width: size.width * 0.45,
                            child: appTextFormField(
                              controller: productName,
                              sufPress: () {},
                              vertical: 25.0,
                              horizontal: 10.0,
                            )),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 2),
                          child: Text(
                            'ราคาขายปลีก',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                        SizedBox(
                            height: size.height * 0.08,
                            width: size.width * 0.45,
                            child: appTextFormField(
                              controller: retailPrice,
                              sufPress: () {},
                              vertical: 25.0,
                              horizontal: 10.0,
                            )),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 2),
                          child: Text(
                            'ราคาขายส่ง',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                        SizedBox(
                            height: size.height * 0.08,
                            width: size.width * 0.45,
                            child: appTextFormField(
                              controller: wholesalePrice,
                              sufPress: () {},
                              vertical: 25.0,
                              horizontal: 10.0,
                            )),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.08,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: GestureDetector(
                      onTap: () async {},
                      child: Container(
                        width: size.width * 0.1,
                        height: size.height * 0.08,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: kPrimaryColor),
                        child: Center(
                          child: Text(
                            'บันทึก',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
