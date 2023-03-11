import 'package:flutter/material.dart';
import 'package:poswarehouse/constants/constants.dart';
import 'package:poswarehouse/models/allTypeProduct.dart';
import 'package:poswarehouse/models/newwarehouse.dart';
import 'package:poswarehouse/models/typeProduct.dart';

class DialogWareHouse extends StatefulWidget {
  DialogWareHouse(
      {Key? key,
      required this.title,
      required this.description,
      required this.press,
      this.warehouseID,
      this.warehouseName,
      required this.allCategory})
      : super(key: key);
  final String title, description;
  final VoidCallback press;
  final TextEditingController? warehouseName;
  final TextEditingController? warehouseID;
  final List<TypeProduct>? allCategory;

  @override
  State<DialogWareHouse> createState() => _DialogWareHouseState();
}

class _DialogWareHouseState extends State<DialogWareHouse> {
  TypeProduct? categoryValue;
  NewWareHouse? newwarehose;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Dialog(
      elevation: 0,
      backgroundColor: Color(0xffffffff),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: SizedBox(
        width: size.width * 0.70,
        height: size.height * 0.60,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () async {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.cancel,
                        size: 30,
                        color: Colors.blueAccent,
                      )),
                ],
              ),
              SizedBox(height: size.height * 0.02),
              Center(
                child: Text('เพิ่มคลังสินค้า', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 2),
                        child: Text(
                          'ชื่อคลังสินค้า',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
                      SizedBox(
                        height: size.height * 0.08,
                        width: size.width * 0.25,
                        child: TextFormField(
                          controller: widget.warehouseName,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                            filled: true,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: size.width * 0.02,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 2),
                        child: Text(
                          'ประเภทสินค้า',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
                      Container(
                        height: size.height * 0.08,
                        width: size.width * 0.25,
                        decoration: BoxDecoration(
                            border: Border.all(color: Color.fromARGB(255, 238, 238, 238)),
                            color: Color.fromARGB(255, 238, 238, 238),
                            borderRadius: BorderRadius.circular(10)),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<TypeProduct>(
                            value: categoryValue,
                            icon: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Icon(
                                Icons.keyboard_arrow_down,
                                size: 25,
                              ),
                            ),
                            elevation: 16,
                            isDense: false,
                            isExpanded: true,
                            style: TextStyle(color: Colors.black, fontSize: 16),
                            underline: Container(
                              height: 2,
                              color: Colors.deepPurpleAccent,
                            ),
                            onChanged: (TypeProduct? typeValue) {
                              // This is called when the user selects an item.
                              setState(() {
                                categoryValue = typeValue;
                              });
                            },
                            items: widget.allCategory!.map<DropdownMenuItem<TypeProduct>>((TypeProduct typeValue) {
                              return DropdownMenuItem<TypeProduct>(
                                value: typeValue,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Text('${typeValue.name}'),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.05),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: GestureDetector(
                  onTap: () async {
                    if (widget.warehouseName != null && categoryValue != null) {
                      print('object Value allrady');
                      setState(() {
                        newwarehose = NewWareHouse(widget.warehouseName!.text, categoryValue!.id.toString());
                      });
                      Navigator.pop(context, newwarehose);
                    } else {
                      print('object Value is Null');
                    }
                  },
                  child: Container(
                    width: size.width * 0.1,
                    height: size.height * 0.08,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: kPrimaryColor),
                    child: Center(
                      child: Text(
                        'บันทึก',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.03),
            ],
          ),
        ),
      ),
    );
  }
}
