import 'dart:async';
import 'package:flutter/material.dart';

enum AniType {
  vertical,
  horizontal,
}

class DelayedAnimation extends StatefulWidget {
  final Widget? child;
  final int? delay;
  final AniType type;
  const DelayedAnimation({
    Key? key,
    required this.child,
    this.delay,
    this.type = AniType.horizontal,
  }) : super(key: key);

  @override
  _DelayedAnimationState createState() => _DelayedAnimationState();
}

class _DelayedAnimationState extends State<DelayedAnimation>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animOffset;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 800,
      ),
    );
    final curve =
        CurvedAnimation(curve: Curves.decelerate, parent: _controller);
    _animOffset = Tween<Offset>(
            begin: widget.type == AniType.vertical
                ? const Offset(0.5, 0.0)
                : const Offset(0.0, 0.35),
            end: Offset.zero)
        .animate(curve);

    if (widget.delay == null) {
      _controller.forward();
    } else {
      Timer(Duration(milliseconds: widget.delay!), () {
        _controller.forward();
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller,
      child: SlideTransition(
        position: _animOffset,
        child: widget.child,
      ),
    );
  }
}
