import 'dart:developer';
import 'package:agendamiento_canchas/services/firebase_authentication.dart';
import 'package:agendamiento_canchas/constants/routes.dart';
import 'package:agendamiento_canchas/utils/context.dart';
import 'package:agendamiento_canchas/utils/data_loader.dart';
import 'package:agendamiento_canchas/utils/snack_bar_manager.dart';
import 'package:agendamiento_canchas/widgets/protected_view.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) => ProtectedView(view,
      leftColor: Colors.green.shade400, rightColor: Colors.green.shade900);

  Widget view() {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: width * .1, vertical: height * .025),
      child: Column(children: [
        // title
        const Text(
          "Tennis Court Planner",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 32, color: Colors.white),
        ),
        // court
        Padding(
          padding: EdgeInsets.only(top: height * .05),
          child: SizedBox(
              height: height * .20,
              child: Image.asset('assets/images/cancha.png')),
        ),
        // form
        Padding(
          padding: EdgeInsets.only(top: height * .05),
          child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.green.shade200,
                  boxShadow: const [
                    BoxShadow(offset: Offset(0, 1), blurRadius: 2)
                  ]),
              child: Column(children: [
                // email
                TextFormField(
                    controller: _emailController,
                    onEditingComplete: () =>
                        context.requestFocus(_passwordFocus),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                        labelText: 'Email', suffixIcon: Icon(Icons.person))),
                // password
                TextFormField(
                    focusNode: _passwordFocus,
                    controller: _passwordController,
                    obscureText: _obscure,
                    decoration: InputDecoration(
                        labelText: 'Password',
                        suffixIcon: IconButton(
                            icon: Icon(_obscure
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: () => setState(() {
                                  _obscure = !_obscure;
                                })))),
                // sign in
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      color: Colors.green.shade900,
                      elevation: 4,
                      onPressed: _signIn,
                      textColor: Colors.white,
                      child: const Text('Sign In')),
                ),
                //sign up
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: RichText(
                        text: TextSpan(
                            text: 'No Account?  ',
                            style: const TextStyle(color: Colors.black),
                            children: [
                          TextSpan(
                              text: 'Sign Up',
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => context.push(Routes.signUp),
                              style: TextStyle(
                                  color: Colors.green.shade900,
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.w500))
                        ])))
              ])),
        )
      ]),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    _passwordFocus.dispose();

    super.dispose();
  }

  _signIn() async {
    final data = await DataLoader.loadData(
        context,
        () async => await context
            .read<FirebaseAuthentication>()
            .signInWithEmailAndPassword(
                email: _emailController.text.trim(),
                password: _passwordController.text.trim()));

    if (!mounted) return;

    final error = (data != "OK") ? true : false;
    if (error) {
      log('', error: data);
      SnackBarManager.show(
          context: context,
          icon: const Icon(Icons.error, color: Colors.white),
          message: Text(data));
    }
  }

  final _emailController = TextEditingController(text: 'admin@admin.com');
  final _passwordController = TextEditingController(text: 'admin66');
  final _passwordFocus = FocusNode();
  var _obscure = true;
}
