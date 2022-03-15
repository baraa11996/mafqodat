
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mfqodaty/controller/fb_auth_controller.dart';
import 'package:mfqodaty/helpers/helpers.dart';
import 'package:mfqodaty/widget/input_text_field.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> with Helpers {
  late TextEditingController _mobileEditingController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _mobileEditingController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _mobileEditingController.dispose();
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
            'نسيت كلمة المرور',
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
            padding: EdgeInsets.symmetric(
              horizontal: 30,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 54.h,
                ),
                Text(
                  'نسيت كلمة المرور',
                  style: TextStyle(fontSize: 28.sp),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  'رجاءا قم بادخال البريد الالكتروني الخاص بك \n لنرسل لك رابط اعادة تعيين كلمة المرور',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14.sp),
                ),
                SizedBox(
                  height: 80.h,
                ),
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
                SizedBox(
                  height: 80.h,
                ),
                ElevatedButton(
                  onPressed: () async => await performForgetPassword(),
                  child: Text(
                    'ارسال',
                    style: TextStyle(color: Colors.white, fontSize: 18.sp),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.indigo,
                      minimumSize: Size(double.infinity, 60.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      )),
                ),
                SizedBox(
                  height: 132.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '  لا يوجد لديك حساب ؟',
                      style: TextStyle(color: Colors.grey),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/signup_screen');
                      },
                      child: Text(
                        ' سجل الأن',
                        style: TextStyle(color: Colors.indigo),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> performForgetPassword() async {
    if (checkData()) {
      await forgetPassword();
    }
  }

  bool checkData() {
    if (_mobileEditingController.text.isNotEmpty) {
      return true;
    }
    showSnackBar(
      context: context,
      message: 'Enter required data!',
      error: true,
    );
    return false;
  }

  Future<void> forgetPassword() async {
    bool status = await FbAuthController().forgetPassword(context: context, email: _mobileEditingController.text);
    if(status) {
      Navigator.pop(context);
    }
  }

}
