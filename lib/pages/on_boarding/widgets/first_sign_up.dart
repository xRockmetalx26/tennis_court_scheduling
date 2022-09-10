import 'package:agendamiento_canchas/constants/routes.dart';
import 'package:agendamiento_canchas/widgets/primary_button.dart';
import 'package:agendamiento_canchas/widgets/protected_view.dart';
import 'package:flutter/material.dart';

class FirstSignUp extends StatefulWidget {
  const FirstSignUp({Key? key}) : super(key: key);

  @override
  State<FirstSignUp> createState() => _FirstSignUpState();
}

class _FirstSignUpState extends State<FirstSignUp> {
  @override
  Widget build(BuildContext context) => ProtectedView(_view,
      leftColor: Colors.green.shade400, rightColor: Colors.green.shade900);

  Widget _view() {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * .10),
      child: Column(children: [
        // image
        Padding(
            padding: EdgeInsets.only(top: height * .10),
            child: SizedBox(
                width: width * .50,
                child: Icon(Icons.app_registration,
                    size: width * .50, color: Colors.green.shade100))),
        // title
        Padding(
            padding: EdgeInsets.only(top: height * .05),
            child:
                const Text("Firtst Sign Up", style: TextStyle(fontSize: 36))),
        // text
        Padding(
            padding: EdgeInsets.only(top: height * .05),
            child: const Text(
                "First you must register with your email to start using the application.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22))),
        // continue
        Padding(
            padding: EdgeInsets.only(top: height * .05),
            child: PrimaryButton(
                width: width,
                onTap: () => Navigator.of(context).pushNamedAndRemoveUntil(
                    Routes.isAuthenticated, (route) => false),
                text: const Text("Continue",
                    style:
                        TextStyle(fontSize: 26, fontWeight: FontWeight.bold))))
      ]),
    );
  }
}
