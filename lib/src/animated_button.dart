import 'dart:ui';

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
      duration: const Duration(seconds: 8),
      builder: (context, controller) {
        return ClipRRect(
          borderRadius: borderRadius,
          child: RawMaterialButton(
            onPressed: () {
              controller.reset();
              controller.forward();
              onPressed();
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: borderRadius,
                border: Border.all(
                  color: Colors.green,
                  width: 3.0,
                ),
              ),
              child: child,
            ),
          ),
        );
      },
      particle: ScalingParticle(childParticle: FadingCircle()),
    );
  }
}

mixin Scaling on Updatable {
  double from = 0;
  double to = 1;
  late double current;

  @override
  void update(Animation controller) {
    current = lerpDouble(from, to, controller.value)!;
  }
}

mixin NestedParticle on Particle {
  late Particle child;

  @override
  void draw(Canvas canvas, Size size) {
    super.draw(canvas, size);
    child.draw(canvas, size);
  }

  @override
  void update(Animation controller) {
    super.update(controller);
    child.update(controller);
  }
}

class SimpleParticles extends StatelessWidget {
  const SimpleParticles({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Particles(
        builder: (context, controller) {
          return RawMaterialButton(
            onPressed: () {
              controller.forward();
            },
            child: const Text('Fade the rect!'),
          );
        },
        particle: Aligned(
          child: FadingRect(),
        ),
        //curve: Curves.bounceInOut,
      ),
    );
  }
}
