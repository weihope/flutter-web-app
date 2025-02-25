import 'package:flutter/material.dart';

class ToolTipWidget extends StatefulWidget {
  const ToolTipWidget({
    super.key,
    this.toolTipMessage,
    required this.toolTipBGColors,
    required this.toolTipTextColors,
    this.showOnBelow,
    this.showOnRight,
    required this.child,
  });
  final String? toolTipMessage;
  final Color toolTipBGColors;
  final Color toolTipTextColors;
  final bool? showOnBelow;
  final bool? showOnRight;
  final Widget child;

  @override
  State<ToolTipWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ToolTipWidget> {
  OverlayEntry? _overlayEntry;

  void _showTooltip(
    BuildContext context,
    GlobalKey key,
    String message,
    Color textColor,
    Color bGColor,
     {
    bool showRight = true,
  }) {
    final renderBox = key.currentContext!.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    _overlayEntry = OverlayEntry(
      builder:
          (context) => Positioned(
            top: offset.dy + (size.height / 2) - 25, // 垂直居中
            left:
                showRight
                    ? offset.dx + size.width + 8
                    : offset.dx - 160 - 8, // 根据 showRight 控制左右
            child: Material(
              color: Colors.transparent,
              child: Container(
                width: 160,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color:bGColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  message,
                  style: TextStyle(color: textColor, fontSize: 14),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _hideTooltip() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.showOnBelow != null) {
      return Tooltip(
        message: widget.toolTipMessage, // ✅ 鼠标悬停时显示的文本
        decoration: BoxDecoration(
          color: widget.toolTipBGColors,
          borderRadius: BorderRadius.circular(8),
        ),
        textStyle: TextStyle(color: widget.toolTipTextColors),
        padding: const EdgeInsets.all(8),
        preferBelow: widget.showOnBelow,
        child: widget.child,
      );
    } else {
      final leftKey = GlobalKey();
      final rightKey = GlobalKey();
      final directionKey = widget.showOnRight! ? leftKey : rightKey;
      return MouseRegion(
        onEnter:
            (_) => _showTooltip(
              context,
              directionKey,
              widget.toolTipMessage!,
              widget.toolTipTextColors,
              widget.toolTipBGColors,
              showRight: widget.showOnRight!,
            ),
        onExit: (_) => _hideTooltip(),
        child: SizedBox(key: directionKey, child: widget.child),
      );
    }
  }
}
