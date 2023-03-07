import 'package:flutter/material.dart';
import 'package:poswarehouse/constants/constants.dart';

class AppTextForm extends StatefulWidget {
  AppTextForm(
      {Key? key,
      this.decoration,
      this.keyboardType,
      this.controller,
      this.hintText,
      this.validator,
      this.isPassword = false,
      this.enabled = true,
      this.maxline,
      this.obscureText})
      : super(key: key);
  InputDecoration? decoration;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final String? hintText;
  final FormFieldValidator<String>? validator;
  final bool isPassword;
  final bool enabled;

  final dynamic obscureText;
  int? maxline;

  @override
  State<AppTextForm> createState() => _AppTextFormState();
}

class _AppTextFormState extends State<AppTextForm> {
  late bool _show = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.isPassword ? _show : false,
      controller: widget.controller,
      enabled: widget.enabled,
      keyboardType: widget.keyboardType,
      maxLines: widget.maxline ?? 1,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(15.0),
        fillColor: Color(0xFFF3F6FA),
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        hintText: widget.hintText,
        hintStyle: TextStyle(color: kSecondaryColor),
        suffixIcon: widget.isPassword
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    _show = !_show;
                  });
                },
                child: _show ? Image.asset('assets/icons/eye.png') : Image.asset('assets/icons/eye-slash.png'),
              )
            : null,
      ),
      validator: widget.validator,
    );
  }
}

class AppTextFormNumber extends StatefulWidget {
  AppTextFormNumber(
      {Key? key,
      this.controller,
      this.hintText,
      this.validator,
      this.isPassword = false,
      this.onChanged,
      this.autovalidateMode,
      this.errorText,
      required this.sty})
      : super(key: key);

  final TextEditingController? controller;
  final TextStyle sty;
  final String? hintText;
  final FormFieldValidator<String>? validator;
  final bool isPassword;
  final Function(String)? onChanged;
  final AutovalidateMode? autovalidateMode;
  final String? errorText;

  @override
  State<AppTextFormNumber> createState() => _AppTextFormNumberState();
}

class _AppTextFormNumberState extends State<AppTextFormNumber> {
  late bool _show = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.isPassword ? _show : false,
      controller: widget.controller,
      keyboardType: TextInputType.number,
      onChanged: widget.onChanged,
      autovalidateMode: widget.autovalidateMode,
      decoration: InputDecoration(
        errorText: widget.errorText,
        contentPadding: EdgeInsets.all(15.0),
        fillColor: Color(0xFFF3F6FA),
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        hintText: widget.hintText,
        hintStyle: TextStyle(color: kSecondaryColor),
        suffixIcon: widget.isPassword
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    _show = !_show;
                  });
                },
                child: _show ? Image.asset('assets/icons/eye.png') : Image.asset('assets/icons/eye-slash.png'),
              )
            : null,
      ),
      validator: widget.validator,
    );
  }
}

class AppTextFormEmail extends StatefulWidget {
  AppTextFormEmail({
    Key? key,
    this.controller,
    this.hintText,
    this.validator,
    this.isPassword = false,
  }) : super(key: key);

  final TextEditingController? controller;
  final String? hintText;
  final FormFieldValidator<String>? validator;
  final bool isPassword;

  @override
  State<AppTextFormEmail> createState() => _AppTextFormEmailState();
}

class _AppTextFormEmailState extends State<AppTextFormEmail> {
  late bool _show = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.isPassword ? _show : false,
      controller: widget.controller,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(10.0),
        fillColor: Color(0xFFF3F6FA),
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        hintText: widget.hintText,
        hintStyle: TextStyle(color: kSecondaryColor),
        suffixIcon: widget.isPassword
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    _show = !_show;
                  });
                },
                child: _show ? Image.asset('assets/icons/eye.png') : Image.asset('assets/icons/eye-slash.png'),
              )
            : null,
      ),
      validator: widget.validator,
    );
  }
}

class appTextFormField extends StatelessWidget {
  appTextFormField({super.key, this.preIcon, this.sufIcon, required this.sufPress, required this.horizontal, required this.vertical, this.controller});
  IconData? preIcon;
  IconData? sufIcon;
  VoidCallback sufPress;
  final double vertical;
  final double horizontal;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          contentPadding:
              EdgeInsets.symmetric(vertical: vertical, horizontal: horizontal),
          filled: true,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          prefixIcon: Icon(preIcon),
          suffixIcon: IconButton(
            onPressed: sufPress,
            icon: Icon(sufIcon))),
    );
  }
}

class appTextTowFormField extends StatelessWidget {
  appTextTowFormField({super.key, this.preIcon, this.sufIcon, required this.sufPress,  this.controller, this.labelText});
  IconData? preIcon;
  IconData? sufIcon;
  VoidCallback sufPress;
  final TextEditingController? controller;
  String? labelText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: '${labelText}',
          filled: true,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          prefixIcon: Icon(preIcon),
          suffixIcon: IconButton(
            onPressed: sufPress,
            icon: Icon(sufIcon))),
    );
  }
}
