import 'package:agendamiento_canchas/pages/home/home.dart';
import 'package:agendamiento_canchas/pages/on_boarding/widgets/forecast.dart';
import 'package:agendamiento_canchas/pages/on_boarding/widgets/first_sign_up.dart';
import 'package:agendamiento_canchas/pages/on_boarding/widgets/wellcome.dart';
import 'package:agendamiento_canchas/services/firebase_authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      context.watch<User?>() == null ? _view() : const Home();

  Widget _view() {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
        body: Stack(alignment: Alignment.bottomCenter, children: [
      PageView(
          controller: _pageController,
          children: const [Wellcome(), RainForecast(), FirstSignUp()]),
      Padding(
        padding: EdgeInsets.only(bottom: height * .10),
        child: SmoothPageIndicator(
            count: 3,
            controller: _pageController,
            effect: WormEffect(
              dotColor: Colors.green.shade100,
              activeDotColor: Colors.green.shade900,
            )),
      )
    ]));
  }

  final _pageController = PageController();
}
