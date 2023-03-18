import 'package:flutter/material.dart';
import 'package:poswarehouse/models/unit.dart';

class UnitDialog extends StatefulWidget {
  UnitDialog({Key? key, required this.units, this.code}) : super(key: key);
  List<Unit> units;
  String? code;
  @override
  State<UnitDialog> createState() => _UnitDialogState();
}

class _UnitDialogState extends State<UnitDialog> {
  Unit? unit;
  @override
  void initState() {
    super.initState();
    setState(() {
      unit = widget.units[0];
    });
  }
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AlertDialog(
      title: Text('รหัสสินค้า: ${widget.code}'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('เลือกหน่วย'),
          Container(
            height: size.height * 0.08,
            width: size.width * 0.25,
            decoration: BoxDecoration(
                border: Border.all(color: Color.fromARGB(255, 238, 238, 238)),
                color: Color.fromARGB(255, 238, 238, 238),
                borderRadius: BorderRadius.circular(10)),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<Unit>(
                value: unit,
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
                onChanged: (Unit? detialValue) {
                  setState(() {
                    unit = detialValue;
                  });
                },
                items: widget.units.map<DropdownMenuItem<Unit>>((Unit detialValue) {
                  return DropdownMenuItem<Unit>(
                    value: detialValue,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text('${detialValue.name}'),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(borderRadius: BorderRadius.zero, side: BorderSide(color: Colors.grey, width: 2)))),
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('ยกเลิก', style: TextStyle(color: Colors.red),),
        ),
        TextButton(
          style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(borderRadius: BorderRadius.zero, side: BorderSide(color: Colors.grey, width: 2)))),
          onPressed: () {
            if (unit != null) {
              Navigator.pop(context, unit);
            }
          },
          child: Text('ตกลง'),
        ),
      ],
    );
  }
}
