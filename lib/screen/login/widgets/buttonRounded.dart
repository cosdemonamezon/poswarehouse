import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:poswarehouse/constants/constants.dart';

class ButtonRounded extends StatelessWidget {
  final String text;
  final Color color;
  final Color textColor;
  final Color? boderColor;
  final VoidCallback? onPressed;
  final Color? iconColor;
  final String? iconImage;

  const ButtonRounded({
    Key? key,
    required this.text,
    required this.color,
    required this.textColor,
    this.onPressed,
    this.boderColor,
    this.iconColor,
    this.iconImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AbsorbPointer(
      absorbing: onPressed != null ? false : true,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          elevation: MaterialStateProperty.all<double>(0.0),
          backgroundColor: MaterialStateProperty.all<Color>(onPressed != null ? color : kDisableColor),
          padding: MaterialStateProperty.all(
            EdgeInsets.symmetric(vertical: 13),
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              side: BorderSide(color: onPressed != null ? boderColor ?? color : kDisableColor),
              borderRadius: BorderRadius.all(Radius.circular(size.height / 80)),
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            iconImage != null
                ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2.5),
                    child: SvgPicture.asset(iconImage.toString(),
                        height: 12, width: 12, color: iconColor),
                  )
                : SizedBox.shrink(),
            Text(
              text,
              style: TextStyle(color: textColor),
            ),
          ],
        ),
        
      ),
    );
  }
}
