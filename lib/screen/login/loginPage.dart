import 'package:flutter/material.dart';
import 'package:poswarehouse/constants/constants.dart';
import 'package:poswarehouse/screen/home/homePage.dart';
import 'package:poswarehouse/screen/login/loginService.dart';
import 'package:poswarehouse/screen/login/widgets/appTextForm.dart';
import 'package:poswarehouse/widgets/LoadingDialog.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.08,
            ),
            Center(
              child: SizedBox(
                  width: 300,
                  height: 200,
                  child: Image.asset(
                    'assets/images/welcome.jpg',
                    fit: BoxFit.fitWidth,
                  )),
            ),
            SizedBox(
              height: size.height * 0.08,
            ),
            SizedBox(
              width: size.width * 0.40,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      'ชื่อผู้ใช้',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: size.height * 0.01),
                    child: AppTextForm(
                      controller: username,
                      hintText: 'กรอกชื่อผู้ใช้',
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'กรุณากรอกชื่อผู้ใช้';
                        } else if (RegExp(r'\s').hasMatch(val)) {
                          return 'รูปแบบไม่ถูกต้อง';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      'รหัสผ่าน',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: size.height * 0.01),
                    child: AppTextForm(
                        controller: password,
                        hintText: 'รหัสผ่าน',
                        isPassword: true,
                        validator: (val) {
                          final regExp = RegExp(
                            r'^(?=.*\d)(?=.*[a-zA-Z]).{0,}$',
                          );
                          if (val == null || val.isEmpty) {
                            return 'กรุณากรอกพาสเวิร์ด';
                          }
                          if (val.length < 2 || val.length > 20) {
                            return 'พาสเวิร์ต้องมีความยาว 8 อักษรขึ้นไป';
                          }
                          // if (!regExp.hasMatch(val)) {
                          //   return 'รูปแบบพาสเวิร์ไม่ถูกต้อง';
                          // }
                          return null;
                        }),
                  ),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: GestureDetector(
                      onTap: () async {
                        // try {
                        // LoadingDialog.open(context);
                        await LoginService.login(username.text, password.text);
                        if (mounted) {
                          // LoadingDialog.close(context);

                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                            (route) => false,
                          );
                        }
                        // } catch (e) {
                        //   LoadingDialog.close(context);
                        //   showDialog<String>(
                        //     context: context,
                        //     builder: (BuildContext context) => AlertDialog(
                        //       shape: RoundedRectangleBorder(
                        //         borderRadius: BorderRadius.circular(15.0),
                        //       ),
                        //       // backgroundColor: Color.fromARGB(255, 95, 9, 3),
                        //       title: Text('Error'),
                        //       content: Text(e.toString()),
                        //       actions: <Widget>[
                        //         TextButton(
                        //           onPressed: () => Navigator.pop(context),
                        //           child: const Text('ตกลง'),
                        //         ),
                        //       ],
                        //     ),
                        //   );
                        // }
                      },
                      child: Container(
                        width: size.width * 0.5,
                        height: size.height * 0.08,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: kPrimaryColor),
                        child: Center(
                          child: Text(
                            'เข้าสู่ระบบ',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
