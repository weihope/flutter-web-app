import 'package:flutter/material.dart';

class HoverFloatWidget extends StatefulWidget {
  final Widget child;

  const HoverFloatWidget({super.key, required this.child});

  @override
  State<HoverFloatWidget> createState() => _HoverFloatWidgetState();
}

class _HoverFloatWidgetState extends State<HoverFloatWidget> {
  bool isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovering = true),  
      onExit: (_) => setState(() => isHovering = false),   
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,  
        transform: Matrix4.translationValues(0, isHovering ? -10 : 0, 0),  
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.circular(12),
          // boxShadow: isHovering
          //     ? [
          //         BoxShadow(
          //           color: Colors.black.withOpacity(0.3),  
          //           blurRadius: 15,
          //           offset: const Offset(0, 10),
          //         ),
          //       ]
          //     : [],
        ),
        child: widget.child,
      ),
    );
  }
}
