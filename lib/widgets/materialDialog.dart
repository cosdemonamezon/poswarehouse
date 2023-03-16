import 'package:flutter/material.dart';
import 'package:poswarehouse/constants/constants.dart';

class DialogOk extends StatefulWidget {
  DialogOk(
      {Key? key,
      required this.title,
      required this.description,
      required this.press,
      required this.pressSave,
      this.warehouseID,
      this.warehouseName})
      : super(key: key);
  final String title, description;
  final VoidCallback press;
  final VoidCallback pressSave;
  final TextEditingController? warehouseName;
  final TextEditingController? warehouseID;

  @override
  State<DialogOk> createState() => _DialogOkState();
}

class _DialogOkState extends State<DialogOk> {
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
        height: size.height * 0.50,
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
                child: Text('เพิ่มหมวดหมู่',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              ),
              SizedBox(height: size.height * 0.04),
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
                          'ชื่อประเภทสินค้า',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
                      SizedBox(
                        height: size.height * 0.08,
                        width: size.width * 0.45,
                        child: TextFormField(
                          controller: widget.warehouseName,
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
                  // SizedBox(width: size.width * 0.02,),
                  // Column(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     Padding(
                  //       padding: EdgeInsets.symmetric(vertical: 2),
                  //       child: Text(
                  //         'พื้นที่จัดเก็บสินค้า',
                  //         style: TextStyle(
                  //             fontWeight: FontWeight.bold, fontSize: 18),
                  //       ),
                  //     ),
                  //     SizedBox(height: size.height * 0.02),
                  //     SizedBox(
                  //       height: size.height * 0.08,
                  //       width: size.width * 0.25,
                  //       child: TextFormField(
                  //         controller: widget.warehouseID,
                  //         decoration: InputDecoration(
                  //           contentPadding: EdgeInsets.symmetric(
                  //               vertical: 20, horizontal: 10),
                  //           filled: true,
                  //           border: OutlineInputBorder(
                  //             borderSide: BorderSide.none,
                  //             borderRadius: BorderRadius.all(
                  //               Radius.circular(10),
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
              SizedBox(height: size.height * 0.05),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: GestureDetector(
                  onTap: widget.pressSave,
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

class AlertDialogYesNo extends StatelessWidget {
  AlertDialogYesNo(
      {Key? key, required this.description, required this.pressYes, required this.title, required this.pressNo})
      : super(key: key);
  final String title, description;
  final VoidCallback pressYes;
  final VoidCallback pressNo;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(description),
      actions: [
        TextButton(
          //textColor: Color(0xFF6200EE),
          onPressed: pressNo,
          child: Text('ยกเลิก'),
        ),
        TextButton(
          //textColor: Color(0xFF6200EE),
          onPressed: pressYes,
          child: Text('ตกลง'),
        ),
      ],
    );
  }
}

class AlertDialogYes extends StatelessWidget {
  AlertDialogYes({Key? key, required this.description, required this.pressYes, required this.title}) : super(key: key);
  final String title, description;
  final VoidCallback pressYes;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(child: Text(title)),
      content: Text(description),
      actions: [
        Center(
          child: TextButton(
            //textColor: Color(0xFF6200EE),
            onPressed: pressYes,
            child: Text('ตกลง'),
          ),
        ),
      ],
    );
  }
}

class AlertDialogChangs extends StatelessWidget {
  AlertDialogChangs({Key? key, required this.description, required this.pressYes, required this.title}) : super(key: key);
  final String title, description;
  final VoidCallback pressYes;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(child: Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50))),
      content: Text(
        description, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 60),),
      actions: [
        Center(
          child: TextButton(
            //textColor: Color(0xFF6200EE),
            onPressed: pressYes,
            child: Text('ตกลง',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40)),
          ),
        ),
      ],
    );
  }
}

