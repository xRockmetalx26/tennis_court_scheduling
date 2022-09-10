import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import 'package:agendamiento_canchas/pages/on_boarding/on_boarding_page.dart';
import 'package:agendamiento_canchas/pages/scheduler/scheduler_page.dart';
import 'package:agendamiento_canchas/pages/home/home.dart';
import 'package:agendamiento_canchas/pages/sign_in/sign_in_page.dart';
import 'package:agendamiento_canchas/pages/sign_up/sign_up_page.dart';
import 'package:agendamiento_canchas/constants/routes.dart';
import 'package:agendamiento_canchas/roots/is_authenticated.dart';
import 'package:agendamiento_canchas/roots/skip_on_boarding_root.dart';
import 'package:agendamiento_canchas/services/firebase_authentication.dart';
import 'package:agendamiento_canchas/providers/provider_schedules.dart';

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
        initialRoute: Routes.skipOnBoarding,
        routes: {
          Routes.skipOnBoarding: (context) => const SkipOnBoardingRoot(),
          Routes.onBoarding: (context) => const OnBoardingPage(),
          Routes.isAuthenticated: (context) => const IsAuthenticatedRoot(),
          Routes.signIn: (context) => const SignInPage(),
          Routes.signUp: (context) => const SignUpPage(),
          Routes.home: (context) => const HomePage(),
          Routes.addAgendamiento: (context) => const SchedulerPage()
        });
  }
}
