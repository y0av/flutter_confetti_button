import 'package:flutter/material.dart';

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

class Aligned with Drawable {
  final Alignment alignment;
  final Drawable child;

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

mixin Fading on Updatable {
  double opacity = 0.0;

  @override
  void update(Animation controller) {
    opacity = controller.value;
  }
}

class FadingRect extends Particle with Fading {
  @override
  void draw(Canvas canvas, Size size) {
    canvas.drawRect(
      Rect.fromCenter(center: Offset.zero, width: 10, height: 10),
      Paint()..color = Colors.white.withOpacity(opacity),
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

typedef ParticlesWidgetBuilder = Widget Function(
    BuildContext context,
    AnimationController controller,
    );