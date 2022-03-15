import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mfqodaty/prefs/shared_prefs.dart';
import 'package:mfqodaty/screens/auth/forget_password.dart';
import 'package:mfqodaty/screens/auth/login_screen.dart';
import 'package:mfqodaty/screens/auth/sign_up_screen.dart';
import 'package:mfqodaty/screens/home_screen.dart';
import 'package:mfqodaty/screens/lunch_screen.dart';
import 'package:mfqodaty/screens/out_boarding_screen.dart';
import 'package:mfqodaty/screens/person_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefController().initSharedPref();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      builder: ()=>MaterialApp(
        theme: ThemeData(
          fontFamily: 'Noto',
        ),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const[
          Locale('ar'),
        ],
        initialRoute: ('/lunch_screen'),
        routes: {
          '/lunch_screen' : (context) => LunchScreen(),
          '/main_screen' : (context) => OutBoardingScreen(),
          '/login_screen' : (context) => LoginScreen(),
          '/signup_screen' : (context) => SignUpScreen(),
          '/home_screen' : (context) => HomeScreen(),
          '/person_screen' : (context) => PersonScreen(),
          '/forget_password' : (context) => ForgetPasswordScreen(),
        },
      ),
    );
  }
}

