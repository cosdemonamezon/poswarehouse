import 'package:flutter/material.dart';
import 'package:poswarehouse/constants/constants.dart';

class CardDashboardWidget extends StatelessWidget {
  const CardDashboardWidget(
      {super.key,
      required this.size,
      required this.title,
      required this.price,
      required this.iconData});

  final Size size;
  final String title;
  final String price;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 2,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Color(0xFFF3F3F3),
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: size.height * 0.01),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                iconData,
                size: 40,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.01),
                child: Column(
                  children: [
                    Text(
                      '${title}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: kPrimaryColor),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Text('${price}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}