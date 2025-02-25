import 'package:flutter/material.dart';

class NavigateAnimationWidget extends StatefulWidget {
  const NavigateAnimationWidget({
    super.key,
    required this.pageContent,
  });

  final Widget pageContent;

  @override
  State<NavigateAnimationWidget> createState() =>
      _NavigateAnimationWidgetState();
}

class _NavigateAnimationWidgetState extends State<NavigateAnimationWidget>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          child: TweenAnimationBuilder(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 1500),
              builder: (context, value, child) {
                return ShaderMask(
                  shaderCallback: (rect) {
                    return RadialGradient(
                            radius: value * 5,
                            colors: const [
                              Colors.white,
                              Colors.white,
                              Colors.transparent,
                              Colors.transparent
                            ],
                            stops: const [0.0, 0.55, 0.6, 1.0],
                            center: const FractionalOffset(0.95, 0.95))
                        .createShader(rect);
                  },
                  child: widget.pageContent,
                );
              }),
        );
      },
    );
  }
}

class WaveTransitionPage extends PageRouteBuilder {
  final Widget pageContent;

  WaveTransitionPage({required this.pageContent})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) {
            return pageContent;
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Apply a wave-like effect by using a custom animation
            var curve =
                CurvedAnimation(parent: animation, curve: Curves.easeInOut);
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1.0, 0.0), // Starts from the right
                end: Offset.zero, // Ends at the center
              ).animate(curve),
              child: child,
            );
          },
        );
}