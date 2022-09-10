import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../pages/on_boarding/on_boarding_page.dart';
import 'is_authenticated.dart';

class SkipOnBoardingRoot extends StatelessWidget {
  const SkipOnBoardingRoot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => context.watch<User?>() == null
      ? false /*Configuration.get("skip_on_boarding")*/
          ? const IsAuthenticatedRoot()
          : const OnBoardingPage()
      : const IsAuthenticatedRoot();
}
