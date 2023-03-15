import 'package:flutter/material.dart';
import 'package:poswarehouse/models/unit.dart';

class UnitDialog extends StatefulWidget {
  UnitDialog({Key? key, required this.units}) : super(key: key);
  List<Unit> units;
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
      title: Text('เลือกหน่วย'),
      content: Container(
        height: size.height * 0.08,
        width: size.width * 0.35,
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
      actions: [
        TextButton(
          //textColor: Color(0xFF6200EE),
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('ยกเลิก'),
        ),
        TextButton(
          //textColor: Color(0xFF6200EE),
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
