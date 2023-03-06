import 'package:flutter/material.dart';
import 'package:poswarehouse/constants/constants.dart';
import 'package:poswarehouse/screen/login/widgets/appTextForm.dart';
import 'package:poswarehouse/widgets/materialDialog.dart';

class CategoryPage extends StatefulWidget {
  CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  List multipleSelected = [];
  List checkListItems = [
    {
      "id": 1,
      "value": false,
      "title": "หมวดหมู่สินค้า",
    },
    {
      "id": 2,
      "value": false,
      "title": "เบ็ดเตล็ด",
    },
  ];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('หมวดหมู่'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      width: size.width * 0.64,
                      height: size.height * 0.08,
                      child: appTextFormField(
                        sufPress: () {},
                        preIcon: Icons.search,
                        vertical: 25.0,
                        horizontal: 10.0,
                      )),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: GestureDetector(
                      onTap: () async {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return DialogOk(
                              title: 'รอตรวจสอบ',
                              description: 'รายการนี้กำลังรอ ทีมแอดมินตรวจสอบ',
                              press: () {
                                Navigator.pop(context);
                              },
                            );
                          },
                        );
                      },
                      child: Container(
                        width: size.width * 0.1,
                        height: size.height * 0.08,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: kPrimaryColor),
                        child: Center(
                          child: Text(
                            'เพิ่มหมวดหมู่',
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
              SizedBox(
                height: size.height * 0.02,
              ),
              Column(
                children: List.generate(
                    checkListItems.length,
                    (index) => SizedBox(
                          height: size.height * 0.12,
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 245, 251, 253),
                                border: Border.all(color: Colors.white),
                              ),
                              child: CheckboxListTile(
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                                contentPadding: EdgeInsets.zero,
                                dense: true,
                                title: Text(
                                  '${checkListItems[index]["title"]}',
                                  style: TextStyle(fontSize: 25.0),
                                ),
                                value: checkListItems[index]["value"],
                                onChanged: (value) {
                                  setState(() {
                                    checkListItems[index]["value"] = value;
                                    if (multipleSelected
                                        .contains(checkListItems[index])) {
                                      multipleSelected
                                          .remove(checkListItems[index]);
                                    } else {
                                      multipleSelected
                                          .add(checkListItems[index]);
                                    }
                                  });
                                },
                              ),
                            ),
                          ),
                        )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
