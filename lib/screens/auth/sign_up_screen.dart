import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mfqodaty/controller/fb_auth_controller.dart';
import 'package:mfqodaty/helpers/helpers.dart';
import 'package:mfqodaty/screens/auth/code_phone.dart';
import 'package:mfqodaty/screens/auth/login_screen.dart';
import 'package:mfqodaty/widget/input_text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> with Helpers {
  late TextEditingController _emailTextController;
  late TextEditingController _phoneTextController;
  late TextEditingController _passwordTextController;
  late TextEditingController _userNameTextController;

  var otpController = TextEditingController();
  var numController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;



  String verificationId = "";

  void signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    try {
      final authCredential =
      await auth.signInWithCredential(phoneAuthCredential);

      if (authCredential.user != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const LoginScreen()));
      }
    } on FirebaseAuthException catch (e) {
      print("catch");
    }
  }

  bool phone = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailTextController = TextEditingController();
    _phoneTextController = TextEditingController();
    _passwordTextController = TextEditingController();
    _userNameTextController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailTextController.dispose();
    _phoneTextController.dispose();
    _passwordTextController.dispose();
    _userNameTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          toolbarHeight: 80.h,
          title: Text(
            'سجل الان',
            style: TextStyle(
              color: Colors.indigo,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/login_screen');
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black54,
            ),
          )),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  'تسجيل حساب جديد',
                  style: TextStyle(fontSize: 28.sp),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  'اكمل التفاصيل الخاصة بك ',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14.sp),
                ),
                SizedBox(
                  height: 30.h,
                ),
                InputTextField(
                  controller: _userNameTextController,
                  lable: 'اسم المستخدم',
                  hintText: 'ادخال اسم المستخدم ',
                  obscure: true,
                  hasIcon: false,
                  onChanged: (value) {
                    setState(() {
                      _userNameTextController;
                    });
                  },
                ),
                SizedBox(height: 25.h),
                InputTextField(
                  controller: _emailTextController,
                  hintText: 'ادخل البريد الالكتروني',
                  lable: 'Email',
                  onChanged: (value) {
                    setState(() {
                      _emailTextController;
                    });
                  },
                  hasIcon: false,
                ) ,
                SizedBox(height: 25.h),
                 InputTextField(
                  controller: _passwordTextController,
                  lable: 'Password',
                  hintText: 'ادخل كلمة المرور',
                  obscure: true,
                  hasIcon: true,
                  onChanged: (value) {
                    setState(() {
                      _passwordTextController;
                    });
                  },
                ),
                SizedBox(height: 30.h),
                ElevatedButton(
                  onPressed: () async =>  await performRegister(),
                  child: Text(
                    'تسجيل الحساب',
                    style: TextStyle(color: Colors.white, fontSize: 18.sp),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.indigo,
                      minimumSize: Size(double.infinity, 60.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      )),
                ),
                SizedBox(height: 30.h),
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
                      width: 10,
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
                SizedBox(height: 10.h),
                Text(
                  'الاستمرار في تأكيد موافقتك \n يعني القبول بالسياسة الخاصة بنا',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> performRegister() async {
    if (checkData()) {
      await register();
    }
  }

  bool checkData() {
    if (_emailTextController.text.isNotEmpty &&
        _passwordTextController.text.isNotEmpty) {
      return true;
    }
    showSnackBar(
      context: context,
      message: 'Enter required data!',
      error: true,
    );
    return false;
  }

  Future<void> register() async {
    bool status = await FbAuthController().createAccount(
        context: context,
        email: _emailTextController.text,
        username: _userNameTextController.text,
        password: _passwordTextController.text ,);
    if (status) {
      Navigator.pushReplacementNamed(context, '/login_screen');
    }
  }


  // Future<void> fetchotp() async {
  //   await auth.verifyPhoneNumber(
  //     phoneNumber: '+972${_phoneTextController.text.toString()}',
  //     verificationCompleted: (PhoneAuthCredential credential) async {
  //       await auth.signInWithCredential(credential);
  //     },
  //
  //     verificationFailed: (FirebaseAuthException e) {
  //       if (e.code == 'invalid-phone-number') {
  //         print('The provided phone number is not valid.');
  //       }
  //     },
  //
  //     codeSent: (String verificationId, int? resendToken) async {
  //       this.verificationId = verificationId;
  //       print(verificationId);
  //       Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) =>
  //               CodePhoneScreen(phone: verificationId),
  //         ),
  //       );
  //     },
  //     codeAutoRetrievalTimeout: (String verificationId) {
  //     },
  //   );
  // }
}
