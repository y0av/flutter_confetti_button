import 'package:confetti_button/src/particle.dart';
import 'package:flutter/material.dart';

class Particles extends StatefulWidget {
  final Duration duration;
  final Particle particle;
  final ParticlesWidgetBuilder builder;

  // New property you defined to make animation
  // easing configurable from outside
  final Curve curve;

  const Particles({super.key,
    required this.particle,
    required this.builder,
    this.duration = const Duration(milliseconds: 400),

    // Default behavior remains as is - no easing
    this.curve = Curves.linear,
  });

  @override
  ParticlesState createState() => ParticlesState();
}

class ParticlesState extends State<Particles>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;


  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    // Initialize animation to be passed down to [ParticlePainter] instead
    // of original controller
    animation = CurvedAnimation(curve: widget.curve, parent: controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return CustomPaint(
          painter: ParticlePainter(
            // Passing new curved animation here
            animation: animation,
            particle: widget.particle,
          ),
          child: child,
        );
      },
      child: widget.builder(context, controller),
    );
  }
}