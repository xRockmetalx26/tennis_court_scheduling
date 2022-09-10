import 'package:agendamiento_canchas/pages/on_boarding/widgets/forecast.dart';
import 'package:agendamiento_canchas/pages/on_boarding/widgets/first_sign_up.dart';
import 'package:agendamiento_canchas/pages/on_boarding/widgets/wellcome.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) => _view();

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
