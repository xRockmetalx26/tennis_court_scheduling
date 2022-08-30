import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton(
      {required this.onTap,
      required this.text,
      this.width,
      this.height,
      this.color,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
            width: width ?? MediaQuery.of(context).size.width * .80,
            height: height ?? 40,
            decoration: BoxDecoration(
                color: color ?? Colors.green.shade100,
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(blurRadius: 2, offset: Offset(0, 1))
                ]),
            child: Center(child: text)));
  }

  final VoidCallback onTap;
  final Text? text;
  final double? width;
  final double? height;
  final Color? color;
}
