import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    Key? key,
    required this.onTap,
    this.enabled = true,
    this.inverted = false,
    required this.child,
  }) : super(key: key);

  final bool enabled;
  final bool inverted;
  final void Function() onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (enabled) {
          onTap();
        }
      },
      radius: 12,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        height: 50,
        alignment: Alignment.center,
        child: child,
      ),
    );
  }
}
