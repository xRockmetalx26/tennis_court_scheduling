import 'package:agendamiento_canchas/widgets/protected_view.dart';
import 'package:flutter/material.dart';

class RainForecast extends StatefulWidget {
  const RainForecast({Key? key}) : super(key: key);

  @override
  State<RainForecast> createState() => _RainForecastState();
}

class _RainForecastState extends State<RainForecast> {
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
            child: Icon(Icons.cloudy_snowing,
                size: width * .50, color: Colors.green.shade100))),
        // title
        Padding(
        padding: EdgeInsets.only(top: height * .05),
        child: const Text("Rain Forecast", style: TextStyle(fontSize: 36))),
        // text
        Padding(
        padding: EdgeInsets.only(top: height * .05),
        child: const Text(
            "You can also know the rain forecast for the scheduled day.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 22)))
      ]),
    );
  }
}
