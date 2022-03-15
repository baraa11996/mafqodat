
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mfqodaty/widget/out_boarding_indcator.dart';

import 'out_boarding_contact.dart';

class OutBoardingScreen extends StatefulWidget {
  const OutBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OutBoardingScreen> createState() => _OutBoardingScreenState();
}

class _OutBoardingScreenState extends State<OutBoardingScreen> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            right: 30,
            left: 30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 40,
              ),
              ConstrainedBox(
                constraints: const BoxConstraints(
                    minWidth: 0,
                    maxWidth: double.infinity,
                    minHeight: 0,
                    maxHeight: 550),
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (value) {
                    setState(() {
                      _currentPage = value;
                    });
                  },
                  children: const [
                    OutBoardingContent(
                      text: 'يعمل تطبيق مفقوداتي على العثور على المفقودات التي فقدها المواطنين  ',
                      text2: 'حيث ينقسم التطبيق الى قسمين هما الابلاغ عن ايجاد شيئ ',
                      text3: 'او الابلاغ عن شيء مفقود بكل معايير الحماية والسرية ',
                      height: 262,
                      width: 238,
                      image: 'images/out1.jpg',
                    ),

                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutBoardingIndicator(
                      marginEnd: 10, selected: _currentPage == 0),
                  // OutBoardingIndicator(
                  //     marginEnd: 10, selected: _currentPage == 1),
                  // OutBoardingIndicator(selected: _currentPage == 2),
                ],
              ),
              SizedBox(height: 50,),
              ElevatedButton(
                onPressed: () {
                  Navigator.popAndPushNamed(context, '/login_screen');
                },
                child: const Text(
                  'اٍبدا',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.indigo,
                  minimumSize: const Size(double.infinity, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
