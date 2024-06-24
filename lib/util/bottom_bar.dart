import 'package:flutter/material.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({
    super.key,
    required this.items,
    this.backgroundColor,
    this.currentIndex = 0,
    this.onTap,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.selectedColorOpacity,
    this.itemShape = const StadiumBorder(),
    this.margin = const EdgeInsets.all(8),
    this.itemPadding = const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
    this.duration = const Duration(milliseconds: 500),
    this.curve = Curves.easeOutQuint,
  });

  final List<BottomNavigationItem> items;

  final int currentIndex;

  final Function(int)? onTap;

  final Color? backgroundColor;

  final Color? selectedItemColor;

  final Color? unselectedItemColor;

  final double? selectedColorOpacity;

  final ShapeBorder itemShape;

  final EdgeInsets margin;

  final EdgeInsets itemPadding;

  final Duration duration;

  final Curve curve;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: margin.horizontal, vertical: 8),
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.transparent,
        borderRadius: BorderRadius.circular(width * 0.072),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: items.length <= 2
            ? MainAxisAlignment.spaceEvenly
            : MainAxisAlignment.spaceBetween,
        children: [
          for (final item in items)
            TweenAnimationBuilder<double>(
              tween: Tween(
                end: items.indexOf(item) == currentIndex ? 1.0 : 0.0,
              ),
              curve: curve,
              duration: duration,
              builder: (context, t, _) {
                final selectedColor = item.selectedColor ??
                    selectedItemColor ??
                    theme.primaryColor;

                final unselectedColor = item.unselectedColor ??
                    unselectedItemColor ??
                    theme.iconTheme.color;

                return Material(
                  color: Color.lerp(
                      selectedColor.withOpacity(0.0),
                      selectedColor.withOpacity(selectedColorOpacity ?? 0.1),
                      t),
                  shape: itemShape,
                  child: InkWell(
                    onTap: () => onTap?.call(items.indexOf(item)),
                    customBorder: itemShape,
                    focusColor: selectedColor.withOpacity(0.1),
                    highlightColor: selectedColor.withOpacity(0.1),
                    splashColor: selectedColor.withOpacity(0.1),
                    hoverColor: selectedColor.withOpacity(0.1),
                    child: Padding(
                      padding: itemPadding -
                          (Directionality.of(context) == TextDirection.ltr
                              ? EdgeInsets.only(right: itemPadding.right * t)
                              : EdgeInsets.only(left: itemPadding.left * t)),
                      child: Row(
                        children: [
                          IconTheme(
                            data: IconThemeData(
                              color: Color.lerp(
                                  unselectedColor, selectedColor, t),
                              size: 24,
                            ),
                            child: items.indexOf(item) == currentIndex
                                ? item.activeIcon ?? item.icon
                                : item.icon,
                          ),
                          ClipRect(
                            clipBehavior: Clip.antiAlias,
                            child: SizedBox(
                              height: 20,
                              child: Align(
                                alignment: const Alignment(-0.2, 0.0),
                                widthFactor: t,
                                child: Padding(
                                  padding: Directionality.of(context) ==
                                          TextDirection.ltr
                                      ? EdgeInsets.only(
                                          left: itemPadding.left / 2,
                                          right: itemPadding.right)
                                      : EdgeInsets.only(
                                          left: itemPadding.left,
                                          right: itemPadding.right / 2),
                                  child: DefaultTextStyle(
                                    style: TextStyle(
                                      color: Color.lerp(
                                          selectedColor.withOpacity(0.0),
                                          selectedColor,
                                          t),
                                      fontWeight: FontWeight.w600,
                                    ),
                                    child: item.title,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}

class BottomNavigationItem {
  final Widget icon;

  final Widget? activeIcon;

  final Widget title;

  final Color? selectedColor;

  final Color? unselectedColor;

  BottomNavigationItem({
    required this.icon,
    required this.title,
    this.selectedColor,
    this.unselectedColor,
    this.activeIcon,
  });
}
