import 'package:agendamiento_canchas/pages/on_boarding/on_boarding.dart';
import 'package:agendamiento_canchas/pages/scheduler/scheduler.dart';
import 'package:agendamiento_canchas/pages/home/home.dart';
import 'package:agendamiento_canchas/pages/sign_in/sign_in.dart';
import 'package:agendamiento_canchas/pages/sign_up/sign_up.dart';
import 'package:agendamiento_canchas/constants/routes.dart';
import 'package:agendamiento_canchas/services/firebase_authentication.dart';
import 'package:agendamiento_canchas/providers/provider_schedules.dart';
import 'package:agendamiento_canchas/widgets/root.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  Provider.debugCheckInvalidValueType = null;

  runApp(const Providers());
}

class Providers extends StatelessWidget {
  const Providers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      Provider(
          create: (context) => FirebaseAuthentication(FirebaseAuth.instance)),
      ChangeNotifierProvider(create: (context) => ProviderSchedules()),
      StreamProvider(
          create: (context) =>
              context.read<FirebaseAuthentication>().idTokenChanges,
          initialData: null)
    ], child: const App());
  }
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Agendado De Canchas",
        initialRoute: Routes.onBoarding,
        routes: {
          Routes.onBoarding: (context) => const OnBoarding(),
          Routes.root: (context) => const Root(),
          Routes.signIn: (context) => const SignIn(),
          Routes.signUp: (context) => const SignUp(),
          Routes.home: (context) => const Home(),
          Routes.addAgendamiento: (context) => const Scheduler()
        });
  }
}
