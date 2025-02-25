import 'package:flutter/material.dart';

class HoverMenuWidget extends StatefulWidget {
  final Widget child;
  final List<String> menuItems;
  final Color? menuBGColor;
  final bool menuFullScreen;
  final bool menuShowVertical;

  const HoverMenuWidget({
    super.key,
    required this.child,
    required this.menuItems,
    this.menuBGColor,
    required this.menuFullScreen,
    required this.menuShowVertical,
  });

  @override
  State<HoverMenuWidget> createState() => _HoverMenuWidgetState();
}

class _HoverMenuWidgetState extends State<HoverMenuWidget> {
  OverlayEntry? _overlayEntry;
  bool _isHovering = false;
  bool _isHoveringMenu = false;

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var offset = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(
      builder:
          (context) => Positioned(
            left: widget.menuFullScreen ? 0 : offset.dx,
            top: offset.dy + renderBox.size.height,
            width:
                widget.menuFullScreen
                    ? MediaQuery.of(context).size.width
                    : null,
            child: MouseRegion(
              onEnter: (_) => _isHoveringMenu = true,
              onExit: (_) {
                _isHoveringMenu = false;
                _hideOverlayWithDelay();
              },
              child: Material(
                elevation: 4,
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  color: widget.menuBGColor,
                  child:
                      widget.menuShowVertical
                          ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children:
                                widget.menuItems
                                    .map(
                                      (item) => InkWell(
                                        onTap: () {
                                          _removeOverlay();
                                          debugPrint('Clicked: $item');
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical: 8,
                                          ),
                                          child: Text(
                                            item,
                                            style: const TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                          )
                          : Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children:
                                widget.menuItems
                                    .map(
                                      (item) => InkWell(
                                        onTap: () {
                                          _removeOverlay();
                                          debugPrint('Clicked: $item');
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical: 8,
                                          ),
                                          child: Text(
                                            item,
                                            style: const TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                          ),
                ),
              ),
            ),
          ),
    );
  }

  void _showOverlay() {
    if (_overlayEntry == null) {
      _overlayEntry = _createOverlayEntry();
      Overlay.of(context).insert(_overlayEntry!);
    }
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _hideOverlayWithDelay() {
    Future.delayed(const Duration(milliseconds: 200), () {
      if (!_isHovering && !_isHoveringMenu) {
        _removeOverlay();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        _isHovering = true;
        _showOverlay();
      },
      onExit: (_) {
        _isHovering = false;
        _hideOverlayWithDelay();
      },
      child: widget.child,
    );
  }
}
