import 'dart:async' show Timer;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show ScrollDirection;
import 'package:web/components/Button.dart';

// project files
import 'package:web/components/MenuBar.dart' show MenuBar;
import 'package:web/components/SideBar.dart' show SideBar;
import 'package:web/components/paint/CircleMatrix.dart' show CircleMatrix;
import 'package:web/components/paint/TechLines.dart' show TechnologicalLinesAnimation;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // constant screen height and width
  static const double _kHeight = 1024.0;
  static const double _kWidth = 1440.0;

  //Scroll Controller for the HomePage
  final ScrollController _scrollController = ScrollController();

  double _pageScrollPosition = 0.0;
  ScrollDirection _userScrollDirection = ScrollDirection.idle;

  /// Updates the [_pageScrollPosition] and [_userScrollDirection] variables while listening to [_scrollController].
  void _homePageScrollListener() {
    _userScrollDirection = _scrollController.position.userScrollDirection;
    setState(() {});
  }

  void setStateTimer() async {
    Timer.periodic(Duration(milliseconds: 60), (timer) {
      setState(() {});
    });
  }

  @override
  void initState() {
    // attaching the listener
    _scrollController.addListener(() => _homePageScrollListener());
    //setStateTimer();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    // if (_timer.isActive) {
    //   _timer.cancel();
    // }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //stores the current height and width of the current screen.
    final _screenWidth = MediaQuery.of(context).size.width;
    final _screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: LayoutBuilder(
        builder: (context, constrains) => Stack(
          alignment: Alignment.center,
          children: [
            SizedBox.expand(),
            // Menu Bar
            Positioned(top: 0.0, left: 0.0, child: MenuBar()),
            // Tech lines animation
            Positioned(
              top: _screenHeight * 0.2796,
              left: _screenWidth * 0.1525,
              child: Container(
                child: TechnologicalLinesAnimation(scrollDirection: _userScrollDirection),
              ),
            ),
            Scrollbar(
              controller: _scrollController,
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IntroTile(safeArea: Size(_kWidth, _kHeight)),
                    Container(
                      height: _kHeight,
                      width: _kWidth,
                    ),
                    Container(
                      width: _screenWidth,
                      alignment: Alignment.center,
                      child: Container(
                        height: _kHeight,
                        width: _kWidth,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeScreen extends StatefulWidget {
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<_HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constrains) {
        return Scrollbar(
          child: SingleChildScrollView(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class IntroTile extends StatefulWidget {
  final Size safeArea;

  const IntroTile({Key? key, required this.safeArea}) : super(key: key);

  _IntroTileState createState() => _IntroTileState();
}

class _IntroTileState extends State<IntroTile> {
  double get _kWidth => widget.safeArea.width;

  double get _kHeight => widget.safeArea.height;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //stores the current height and width of the current screen.
    final _screenWidth = MediaQuery.of(context).size.width;
    final _screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: _kHeight,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox.expand(),
          // Circles pattern placeholder
          Positioned(
            top: _screenHeight * 0.1961,
            left: 50.0,
            child: CircleMatrix(),
          ),

          // Show more
          Positioned(
            top: 50.0,
            left: 2.0,
            child: SideBar(
              verticalHeight: _screenHeight - 50,
              verticalWidth: 40,
              alignment: Alignment.centerLeft,
              child: Container(
                height: 40.0,
                width: 200,
                alignment: Alignment.centerRight,
                margin: EdgeInsets.only(left: 16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 40,
                      width: 40.0,
                      padding: EdgeInsets.all(5.0),
                      child: RotatedBox(
                        quarterTurns: 1,
                        child: Icon(
                          Icons.arrow_circle_down_rounded,
                          size: 35.0,
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                    ),
                    Container(
                      height: 30.0,
                      width: 145.0,
                      margin: EdgeInsets.only(left: 5.0),
                      padding: EdgeInsets.all(5.0),
                      child: FittedBox(
                        fit: BoxFit.fitHeight,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Scroll down',
                          style: TextStyle(
                            fontFamily: 'Source Code',
                            color: Theme.of(context).highlightColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // main tile
          Container(
            width: _kWidth,
            height: _kHeight,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox.expand(),
                // CA tree Image
                Positioned(
                  top: 0.0083 * _kHeight,
                  left: _screenWidth >= _kWidth ? (_screenWidth - _kWidth) + 0.5125 * _kWidth : 768.0,
                  child: Container(
                    height: _kHeight * 0.744,
                    width: _kWidth * 0.423,
                    decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage('lib/assets/res/ca_tree.png'), alignment: Alignment.center, fit: BoxFit.contain),
                    ),
                  ),
                ),
                //CA title Placeholder
                Positioned(
                  top: 0.2161 * _kHeight,
                  left: _screenWidth >= _kWidth ? (_screenWidth - _kWidth) + 0.1229 * _kWidth : 117,
                  child: Container(
                    width: _kWidth * 0.5208,
                    height: _kHeight * 0.3955,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: _kHeight * 0.0576,
                          width: _kWidth * 0.5208,
                          margin: EdgeInsets.all(8.0),
                          child: FittedBox(
                            fit: BoxFit.fitHeight,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'welcome to',
                              style: TextStyle(fontFamily: 'Source Code', fontWeight: FontWeight.w300, color: Theme.of(context).highlightColor),
                            ),
                          ),
                        ),
                        Container(
                          height: _kHeight * 0.1135,
                          width: _kWidth * 0.5208,
                          margin: EdgeInsets.fromLTRB(3.0, 8.0, 8.0, 8.0),
                          child: FittedBox(
                            fit: BoxFit.fitHeight,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'CODERS',
                              style: TextStyle(fontFamily: 'Gobold', color: Theme.of(context).primaryColor, letterSpacing: 2.0),
                            ),
                          ),
                        ),
                        Container(
                          height: _kHeight * 0.1664,
                          width: _kWidth * 0.5208,
                          margin: EdgeInsets.all(8.0),
                          child: FittedBox(
                            fit: BoxFit.fitHeight,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'ASYLUM',
                              style: TextStyle(fontFamily: 'Orbitron', color: Theme.of(context).primaryColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // learn basics button
                Positioned(
                  top: 0.8009 * _screenHeight,
                  left: (_screenWidth - _kWidth) + 0.1025 * _kWidth,
                  child: Button(
                    width: 256.0,
                    height: 50.0,
                    text: 'Learn Basics',
                    onPressed: () => print('learn basics button pressed.'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
