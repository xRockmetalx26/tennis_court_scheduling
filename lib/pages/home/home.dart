import 'package:agendamiento_canchas/models/schedule.dart';
import 'package:agendamiento_canchas/providers/provider_schedules.dart';
import 'package:agendamiento_canchas/constants/routes.dart';
import 'package:agendamiento_canchas/utils/maps.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final providerSchedules = Provider.of<ProviderSchedules>(context);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    print("builded home");

    return DefaultTabController(
        length: 3,
        child: Scaffold(
            floatingActionButton: FloatingActionButton(
                elevation: 2,
                backgroundColor: Colors.green.shade900,
                child: const Icon(Icons.add),
                onPressed: () =>
                    Navigator.of(context).pushNamed(Routes.addAgendamiento)),
            appBar: AppBar(
                elevation: 2,
                centerTitle: true,
                title: const Text("Tennis Courts"),
                backgroundColor: Colors.green.shade900,
                actions: [
                  // sign out
                  IconButton(
                      onPressed: () async =>
                          await FirebaseAuth.instance.signOut(),
                      icon: const Icon(Icons.logout))
                ],
                bottom: TabBar(
                    indicator: BoxDecoration(
                        color: Colors.green.shade200,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(6),
                            topRight: Radius.circular(6))),
                    tabs: [
                      for (final cancha in ProviderSchedules.tennisCourts)
                        Tab(text: cancha)
                    ])),
            body: TabBarView(children: [
              for (final cancha in ProviderSchedules.tennisCourts)
                Container(
                    color: Colors.green.shade400,
                    padding: EdgeInsets.symmetric(
                        horizontal: width * .1, vertical: height * .05),
                    child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.all(5),
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 20),
                        itemCount: Maps.sumLengthInMap(
                            providerSchedules.schedules[cancha]!),
                        itemBuilder: (context, index) {
                          final courtSchedules = providerSchedules
                              .schedules[cancha]!.values
                              .expand((e) => e)
                              .toList();

                          return _cardAgendamiento(context,
                              courtSchedules[index], providerSchedules);
                        }))
            ])));
  }

  Widget _cardAgendamiento(BuildContext context, Schedule schedule,
      ProviderSchedules providerSchedules) {
    return SizedBox(
        width: double.infinity,
        height: 100,
        child: Stack(children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, right: 10),
            child: Container(
              width: double.infinity,
              height: 150,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  color: Colors.green.shade100,
                  boxShadow: const [
                    BoxShadow(offset: Offset(0, 1), blurRadius: 2)
                  ]),
              child: Column(
                children: [
                  // user
                  Expanded(
                      child: Row(children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Icon(Icons.person, color: Colors.pink.shade200),
                    ),
                    Flexible(
                        child: Text("User: ${schedule.user}",
                            overflow: TextOverflow.ellipsis))
                  ])),
                  // date
                  Expanded(
                      child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Icon(Icons.date_range, color: Colors.blue),
                      ),
                      Flexible(
                          child: Text("Date: ${schedule.date}",
                              overflow: TextOverflow.ellipsis))
                    ],
                  )),
                  // time
                  Expanded(
                      child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Icon(Icons.cloud, color: Colors.grey),
                      ),
                      Flexible(
                          child: Text("POP: ${schedule.pop}",
                              overflow: TextOverflow.ellipsis))
                    ],
                  ))
                ],
              ),
            ),
          ),
          // delete
          Align(
              alignment: Alignment.topRight,
              child: Container(
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(offset: Offset(0, 1), blurRadius: 2)
                      ]),
                  child: CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.green.shade100,
                      child: IconButton(
                          padding: EdgeInsets.zero,
                          icon: Icon(Icons.delete_forever,
                              color: Colors.red.shade900, size: 30),
                          onPressed: () async {
                            final confirmation =
                                await _confirDeleteDialog(context);

                            if (confirmation == null) return;

                            if (confirmation) {
                              providerSchedules.removeSchedule(schedule);
                            }
                          }))))
        ]));
  }

  Future<bool?> _confirDeleteDialog(context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return Center(
              child: SizedBox(
                  child: SimpleDialog(
                      backgroundColor: Colors.green.shade100,
                      title: const Text("Quieres borrar este agendamiento?",
                          textAlign: TextAlign.center),
                      children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // no
                      MaterialButton(
                          elevation: 2,
                          color: Colors.red.shade600,
                          child: const Text("No"),
                          onPressed: () => Navigator.of(context).pop(false)),
                      // si
                      MaterialButton(
                          elevation: 2,
                          color: Colors.green.shade600,
                          child: const Text("Si"),
                          onPressed: () => Navigator.of(context).pop(true))
                    ])
              ])));
        });
  }
}
