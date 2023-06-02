import 'package:flutter/material.dart';

class LinesBlastButton extends StatefulWidget {
  const LinesBlastButton(
      {
        required Key key,
        required this.onPressed,
        required this.child,
      }) : super(key: key);

  final Function()? onPressed;
  final Widget? child;

  @override
  State<LinesBlastButton> createState() => _LinesBlastButtonState();
}

class _LinesBlastButtonState extends State<LinesBlastButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: widget.onPressed, child: widget.child);
  }
}
