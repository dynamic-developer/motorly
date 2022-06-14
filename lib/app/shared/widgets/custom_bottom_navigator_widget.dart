import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../style/colors.dart';

class CustomBottomAppBar extends StatefulWidget {
  final ValueChanged<int> onTabSelected;
  final List<CustomAppBarItem> items;
  final int selectedIndex;

  CustomBottomAppBar({
    this.onTabSelected,
    this.items,
    this.selectedIndex,
  });

  @override
  _CustomBottomAppBarState createState() => _CustomBottomAppBarState();
}

class _CustomBottomAppBarState extends State<CustomBottomAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(0),
          topLeft: Radius.circular(0),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Theme.of(context).shadowColor,
            blurRadius: 5,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(0),
          topLeft: Radius.circular(0),
        ),
        child: BottomAppBar(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Container(
            height: 60.0,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                widget.items.length,
                (i) {
                  return _buildTabIcon(
                    index: i,
                    item: widget.items[i],
                    onPressed: widget.onTabSelected,
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabIcon({
    int index,
    CustomAppBarItem item,
    ValueChanged<int> onPressed,
  }) {
    return Expanded(
      child: Container(
        key: Key(item.title),
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () => onPressed(index),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                item.icon == null
                    ? SvgPicture.asset(item.svgPath,
                        color: widget.selectedIndex == index
                            ? AppColors.primary
                            : Colors.grey,
                        width: 26,
                        height: 26)
                    : Icon(item.icon,
                        color: widget.selectedIndex == index
                            ? AppColors.primary
                            : Colors.grey,
                        size: 26),
                SizedBox(height: 5),
                // Text(
                //   item.title,
                //   style: TextStyle(
                //     fontSize: 14,
                //     color: _selectedIndex == index
                //         ? AppColors.primary
                //         : Theme.of(context).hoverColor,
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomAppBarItem {
  String svgPath;
  String title;
  IconData icon;

  CustomAppBarItem({
    this.svgPath,
    this.icon,
    this.title,
  });
}
