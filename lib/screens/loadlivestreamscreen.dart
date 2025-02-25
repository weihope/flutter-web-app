import 'package:app2/widgets/loadlivestream.dart';
import 'package:flutter/material.dart';

class LoadLiveStreamScreen extends StatefulWidget {
  const LoadLiveStreamScreen({super.key});

  @override
  State<LoadLiveStreamScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<LoadLiveStreamScreen> {
  final String url =
      'https://www.326821905591.com/livetv/1/ysb/ysb/18611584/Bibi/863989ea2abf0d7ba5aa66c3ae69a828/202.186.4.16/1740105705?=&c8b01c85b50091cacef9567b07a70768';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          LoadLiveStreamWidget(
            title: 'title',
            url: url,
            height: 200,
            width: 200,
          ),
          LoadLiveStreamWidget(
            title: 'title',
            url: 'https://www.youtube.com/watch?v=YgFf_NqSHCo',
            height: 200,
            width: 200,
          ),
        ],
      ),
    );
  }
}
