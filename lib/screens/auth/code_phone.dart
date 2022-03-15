
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mfqodaty/helpers/helpers.dart';
import 'package:mfqodaty/widget/app_text_field.dart';
import 'package:mfqodaty/widget/code_text_field.dart';

import 'login_screen.dart';

class CodePhoneScreen extends StatefulWidget {
  const CodePhoneScreen({Key? key, required this.phone}) : super(key: key);

  final String phone;

  @override
  _CodePhoneScreenState createState() => _CodePhoneScreenState();
}

class _CodePhoneScreenState extends State<CodePhoneScreen>
   with Helpers  {
  late TextEditingController _newPasswordTextController;
  late TextEditingController _newPasswordConfirmationTextController;

  late TextEditingController _firstCodeTextController;
  late TextEditingController _secondCodeTextController;
  late TextEditingController _thirdCodeTextController;
  late TextEditingController _fourthCodeTextController;

  late FocusNode _firstFocusNode;
  late FocusNode _secondFocusNode;
  late FocusNode _thirdFocusNode;
  late FocusNode _fourthFocusNode;

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

  String? _code;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _firstCodeTextController = TextEditingController();
    _secondCodeTextController = TextEditingController();
    _thirdCodeTextController = TextEditingController();
    _fourthCodeTextController = TextEditingController();

    _firstFocusNode = FocusNode();
    _secondFocusNode = FocusNode();
    _thirdFocusNode = FocusNode();
    _fourthFocusNode = FocusNode();

    _newPasswordTextController = TextEditingController();
    _newPasswordConfirmationTextController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _firstCodeTextController.dispose();
    _secondCodeTextController.dispose();
    _thirdCodeTextController.dispose();
    _fourthCodeTextController.dispose();

    _firstFocusNode.dispose();
    _secondFocusNode.dispose();
    _thirdFocusNode.dispose();
    _fourthFocusNode.dispose();

    _newPasswordTextController.dispose();
    _newPasswordConfirmationTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text('تسجيل مستخدم'),
        actions: [
          IconButton(onPressed: (){
            Navigator.pushReplacementNamed(context, '/signup_screen');
          }, icon: Icon(Icons.arrow_forward_ios)),
        ],
      ),
      body: ListView(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        children: [
          const Text(
            'ادخل الكود الخاص بك...',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          const Text(
            'ادخل الرمز الواصل لهاتفك من اليمين لليسار ..',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              // Expanded(
              //   child: CodeTextField(
              //     textEditingController: _firstCodeTextController,
              //     focusNode: _firstFocusNode,
              //     onChanged: (value) {
              //       if (value.isNotEmpty) {
              //         _secondFocusNode.requestFocus();
              //       }
              //     },
              //   ),
              // ),
              // const SizedBox(width: 10),
              // Expanded(
              //   child: CodeTextField(
              //     textEditingController: _secondCodeTextController,
              //     focusNode: _secondFocusNode,
              //     onChanged: (value) {
              //       value.isNotEmpty
              //           ? _thirdFocusNode.requestFocus()
              //           : _firstFocusNode.requestFocus();
              //     },
              //   ),
              // ),
              // const SizedBox(width: 10),
              // Expanded(
              //   child: CodeTextField(
              //     textEditingController: _thirdCodeTextController,
              //     focusNode: _thirdFocusNode,
              //     onChanged: (value) {
              //       value.isNotEmpty
              //           ? _fourthFocusNode.requestFocus()
              //           : _secondFocusNode.requestFocus();
              //     },
              //   ),
              // ),
              // const SizedBox(width: 10),
              // Expanded(
              //   child: CodeTextField(
              //     textEditingController: _fourthCodeTextController,
              //     focusNode: _fourthFocusNode,
              //     onChanged: (value) {
              //       if (value.isEmpty) _thirdFocusNode.requestFocus();
              //     },
              //   ),
              // ),
              Expanded(
                child: TextField(
                  keyboardType: TextInputType.phone,
                  obscureText: false,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'الرمز',
                      hintText: 'ادخل الرمز',
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                  ),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                  controller: otpController,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async => await performResetPassword(),
            child: const Text('دخول'),
            style: ElevatedButton.styleFrom(
              primary: Colors.indigo,
              minimumSize: const Size(0, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> performResetPassword() async {
      await resetPassword();
  }

//
  Future<void> verify() async {
    PhoneAuthCredential phoneAuthCredential =
    PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: otpController.text);
    signInWithPhoneAuthCredential(phoneAuthCredential);
    // Navigator.pushReplacementNamed(context, '/ho   // setState(() {
    //     //   loding=true;
    //     // });me_screen');
    print(phoneAuthCredential);
  }
  Future<void> resetPassword() async {
    // bool state = await AutController()
    //     .verifyOTP(context: context, code: getVerificationCode());
    // if (state) {
    //   Navigator.pushNamed(context, "/code_active_screen");
    // }

    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId:
        widget.phone, smsCode: otpController.text.toString());

    await auth.signInWithCredential(credential).then(
          (value)async {
        // setState(() {
        //   loding=false;
        // });
        print("You are logged in successfully then");
        var user=auth.currentUser!.uid;
        print("You are logged in successfully then "+user.toString());
        showSnackBar(
            context: context,
            message: "You are logged in successfully",
            error: false);
        print(credential.token.toString()+"idtoken phone then");
        print(credential.signInMethod.toString()+"idtoken phone then");


         Navigator.pushNamed(context, "/home_screen");
      },
    ).whenComplete(
          ()async {

        var user=auth.currentUser!.uid;
        print(credential.providerId.toString()+"idtoken phone whenComplete");
        Navigator.pushNamed(context, "/home_screen");
      },
    );
  }
}
