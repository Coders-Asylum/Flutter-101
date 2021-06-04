import 'package:flutter/material.dart';

/// menu bar that goes on the top of the
class MenuBar extends StatefulWidget {
  _MenuBarState createState() => _MenuBarState();
}

class _MenuBarState extends State<MenuBar> {
  static const double _menuBarHeight = 50.0;
  static const double _tabHeight = 30.0;
  static const double _tabWidth = 130.0;

  /// List of [MenuTab]s that goes on to the menu bar.
  static const List<MenuTab> _tabs = [
    MenuTab(title: 'Home', tabIcon: Icons.home_rounded),
    MenuTab(title: 'Flutter 101', imageIcon: AssetImage('lib/assets/res/flutterio-icon.png')),
    MenuTab(title: 'Python 101', imageIcon: AssetImage('lib/assets/res/python-icon.png')),
    MenuTab(title: 'Blog', tabIcon: Icons.book_rounded),
    MenuTab(title: 'Tutorials', tabIcon: Icons.code_rounded),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _menuBarHeight,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // name place holder.
          Container(
            width: 100.0,
          ),
          // Menu tabs holder.
          Container(
            height: _menuBarHeight,
            child: MenuItems(tabs: _tabs, tabHeight: _tabHeight, tabWidth: _tabWidth),
          ),
        ],
      ),
    );
  }
}

///
class MenuItems extends StatefulWidget {
  final List<MenuTab> tabs;
  final double tabHeight;
  final double tabWidth;

  const MenuItems({Key? key, required this.tabs, this.tabHeight = 30.0, this.tabWidth = 100.0}) : super(key: key);

  _MenuItemsState createState() => _MenuItemsState();
}

class _MenuItemsState extends State<MenuItems> {
  int _index = 0;
  late Color _tabTextColor = Theme.of(context).highlightColor;

  /// Offset value, only inclusive of left and right margins margins.
  ///
  /// This counteracts the displacement created due to ```margins```.
  /// This value is passed to the margin parameter.
  static const double _off = 16.0;

  /// Sets Text color according on Mouse Hover events.
  void _tabItemColor(bool _hover, int i) {
    if (_hover && _index != i) {
      _tabTextColor = Theme.of(context).primaryColor;
    } else {
      _tabTextColor = Theme.of(context).highlightColor;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: (widget.tabWidth + _off) * widget.tabs.length,
          height: widget.tabHeight,
          alignment: Alignment.center,
          child: ListView.builder(
            itemCount: widget.tabs.length,
            scrollDirection: Axis.horizontal,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int i) => Container(
              width: widget.tabWidth,
              height: widget.tabHeight,
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: _off / 2, right: _off / 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Visibility(
                    visible: _index == i ? true : false,
                    maintainSize: false,
                    maintainAnimation: true,
                    maintainState: true,
                    child: widget.tabs[i].imageIcon == null
                        ? Icon(widget.tabs[i].tabIcon, color: Theme.of(context).accentColor, size: 20.0)
                        : ImageIcon(widget.tabs[i].imageIcon, size: 16.0, color: Theme.of(context).accentColor),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: _off / 2),
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          _index = i;
                        });
                        //widget.tabs[i].onTapped!() == null ? Future.delayed(Duration.zero) : widget.tabs[i].onTapped!();
                      },
                      child: MouseRegion(
                        onEnter: (_hEvent) => _tabItemColor(true, i),
                        onExit: (_hEvent) => _tabItemColor(false, i),
                        child: Text(
                          widget.tabs[i].title,
                          style: TextStyle(
                            fontFamily: 'Source Code',
                            fontWeight: FontWeight.w300,
                            fontSize: 16,
                            color: _index == i ? Theme.of(context).accentColor : _tabTextColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        // moving bar
        AnimatedPositioned(
          left: (widget.tabWidth * _index) + (_index == 0 ? _off / 2 : (1 / 2 + _index) * _off),
          top: widget.tabHeight + 14.0,
          duration: Duration(milliseconds: 200),
          child: Container(
            height: 3.0,
            width: widget.tabWidth,
            decoration: BoxDecoration(
              color: Theme.of(context).accentColor,
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
        ),
      ],
    );
  }
}

/// - [title] is the name of the menu tab.
/// - [onTapped] is passed to the [onPressed] of the [TextButton].
/// - [key] is required to find the global position of the widget.
/// for simplicity name the [key] the same name as the [title]
class MenuTab {
  final String title;
  final AssetImage? imageIcon;
  final IconData? tabIcon;
  final Function? onTapped;

  const MenuTab({this.imageIcon, this.tabIcon, required this.title, this.onTapped})
      : assert((imageIcon != null || tabIcon != null), ' Any one of the Icon should be provided');
}
