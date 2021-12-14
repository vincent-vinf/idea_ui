import 'package:flutter/material.dart';
import 'package:idea/pages/login.dart';
import 'package:idea/util/token.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  final pages = [
    PageViewModel(
      pageColor: const Color(0xFF03A9F4),
      // iconImageAssetPath: 'assets/air-hostess.png',
      bubble: Image.asset(
          'assets/image/init/Flame_Design_Science_transparent_by_Icons8.gif'),
      body: const Text(
        'Hassle-free  booking  of  flight  tickets  with  full  refund  on  cancellation',
      ),
      title: const Text(
        'Flights',
      ),
      titleTextStyle:
          const TextStyle(fontFamily: 'MyFont', color: Colors.white),
      bodyTextStyle: const TextStyle(fontFamily: 'MyFont', color: Colors.white),
      mainImage: Image.asset(
        'assets/image/init/Flame_Design_Science_transparent_by_Icons8.gif',
        height: 285.0,
        width: 285.0,
        alignment: Alignment.center,
      ),
    ),
    PageViewModel(
      pageColor: const Color(0xFF8BC34A),
      iconImageAssetPath:
          'assets/image/init/Flame_Remote_Working_transparent_by_Icons8.gif',
      body: const Text(
        'We  work  for  the  comfort ,  enjoy  your  stay  at  our  beautiful  hotels',
      ),
      title: const Text('Hotels'),
      mainImage: Image.asset(
        'assets/image/init/Flame_Remote_Working_transparent_by_Icons8.gif',
        height: 285.0,
        width: 285.0,
        alignment: Alignment.center,
      ),
      titleTextStyle:
          const TextStyle(fontFamily: 'MyFont', color: Colors.white),
      bodyTextStyle: const TextStyle(fontFamily: 'MyFont', color: Colors.white),
    ),
    PageViewModel(
      pageBackground: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            stops: [0.0, 1.0],
            begin: FractionalOffset.topCenter,
            end: FractionalOffset.bottomCenter,
            tileMode: TileMode.repeated,
            colors: [
              Colors.orange,
              Colors.pinkAccent,
            ],
          ),
        ),
      ),
      iconImageAssetPath:
          'assets/image/init/Flame_Training_transparent_by_Icons8.gif',
      body: const Text(
        'Easy  cab  booking  at  your  doorstep  with  cashless  payment  system',
      ),
      title: const Text('Cabs'),
      mainImage: Image.asset(
        'assets/image/init/Flame_Training_transparent_by_Icons8.gif',
        height: 285.0,
        width: 285.0,
        alignment: Alignment.center,
      ),
      titleTextStyle:
          const TextStyle(fontFamily: 'MyFont', color: Colors.white),
      bodyTextStyle: const TextStyle(fontFamily: 'MyFont', color: Colors.white),
    ),
    // PageViewModel(
    //   pageColor: const Color(0xFF03A9F4),
    //   // iconImageAssetPath: 'assets/air-hostess.png',
    //   bubble: Image.asset('assets/air-hostess.png'),
    //   body: const Text(
    //     'Hassle-free  booking  of  flight  tickets  with  full  refund  on  cancellation',
    //   ),
    //   title: const Text(
    //     'Flights',
    //   ),
    //   titleTextStyle:
    //   const TextStyle(fontFamily: 'MyFont', color: Colors.white),
    //   bodyTextStyle: const TextStyle(fontFamily: 'MyFont', color: Colors.white),
    //   mainImage: Image.asset(
    //     'assets/airplane.png',
    //     height: 285.0,
    //     width: 285.0,
    //     alignment: Alignment.center,
    //   ),
    // ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: IntroViewsFlutter(
        pages,
        showNextButton: true,
        showBackButton: true,
        onTapDoneButton: () {
          isFirstInit = false;
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ));
        },
        pageButtonTextStyles: const TextStyle(
          color: Colors.white,
          fontSize: 18.0,
        ),
      ),
    );
  }
}
