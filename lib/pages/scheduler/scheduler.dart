import 'package:agendamiento_canchas/models/schedule.dart';
import 'package:agendamiento_canchas/providers/provider_schedules.dart';
import 'package:agendamiento_canchas/services/pop.dart';
import 'package:agendamiento_canchas/utils/context.dart';
import 'package:agendamiento_canchas/utils/date_time_converter.dart';
import 'package:agendamiento_canchas/utils/snack_bar_manager.dart';
import 'package:agendamiento_canchas/widgets/primary_button.dart';
import 'package:agendamiento_canchas/widgets/protected_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Scheduler extends StatefulWidget {
  const Scheduler({Key? key}) : super(key: key);

  @override
  State<Scheduler> createState() => _SchedulerState();
}

class _SchedulerState extends State<Scheduler> {
  @override
  Widget build(BuildContext context) {
    print("builded scheduler");

    return ProtectedView(_view,
        leftColor: Colors.green.shade400, rightColor: Colors.green.shade900);
  }

  Widget _view() {
    final height = MediaQuery.of(context).size.height;

    return Theme(
      data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(
              primary: Colors.green.shade900)),
      child: Stepper(
          currentStep: _index,
          controlsBuilder: (context, details) {
            return _index < 4
                ? Padding(
                    padding: EdgeInsets.only(top: height * .025),
                    child: PrimaryButton(
                        onTap: () {
                          setState(() {
                            if (_index < 4) _index++;
                          });
                        },
                        text: const Text("Continue",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16))))
                : const SizedBox();
          },
          onStepTapped: (index) {
            setState(() {
              _index = index;
            });
          },
          steps: [
            // tennis court picker
            Step(
                state: _index > 0 ? StepState.complete : StepState.indexed,
                isActive: _index > 0,
                title: const Text("Tennis Court"),
                content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      for (final court in ProviderSchedules.tennisCourts)
                        PrimaryButton(
                            onTap: () => setState(() {
                                  _pickedCourt = court;

                                  for (final court in _courtsController.keys) {
                                    _courtsController[court] = false;
                                  }

                                  _courtsController[_pickedCourt] = true;
                                }),
                            text: Text(court,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16)),
                            color: _courtsController[court] == true
                                ? Colors.green.shade900
                                : Colors.green.shade100,
                            width: 60,
                            height: 50)
                    ])),
            // user input
            Step(
              state: _index > 1
                  ? _usuarioController.text.isNotEmpty
                      ? StepState.complete
                      : StepState.error
                  : StepState.indexed,
              isActive: _index > 1 && _usuarioController.text.isNotEmpty,
              title: const Text("User"),
              content: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.green.shade100,
                      boxShadow: const [
                        BoxShadow(offset: Offset(0, 1), blurRadius: 2)
                      ]),
                  child: TextField(
                      textAlignVertical: TextAlignVertical.center,
                      controller: _usuarioController,
                      cursorColor: Colors.blue,
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          hintText: "User",
                          suffixIcon: Icon(Icons.person, color: Colors.grey),
                          border: InputBorder.none))),
            ),
            // date input
            Step(
              state: _index > 2 ? StepState.complete : StepState.indexed,
              isActive: _index > 2,
              title: const Text("Date"),
              content: Container(
                height: height * .40,
                decoration: BoxDecoration(
                    color: Colors.green.shade100,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(offset: Offset(0, 1), blurRadius: 2)
                    ]),
                child: CalendarDatePicker(
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 7)),
                    onDateChanged: (date) {
                      _pickedDateTime = DateTimeConverter.toYMDString(date); 
                    }),
              ),
            ),
            // POP info
            Step(
              state: _index > 3 ? StepState.complete : StepState.indexed,
              isActive: _index > 3,
              title: const Text("Probability Of Rain"),
              content: FutureBuilder<Map<String, String>>(
                future: POP.popEightDays(
                    "8.3457",
                    "-62.6501",
                    "38ff661b277d2131d9510cff179ec0e3" /*Personal Api Key*/),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    return Container(
                        height: 80,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.green.shade100,
                            boxShadow: const [
                              BoxShadow(offset: Offset(0, 1), blurRadius: 2)
                            ]),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(children: const [
                                Icon(Icons.cloud, color: Colors.grey),
                                Text('Probability Of Rain',
                                    style: TextStyle(fontSize: 12))
                              ]),
                              Text("${selectPOP(snapshot.data!)} %",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 22))
                            ]));
                  }

                  return Container(
                      width: 80,
                      height: 80,
                      padding: const EdgeInsets.all(20),
                      child: const CircularProgressIndicator());
                },
              ),
            ),
            // finish
            Step(
                state: _index == 4 ? StepState.complete : StepState.indexed,
                isActive: _index == 4,
                title: const Text("Finish"),
                content: PrimaryButton(
                  onTap: () async {
                    if (_usuarioController.text.isEmpty) {
                      SnackBarManager.show(
                          context: context,
                          icon: const Icon(Icons.error, color: Colors.white),
                          message: const Text("User field must not be empty"));
                    } else {
                      final isAdded = context
                          .read<ProviderSchedules>()
                          .addShedule(Schedule(
                              tennisCourt: _pickedCourt,
                              date: _pickedDateTime,
                              user: _usuarioController.text,
                              pop: _pop));

                      if (!isAdded) {
                        await _showErrorDialog();
                      }

                      if (mounted) context.pop();
                    }
                  },
                  text: const Text("Finish",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ))
          ]),
    );
  }

  String selectPOP(Map<String, String> pops) {
    if (pops.isEmpty) return "Error";

    final pop = double.parse(pops[_pickedDateTime]!) * 100;

    _pop = pop.toString().substring(0, 4);

    return _pop;
  }

  _showErrorDialog() async {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    await showDialog(
        context: context,
        builder: (context) {
          return Center(
              child: SizedBox(
                  width: width * .80,
                  height: height * .60,
                  child: SimpleDialog(
                      insetPadding: EdgeInsets.zero,
                      titlePadding: EdgeInsets.zero,
                      contentPadding: EdgeInsets.zero,
                      backgroundColor: Colors.green.shade100,
                      children: [
                        // message
                        const Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Text(
                            "The scheduling limit for this date has already been reached",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 22,
                            ),
                          ),
                        ),
                        // ok
                        Padding(
                            padding: const EdgeInsets.all(20),
                            child: Center(
                                child: GestureDetector(
                              onTap: () => context.pop(),
                              child: Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                      color: Colors.green.shade900,
                                      borderRadius: BorderRadius.circular(15),
                                      boxShadow: const [
                                        BoxShadow(
                                            blurRadius: 2, offset: Offset(0, 1))
                                      ]),
                                  child: const Center(
                                      child: Text("Continue",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16)))),
                            )))
                      ])));
        });
  }

  final _usuarioController = TextEditingController(text: "rockmetal");
  final _courtsController = {"A": true, "B": false, "C": false};
  var _index = 0;
  var _pickedCourt = "A";
  var _pickedDateTime = DateTimeConverter.toYMDString(DateTime.now());
  var _pop = "";
}
