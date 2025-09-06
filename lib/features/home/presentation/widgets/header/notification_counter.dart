import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:swap_ui/core/utils/colors.dart';
import 'package:swap_ui/core/utils/text_styles.dart';

class NotificationCounter extends StatefulWidget {
  const NotificationCounter({
    super.key,
    required this.count,
    this.introDuration = const Duration(milliseconds: 800),
    this.swingDuration = const Duration(milliseconds: 800),
    this.fadeOutDuration = const Duration(milliseconds: 600),
    this.introStartAngle = -1.35,
    this.introEndAngle = 0.0,
    this.introScaleBegin = 0.0,
    this.introScaleEnd = 1.0,
  });

  final int count;
  final Duration introDuration;
  final Duration swingDuration;
  final Duration fadeOutDuration;
  final double introStartAngle;
  final double introEndAngle;
  final double introScaleBegin;
  final double introScaleEnd;

  @override
  State<NotificationCounter> createState() => _NotificationCounterState();
}

class _NotificationCounterState extends State<NotificationCounter>
    with TickerProviderStateMixin {
  late final AnimationController _introCtrl;
  late final AnimationController _swingCtrl;
  late final AnimationController _fadeOutCtrl;

  late final Animation<double> _fadeIntro;
  late final Animation<double> _scaleIntro;
  late final Animation<double> _rotYIntro;
  late final Animation<double> _swingAngle;
  late final Animation<double> _fadeOut;

  bool _started = false;
  bool _hidden = false; // when true -> don't render badge
  static const double _triangleHeight = 8.0;

  @override
  void initState() {
    super.initState();

    // Intro controller (fade in + scale + rotY)
    _introCtrl = AnimationController(
      vsync: this,
      duration: widget.introDuration,
    );

    _fadeIntro = CurvedAnimation(parent: _introCtrl, curve: Curves.easeIn);

    _scaleIntro = Tween<double>(
      begin: widget.introScaleBegin,
      end: widget.introScaleEnd,
    ).animate(CurvedAnimation(parent: _introCtrl, curve: Curves.easeOutBack));

    _rotYIntro = Tween<double>(
      begin: widget.introStartAngle,
      end: widget.introEndAngle,
    ).animate(CurvedAnimation(parent: _introCtrl, curve: Curves.easeOutCubic));

    // Swing controller
    _swingCtrl = AnimationController(
      vsync: this,
      duration: widget.swingDuration,
    );

    _swingAngle = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: -0.28), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -0.28, end: 0.23), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 0.23, end: -0.15), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -0.15, end: 0.0), weight: 1),
    ]).animate(CurvedAnimation(parent: _swingCtrl, curve: Curves.easeOut));

    // FadeOut controller (also used to drive scale-down)
    _fadeOutCtrl = AnimationController(
      vsync: this,
      duration: widget.fadeOutDuration,
    );

    _fadeOut = CurvedAnimation(parent: _fadeOutCtrl, curve: Curves.easeIn);

    // Sequence: after intro -> start swing
    _introCtrl.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _swingCtrl.forward(from: 0.0);
      }
    });

    // After swing -> start fadeOut (scale down + fade)
    _swingCtrl.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // ensure badge visible before starting fade
        if (mounted) {
          _fadeOutCtrl.forward(from: 0.0);
        }
      }
    });

    // When fadeOut finishes hide the widget from tree
    _fadeOutCtrl.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (mounted) {
          setState(() {
            _hidden = true;
          });
        }
      }
    });

    // Trigger intro on first frame if there's count
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_started && widget.count > 0 && mounted) {
        _started = true;
        _hidden = false;
        _introCtrl.forward(from: 0.0);
      }
    });
  }

  // If count changes (e.g., new notification), restart the sequence
  @override
  void didUpdateWidget(covariant NotificationCounter oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.count > 0 && widget.count != oldWidget.count) {
      // reset and replay
      _fadeOutCtrl.stop();
      _swingCtrl.stop();
      _introCtrl.reset();
      _swingCtrl.reset();
      _fadeOutCtrl.reset();
      setState(() {
        _hidden = false;
      });
      _introCtrl.forward(from: 0.0);
    }
  }

  /// Call this to manually trigger fade-out (if you need it from outside)
  void triggerFadeOut() {
    if (mounted) {
      _fadeOutCtrl.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _introCtrl.dispose();
    _swingCtrl.dispose();
    _fadeOutCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_hidden) return const SizedBox.shrink();

    return AnimatedBuilder(
      animation: Listenable.merge([_introCtrl, _swingCtrl, _fadeOutCtrl]),
      builder: (context, child) {
        // opacity: intro animation or fade-out (when running)
        final double opacity = _fadeOutCtrl.isAnimating
            ? (1.0 - _fadeOut.value) // fades out to 0
            : _fadeIntro.value; // during intro uses the intro fade

        // scale: base intro scale then shrink toward 0 while fading out
        final double baseScale = _scaleIntro.value;
        final double scaleWhenFading = baseScale * (1.0 - _fadeOut.value);
        final double scale =
            _fadeOutCtrl.isAnimating ? scaleWhenFading : baseScale;

        // rotation & swing as before (rotation applied first, then swing rotate around top center)
        return Opacity(
          opacity: opacity.clamp(0.0, 1.0),
          child: Transform.scale(
            alignment:
                Alignment.topCenter, // important: shrink toward top triangle
            scale: scale.clamp(0.0, 1.2),
            child: AnimatedRotation(
              turns: _rotYIntro.value / (2 * math.pi),
              duration: Duration.zero,
              child: Transform.rotate(
                alignment: Alignment.topCenter,
                angle: _swingAngle.value,
                child: child,
              ),
            ),
          ),
        );
      },
      child: CustomPaint(
        painter: _BadgePainter(),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.only(top: _triangleHeight),
            child: Text(
              '${widget.count}',
              style: TextStyles.title(
                fontWeight: FontWeight.w800,
                color: AppColors.whiteColor,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}

class _BadgePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = AppColors.notificationColor;

    // rectangle
    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(-4, 8, size.width + 8, size.height - 10),
      const Radius.circular(6),
    );
    canvas.drawRRect(rrect, paint);

    // small triangle pointer
    final path = Path()
      ..moveTo(size.width / 2 - 6, 8)
      ..lineTo(size.width / 2, 0)
      ..lineTo(size.width / 2 + 6, 8)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
