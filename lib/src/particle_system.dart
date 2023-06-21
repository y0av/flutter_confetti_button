import 'dart:ui';

import 'package:confetti_button/src/particle.dart';
import 'package:flutter/animation.dart';

mixin CompositeParticle on Particle {
  late List<Particle> children;

  @override
  void draw(Canvas canvas, Size size) {
    super.draw(canvas, size);

    for (var child in children) {
      child.draw(canvas, size);
    }
  }

  @override
  void update(Animation controller) {
    super.update(controller);

    for (var child in children) {
      child.update(controller);
    }
  }
}