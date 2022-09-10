import 'package:flutter/material.dart';

class ProtectedView extends StatelessWidget {
  const ProtectedView(this._view,
      {Key? key, Color? leftColor, Color? rightColor})
      : _leftColor = leftColor,
        _rightColor = rightColor,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
        child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                  _leftColor ?? Colors.white,
                  _rightColor ?? Colors.white
                ])),
            child: SafeArea(
                child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: SizedBox(
                        width: width,
                        height: height - MediaQuery.of(context).padding.top,
                        child: _view())))),
      ),
    );
  }

  final Function _view;
  final Color? _leftColor;
  final Color? _rightColor;
}
