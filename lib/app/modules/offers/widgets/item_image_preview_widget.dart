import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:motorly/app/shared/style/colors.dart';

class ItemImagePreview extends StatefulWidget {
  const ItemImagePreview(
      {Key key, this.imageUrl, this.currentIndex, this.onClose})
      : super(key: key);
  final List<String> imageUrl;
  final int currentIndex;
  final void Function(double) onClose;
  @override
  State<ItemImagePreview> createState() => _ItemImagePreviewState();
}

class _ItemImagePreviewState extends State<ItemImagePreview>
    with SingleTickerProviderStateMixin {
  PageController _pageController;
  int _currentPage = 0;
  AnimationController _animationController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(vsync: this);
    _currentPage = widget.currentIndex;
    _pageController = PageController(initialPage: widget.currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await widget.onClose(_pageController.page);
        return true;
      },
      child: Scaffold(
          body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  children: [
                    Text("${_currentPage + 1}/${widget.imageUrl.length}"),
                    Spacer(),
                    IconButton(
                      icon: Icon(
                        Icons.cancel,
                        size: 33,
                        color: AppColors.white,
                      ),
                      onPressed: () {
                        Navigator.of(context).maybePop();
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: PageView(
                    physics: const ClampingScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    children: widget.imageUrl.map((e) {
                      return Hero(
                        tag: e,
                        child: Image.network(
                          e,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                color: AppColors.primary,
                              ),
                            );
                          }, // placeholder: (context, url) => Center(
                          //   child: CircularProgressIndicator(
                          //     color: AppColors.primary,
                          //   ),
                          // ),
                          errorBuilder: (context, url, error) => Icon(
                            Icons.image_not_supported_rounded,
                            color: AppColors.danger,
                            size: 100,
                          ),
                          fit: BoxFit.contain,
                        ),
                        // child: Image.network(
                        //   e,
                        //   fit: BoxFit.contain,
                        // ),
                      );
                    }).toList()),
              )
            ],
          ),
        ),
      )),
    );
  }
}
