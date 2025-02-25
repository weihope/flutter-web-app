import 'package:flutter/material.dart';

class PopUpMenuWidget extends StatelessWidget {
  final String imageUrl;

  const PopUpMenuWidget({super.key, required this.imageUrl});

  void _showPopupMenu(BuildContext context, TapDownDetails details) async {
    final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;

    final result = await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        details.globalPosition.dx,
        details.globalPosition.dy,
        overlay.size.width - details.globalPosition.dx,
        overlay.size.height - details.globalPosition.dy,
      ),
      items: [
        const PopupMenuItem(value: 'open', child: Text('Open')),
        const PopupMenuItem(value: 'share', child: Text('Share')),
        const PopupMenuItem(value: 'favorite', child: Text('Favorite')),
        const PopupMenuItem(
          value: 'delete',
          child: Row(
            children: [
              Icon(Icons.delete, color: Colors.red),
              SizedBox(width: 8),
              Text('Delete', style: TextStyle(color: Colors.red)),
            ],
          ),
        ),
      ],
    );

    if (result != null) {
      print('Selected: $result'); // 替换为实际逻辑
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTapDown: (details) => _showPopupMenu(context, details),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(imageUrl,fit: BoxFit.fill),
      ),
    );
  }
}