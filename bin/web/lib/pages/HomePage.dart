import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    //stores the current height and width of the current screen.
    final _screenWidth = MediaQuery.of(context).size.width;
    final _screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        height: _screenHeight,
        width: _screenWidth,
        color: Colors.black,
        child: Stack(
          children: [
            _MenuBar(),
            Scrollbar(
              child: SingleChildScrollView(),
            ),
          ],
        ),
      ),
    );
  }
}

/// menubar
class _MenuBar extends StatefulWidget {
  _MenuBarState createState() => _MenuBarState();
}

class _MenuBarState extends State<_MenuBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      width: MediaQuery.of(context).size.width,
      color: Colors.yellow,
      child: Row(),
    );
  }
}
