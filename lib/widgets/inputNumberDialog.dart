import 'package:flutter/material.dart';

class InputNumberDialog extends StatefulWidget {
  InputNumberDialog(
      {Key? key, this.code})
      : super(key: key);
  String? code;

  @override
  State<InputNumberDialog> createState() => _InputNumberDialogState();
}

class _InputNumberDialogState extends State<InputNumberDialog> {
  final TextEditingController? numberPick = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    numberPick!.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('รหัสสินค้า: ${widget.code}'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('ใส่ตัวเลข', style: TextStyle(fontSize: 16),),
          Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
            child: TextFormField(
              keyboardType: TextInputType.number,
              controller: numberPick,
              decoration: InputDecoration(
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
      actions: [
        TextButton(
          //textColor: Color(0xFF6200EE),
          onPressed: (){
            Navigator.pop(context);
          },
          child: Text('ยกเลิก'),
        ),
        TextButton(
          //textColor: Color(0xFF6200EE),
          onPressed: (){
            if (numberPick!.text != "") {
              Navigator.pop(context, numberPick!.text);
            }
          },
          child: Text('ตกลง'),
        ),
      ],
    );
  }
}