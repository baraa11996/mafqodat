import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mfqodaty/controller/fb_auth_controller.dart';
import 'package:mfqodaty/helpers/helpers.dart';
import 'package:mfqodaty/widget/input_text_field.dart';

import '../../prefs/shared_prefs.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>  with Helpers {
  bool isvalue = false;
  late TextEditingController _mobileEditingController;
  late TextEditingController _passwordEditingController;

  @override
  void initState() {
    super.initState();
    _mobileEditingController = TextEditingController();
    _passwordEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _mobileEditingController.dispose();
    _passwordEditingController.dispose();
    super.dispose();
  }

  late UserCredential userCredential;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: 80.h,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'تسجيل الدخول',
          style: TextStyle(color: Colors.indigo, fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.only(
          right: 30.r,
          left: 30.r,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 15.h),
                Text(
                  "مرحبا بك",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 15.h),
                const Text(
                  "تسجيل الدخول بواسطة البريد الالكتروني وكلمة المرور او رقم الهاتف ",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 40.h),
                // AppTextFiled(
                //     controller: _mobileEditingController,
                //     hint: 'Enter Your Email',
                //     lable: 'Email',
                //     suffixIcon: Icons.email_outlined),
                InputTextField(
                  controller: _mobileEditingController,
                  lable: 'Mobile',
                  hintText: 'ادخل البريد الالكتروني',
                  obscure: false,
                  hasIcon: false,
                  prefxIon: Icons.phone,
                  onChanged: (value) {
                    setState(() {
                      _mobileEditingController;
                    });
                  },
                ),
                SizedBox(height: 25.h),
                // AppTextFiled(
                //     obscureText: true,
                //     controller: _passwordEditingController,
                //     hint: 'Enter Your Password',
                //     lable: 'Password',
                //     suffixIcon: Icons.lock_outline),
                InputTextField(
                  controller: _passwordEditingController,
                  lable: 'Password',
                  hintText: 'ادخل كلمة المرور',
                  obscure: true,
                  hasIcon: true,
                  onChanged: (value) {
                    setState(() {
                      _passwordEditingController;
                    });
                  },
                ),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    Checkbox(
                      value: this.isvalue,
                      activeColor: Colors.indigo,
                      onChanged: (value) {
                        setState(() {
                          isvalue = value!;
                        });
                      },
                    ),
                    Text('تذكرني'),
                    Spacer(),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/forget_password');
                      },
                      child: Text('نسيت كلمة المرور'),
                    ),
                  ],
                ),
                SizedBox(height: 25.h),
                ElevatedButton(
                  onPressed: () async => await performLogin(),
                  // runSingInButton()
                  //     ? () async {
                  //   await performLogin();

                  child: Text(
                    'تسجيل',
                    style: TextStyle(color: Colors.white, fontSize: 18.sp),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.indigo,
                      minimumSize: Size(double.infinity, 60.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      )),
                ),
                SizedBox(height: 35.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: CircleAvatar(
                        radius: 27,
                        backgroundColor: Colors.grey.shade200,
                        child: SvgPicture.asset(
                          'images/facebook-2.svg',
                          width: 17.w,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    GestureDetector(
                      child: CircleAvatar(
                        radius: 27,
                        backgroundColor: Colors.grey.shade200,
                        child: SvgPicture.asset(
                          'images/google-icon.svg',
                          width: 20.w,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    GestureDetector(
                      child: CircleAvatar(
                        radius: 27,
                        backgroundColor: Colors.grey.shade200,
                        child: SvgPicture.asset(
                          'images/twitter.svg',
                          height: 20.h,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'لا يوجد لديك حساب؟',
                      style: TextStyle(color: Colors.grey),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/signup_screen');
                      },
                      child: Text(
                        ' سجل الان',
                        style: TextStyle(color: Colors.indigo),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> performLogin() async {
    if (checkData()) {
      await login();
    }
  }

  bool checkData() {
    if (_mobileEditingController.text.isNotEmpty &&
        _passwordEditingController.text.isNotEmpty) {
      return true;
    }
    showSnackBar(
      context: context,
      message: 'Enter required data!',
      error: true,
    );
    return false;
  }

  Future<void> login() async {
    bool status = await FbAuthController().signIn(
        context: context,
        email: _mobileEditingController.text,
        password: _passwordEditingController.text);
    if (status) {
      SharedPrefController().saveLogin();
      Navigator.pushReplacementNamed(context, '/home_screen');
    }
  }
}
