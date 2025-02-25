import 'package:flutter/material.dart';

class FloatingAdsWidget extends StatefulWidget {
  const FloatingAdsWidget({super.key});

  @override
  State<FloatingAdsWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<FloatingAdsWidget> {
  bool _showAd = true;

  @override
  Widget build(BuildContext context) {
    if (_showAd) {
      return Positioned(
        bottom: 200,
        right: 16,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 200,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.orange.shade300,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: Offset(2, 4),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: const Text(
                '🔥 Special Offer!',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Positioned(
              top: -8,
              right: -8,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _showAd = false;
                  });
                },
                child: const CircleAvatar(
                  radius: 14,
                  backgroundColor: Colors.black,
                  child: Icon(Icons.close, color: Colors.white, size: 18),
                ),
              ),
            ),
          ],
        ),
      );
    }else{
      return SizedBox();
    }
  }
}
