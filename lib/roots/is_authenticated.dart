import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../pages/home/home.dart';
import '../pages/sign_in/sign_in_page.dart';

class IsAuthenticatedRoot extends StatelessWidget {
  const IsAuthenticatedRoot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      context.watch<User?>() == null ? const SignInPage() : const HomePage();
}
