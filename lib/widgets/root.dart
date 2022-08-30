import 'package:agendamiento_canchas/pages/on_boarding/on_boarding.dart';
import 'package:agendamiento_canchas/pages/sign_in/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:agendamiento_canchas/pages/home/home.dart';

class Root extends StatelessWidget {
  const Root({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      context.watch<User?>() == null ? const SignIn() : const Home();
}
