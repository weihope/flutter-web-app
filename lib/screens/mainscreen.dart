import 'package:app2/provider/scrollprovider.dart';
import 'package:app2/screens/floatingbuttonscreen.dart';
import 'package:app2/screens/homescreen.dart';
import 'package:app2/screens/loadlivestreamscreen.dart';
import 'package:app2/screens/localizationscreen.dart';
import 'package:app2/screens/searchscreen.dart';
import 'package:app2/screens/webview/inappwebview.dart';
import 'package:app2/screens/webview/webviewxplus.dart';
import 'package:app2/widgets/navigateanimation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MainScreen> {
  late ScrollController _scrollController;

  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const LoadLiveStreamScreen(),
    const LocalizationScreen(),
    const SearchScreen(),
    const Center(child: Text('Profile Page')),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
    } else if (_scrollController.offset <=
            _scrollController.position.minScrollExtent &&
        !_scrollController.position.outOfRange) {}
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isScrollToBottom = context.watch<ScrollProvider>().isBottom;

    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          width: screenWidth * 0.4,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              children: [
                Image.network(
                  'https://media.tenor.com/NJaP8NSG2nUAAAAm/amazing.webp',
                  width: screenWidth * 0.2,
                ),
                Text(AppLocalizations.of(context)!.demoApp),
              ],
            ),
          ),
        ),
      ),
      endDrawer: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Drawer(
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                color: Colors.blueAccent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Full Screen Drawer',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () {
                        Navigator.of(context).pop(); // ✅ 关闭抽屉
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16.0),
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => const InAppWebViewScreen(
                                  url: 'https://flutter.dev',
                                ),
                          ),
                        );
                      },
                      child: Text('In App Web View'),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => const WebViewXPlusScreen(
                                  url: 'https://www.google.co.uk/',
                                ),
                          ),
                        );
                      },
                      child: Text('Web View X Plus'),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => const LocalizationScreen(),
                          ),
                        );
                      },
                      child: Text('Localization'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: _pages[_selectedIndex],
      extendBody: true, // 允许 Floating Navigation Bar 悬浮在 body 上
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 16.0, left: 16.0, right: 16.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30), // ✅ 圆角
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            backgroundColor: Colors.blueAccent,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.black,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.live_tv), label: 'Live'),
              BottomNavigationBarItem(
                icon: Icon(Icons.language),
                label: 'Localization',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
      floatingActionButton:
          _selectedIndex == 0
              ? !isScrollToBottom
                  ? FloatingActionButton(
                    onPressed: () {
                      if (kIsWeb) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const FloatingButtonScreen(),
                          ),
                        );
                      } else {
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            pageBuilder: (
                              context,
                              animation,
                              secondaryAnimation,
                            ) {
                              return const NavigateAnimationWidget(
                                pageContent: FloatingButtonScreen(),
                              );
                            },
                            transitionDuration: const Duration(
                              milliseconds: 1000,
                            ),
                            reverseTransitionDuration: const Duration(
                              milliseconds: 1000,
                            ),
                          ),
                        );
                      }
                    },
                    backgroundColor: Colors.blueAccent,
                    child: const Icon(Icons.add, color: Colors.white),
                  )
                  : null
              : null,
      // floatingActionButtonLocation:
      //     FloatingActionButtonLocation.centerDocked,
    );
  }
}

//first type navbar
// bottomNavigationBar: Padding(
//   padding: const EdgeInsets.only(bottom: 16.0, left: 16.0, right: 16.0),
//   child: ClipRRect(
//     borderRadius: BorderRadius.circular(30), // ✅ 圆角
//     child: BottomNavigationBar(
//       currentIndex: _selectedIndex,
//       onTap: _onItemTapped,
//       backgroundColor: Colors.blueAccent,
//       selectedItemColor: Colors.white,
//       unselectedItemColor: Colors.white70,
//       items: const [
//         BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
//         BottomNavigationBarItem(
//             icon: Icon(Icons.search), label: 'Search'),
//         BottomNavigationBarItem(
//             icon: Icon(Icons.person), label: 'Profile'),
//       ],
//     ),
//   ),
// ),

//second type
//  Stack(
//   children: [
//     _pages[_selectedIndex],
//     Positioned(
//       left: 16,
//       right: 16,
//       bottom: 16,
//       child: Container(
//         height: 60,
//         decoration: BoxDecoration(
//           color: Colors.blueAccent,
//           borderRadius: BorderRadius.circular(30),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.2),
//               blurRadius: 10,
//               offset: const Offset(0, 5),
//             ),
//           ],
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             IconButton(
//                 icon: const Icon(Icons.home),
//                 onPressed: () => _onItemTapped(0)),
//             IconButton(
//                 icon: const Icon(Icons.search),
//                 onPressed: () => _onItemTapped(1)),
//             IconButton(
//                 icon: const Icon(Icons.person),
//                 onPressed: () => _onItemTapped(2)),
//           ],
//         ),
//       ),
//     ),
//   ],
// ),
