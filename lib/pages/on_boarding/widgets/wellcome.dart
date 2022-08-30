import 'package:agendamiento_canchas/widgets/protected_view.dart';
import 'package:flutter/material.dart';

class Wellcome extends StatefulWidget {
  const Wellcome({Key? key}) : super(key: key);

  @override
  State<Wellcome> createState() => _WellcomeState();
}

class _WellcomeState extends State<Wellcome> {
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
            child: Icon(Icons.calendar_month_rounded,
                size: width * .50, color: Colors.green.shade100))),
        // title
        Padding(
        padding: EdgeInsets.only(top: height * .05),
        child: const Text("Welcome", style: TextStyle(fontSize: 36))),
        // text
        Padding(
        padding: EdgeInsets.only(top: height * .05),
        child: const Text(
            "With this application you can schedule tennis courts.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 22)))
      ]),
    );
  }
}
