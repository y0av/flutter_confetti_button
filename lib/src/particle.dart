import 'package:flutter/material.dart';

import 'animated_button.dart';

mixin Drawable {
  void draw(Canvas canvas, Size size);
}

class Circle with Drawable {
  @override
  void draw(Canvas canvas, Size size) {
    canvas.drawCircle(Offset.zero, 20, Paint()..color = Colors.purple);
  }
}

class DrawablePainter extends CustomPainter {
  final Drawable child;

  DrawablePainter({required this.child});

  @override
  void paint(Canvas canvas, Size size) {
    child.draw(canvas, size);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class Aligned extends Particle with Drawable {
  final Alignment alignment;
  final Particle child;

  Aligned({
    this.alignment = Alignment.center,
    required this.child,
  });

  @override
  void draw(Canvas canvas, Size size) {
    var offset = alignment.alongSize(size);

    canvas.save();
    canvas.translate(offset.dx, offset.dy);
    child.draw(canvas, size);
    canvas.restore();
  }
}

mixin Updatable {
  void update(Animation animation);
}

enum FadingDirection { fadeIn, fadeOut }

mixin Fading on Updatable {
  FadingDirection direction = FadingDirection.fadeOut;
  double opacity = 0.0;

  @override
  void update(Animation controller) {
    print('value: ${controller.value as double}');
    double clamped = (controller.value as double).clamp(0, 1);
    opacity = (direction == FadingDirection.fadeOut) ? 1 - clamped : clamped;
  }
}

class FadingRect extends Particle with Fading {
  Size size;

  FadingRect({
    this.size = const Size(50, 50),
  });

  @override
  void draw(Canvas canvas, Size size) {
    canvas.drawRect(
      Rect.fromCenter(center: Offset.zero, width: this.size.width, height: this.size.height),
      Paint()..color = Colors.pink.withOpacity(opacity),
    );
  }
}

class FadingCircle extends Particle with Fading {
  double radius;

  FadingCircle({this.radius = 10});

  @override
  void draw(Canvas canvas, Size size) {
    canvas.drawCircle(
      Offset.zero,
      radius,
      Paint()..color = Colors.pink.withOpacity(opacity),
    );
  }
}

abstract class Particle implements Drawable, Updatable {
  @override
  void draw(Canvas canvas, Size size) {
    // Does nothing by default
  }

  @override
  void update(Animation controller) {
    // Does nothing by default
  }
}

class ParticlePainter extends CustomPainter {
  final Animation animation;
  final Particle particle;

  ParticlePainter({required this.animation, required this.particle}) {
    particle.update(animation);
  }

  @override
  void paint(Canvas canvas, Size size) {
    particle.draw(canvas, size);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class ScalingParticle extends Particle with Scaling, NestedParticle {
  ScalingParticle({childParticle}) {
    from = 0.0;
    to = 1.0;
    child = childParticle;
  }

  @override
  void draw(Canvas canvas, Size size) {
    canvas.save();
    canvas.scale(current);
    super.draw(canvas, size);
    canvas.restore();
  }
}

typedef ParticlesWidgetBuilder = Widget Function(
  BuildContext context,
  AnimationController controller,
);
