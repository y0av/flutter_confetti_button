import 'package:confetti_button/src/particle.dart';
import 'package:confetti_button/src/particle_widget.dart';
import 'package:flutter/material.dart';

class OutlineButton extends StatelessWidget {
  final Widget child;
  final void Function() onPressed;

  const OutlineButton({
    super.key,
    required this.child,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(32.0);

    return Particles(
      duration: const Duration(seconds: 1),
      builder: (context, controller) {
        return ClipRRect(
          borderRadius: borderRadius,
          child: RawMaterialButton(
            onPressed: () {
              controller.forward();
              onPressed();
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: borderRadius,
                border: Border.all(
                  color: Colors.white,
                  width: 3.0,
                ),
              ),
              child: child,
            ),
          ),
        );
      },
      particle: Aligned(
          child: FadingRect()
      ),
    );
  }
}
