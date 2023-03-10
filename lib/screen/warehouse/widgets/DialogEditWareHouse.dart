import 'package:flutter/material.dart';
import 'package:poswarehouse/constants/constants.dart';
import 'package:poswarehouse/models/allTypeProduct.dart';
import 'package:poswarehouse/models/editwarehouse.dart';
import 'package:poswarehouse/models/typeProduct.dart';

class DialogEditWareHouse extends StatefulWidget {
  DialogEditWareHouse(
      {Key? key,
      required this.title,
      required this.description,
      required this.press,
      this.editwarehouseId,
      this.editwarehouseName,
      required this.allCategory})
      : super(key: key);
  final String title, description;
  final VoidCallback press;
  final TextEditingController? editwarehouseName;
  final TextEditingController? editwarehouseId;
  final AllTypeProduct allCategory;

  @override
  State<DialogEditWareHouse> createState() => _DialogEditWareHouseState();
}

class _DialogEditWareHouseState extends State<DialogEditWareHouse> {
  EditWareHouse? editWareHouse;
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
                      onPressed: widget.press,
                      icon: Icon(
                        Icons.cancel,
                        size: 30,
                        color: Colors.blueAccent,
                      )),
                ],
              ),
              SizedBox(height: size.height * 0.02),
              Center(
                child: Text('เพิ่มคลังสินค้า',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
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
                          'รหัสคลังสินค้า',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
                      SizedBox(
                        height: size.height * 0.08,
                        width: size.width * 0.25,
                        child: TextFormField(
                          controller: widget.editwarehouseId,
                          readOnly: true,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 20, horizontal: 10),
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
                          'ชื่อคลังสินค้า',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
                      SizedBox(
                        height: size.height * 0.08,
                        width: size.width * 0.25,
                        child: TextFormField(
                          controller: widget.editwarehouseName,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 20, horizontal: 10),
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
                ],
              ),
              SizedBox(height: size.height * 0.05),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: GestureDetector(
                  onTap: () async {
                    if (widget.editwarehouseId != null && widget.editwarehouseName != null) {
                      print('object Value allrady');
                      setState(() {
                        editWareHouse = new EditWareHouse(int.parse(widget.editwarehouseId!.text) , widget.editwarehouseName!.text);
                      });
                      Navigator.pop(context, editWareHouse);
                    } else {
                      print('object Value is Null');
                    }
                  },
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
              SizedBox(height: size.height * 0.03),
            ],
          ),
        ),
      ),
    );
  }
}
