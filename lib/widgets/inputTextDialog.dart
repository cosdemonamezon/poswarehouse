import 'package:flutter/material.dart';

class InputTextDialog extends StatefulWidget {
  InputTextDialog(
      {Key? key, })
      : super(key: key);

  @override
  State<InputTextDialog> createState() => _InputTextDialogState();
}

class _InputTextDialogState extends State<InputTextDialog> {
  final TextEditingController? numberPick = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    numberPick!.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('กรอกรายละเอียด'),
      content: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
        child: TextFormField(
          keyboardType: TextInputType.emailAddress,
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
            // if (numberPick!.text != "") {
            //   Navigator.pop(context, numberPick!.text);
            // }
            Navigator.pop(context, numberPick!.text);
            
          },
          child: Text('ตกลง'),
        ),
      ],
    );
  }
}