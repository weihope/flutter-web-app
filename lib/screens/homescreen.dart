import 'package:app2/dummydata.dart';
import 'package:app2/provider/scrollprovider.dart';
import 'package:app2/widgets/coverflow.dart';
import 'package:app2/widgets/explorerange.dart';
import 'package:app2/widgets/horizontalscrollgrid.dart';
import 'package:app2/widgets/horizontalscrollwithcard.dart';
import 'package:app2/widgets/imagecarousel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<HomeScreen> {
  bool _isRefreshing = false;
  late ScrollController _scrollController;

  Future<void> _onRefresh() async {
    setState(() => _isRefreshing = true);
    await Future.delayed(const Duration(seconds: 1));
    setState(() => _isRefreshing = false);
  }

  void _scrollListener() {
    final scrollProvider = Provider.of<ScrollProvider>(context, listen: false);

    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      scrollProvider.setIsBottom(true);
    } else {
      scrollProvider.setIsBottom(false);
    }
  }

  @override
  void initState() {
    super.initState();
    _onRefresh();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener); // ✅ 添加监听器
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Dummydata dummydata = Dummydata();
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: SingleChildScrollView(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 100),
          child: Column(
            children: [
              if (!_isRefreshing) ...[
                ImageCarouselWidget(
                  height: 200,
                  width: screenWidth * 0.8,
                  isMobile: screenWidth > 600,
                  imageList: dummydata.imageList,
                ),
                const SizedBox(height: 10),
                HorizontalScrollWithCardWidget(
                  title: 'Title',
                  thisWidgetHeight: screenHeight * 0.4,
                  imageList: dummydata.imageList,
                ),
                HorizontalScrollGridWidget(
                    widgetHeight: screenHeight * 0.3,
                    widgetWidth: 400,
                    items: dummydata.items),
                CoverFlowWidget(
                  imageList: dummydata.imageList,
                ),
                ExploreRangeWidget(
                  imageList: dummydata.exposeImageList,
                ),
              ] else
                Container(
                  height: screenHeight,
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}