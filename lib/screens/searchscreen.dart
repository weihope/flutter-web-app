import 'package:app2/widgets/hoverfloatwidget.dart';
import 'package:app2/widgets/menuhover.dart';
import 'package:app2/widgets/tooltip.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          spacing: 10,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            HoverFloatWidget(
              child: ElevatedButton(onPressed: () {}, child: Text('data')),
            ),
            HoverMenuWidget(
              menuShowVertical: false,
              menuFullScreen: true,
              menuBGColor: Colors.blue,
              menuItems: ['Option1', 'Option2', 'Option3'],
              child: Container(
                height: 100,
                width: 100,
                color: Colors.purple,
                child: Center(child: Text('full screen')),
              ),
            ),
            HoverMenuWidget(
              menuShowVertical: true,
              menuFullScreen: false,
              menuBGColor: Colors.blue,
              menuItems: ['Option1', 'Option2', 'Option3'],
              child: Container(
                height: 100,
                width: 100,
                color: Colors.amber,
                child: Center(child: Text('Menu Hover Set BG Color')),
              ),
            ),
            ToolTipWidget(
              toolTipBGColors: Colors.black,
              toolTipTextColors: Colors.white,
              showOnBelow: true,
              toolTipMessage: '',
              child: Container(
                height: 100,
                width: 100,
                color: Colors.red,
                child: Text('data'),
              ),
            ),
            ToolTipWidget(
              toolTipBGColors: Colors.pink,
              toolTipTextColors: Colors.black,
              showOnBelow: false,
              toolTipMessage: 'Testing',
              child: Container(
                height: 100,
                width: 100,
                color: Colors.purpleAccent,
                child: Text('data'),
              ),
            ),
            ToolTipWidget(
              toolTipBGColors: Colors.green,
              toolTipTextColors: Colors.white,
              showOnBelow: true,
              toolTipMessage: 'Testing',
              child: Container(
                height: 100,
                width: 100,
                color: Colors.amber,
                child: Text('data'),
              ),
            ),
            ToolTipWidget(
              toolTipBGColors: Colors.red,
              toolTipTextColors: Colors.black,
              showOnRight: true,
              toolTipMessage: 'right side',
              child: Container(
                height: 100,
                width: 100,
                color: Colors.blue,
                child: Text('data'),
              ),
            ),
            ToolTipWidget(
              toolTipBGColors: Colors.black,
              toolTipTextColors: Colors.blue,
              showOnRight: false,
              toolTipMessage: 'left side',
              child: Container(
                height: 100,
                width: 100,
                color: Colors.green,
                child: Text('data'),
              ),
            ),

            SizedBox(height: 200),
          ],
        ),
      ),
    );
  }
}
