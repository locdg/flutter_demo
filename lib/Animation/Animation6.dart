import 'package:flutter/material.dart';
import 'dart:math' as math;

class Animation6 extends StatefulWidget {
  @override
  _Animation6State createState() => _Animation6State();
}

class _Animation6State extends State<Animation6> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool _instagramView = false;
  List<String> urlList = [
    "https://images.unsplash.com/photo-1544005313-94ddf0286df2?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8c2VsZmllJTIwZ2lybHxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&w=1000&q=80",
    "https://images.unsplash.com/photo-1543486958-d783bfbf7f8e?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8c2VsZmllfGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&w=1000&q=80",
    "https://image.winudf.com/v2/image1/Y29tLmdvbGRkZXguaGRzZWxmaWVjYW1lcmFfc2NyZWVuXzNfMTU1Mjg3ODE0N18wOTA/screen-3.jpg?fakeurl=1&type=.jpg",
    "https://images.unsplash.com/photo-1598966739654-5e9a252d8c32?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MjN8fHNlbGZpZXxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&w=1000&q=80",
    "https://ak.picdn.net/shutterstock/videos/17533732/thumb/1.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Animation 6",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            color: Colors.black,
            onPressed: () {
              setState(() {
                _instagramView = !_instagramView;
              });
            },
            icon: Icon(Icons.swap_horizontal_circle_outlined),
          )
        ],
      ),
      body: _instagramView ? _buildInstagramView() : _buildCenter(),
    );
  }

  Widget _buildInstagramView() {
    double size = 130;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          urlList.length,
          (index) => Container(
            margin:
                EdgeInsets.only(top: 10, left: index == 0 ? 10 : 0, right: 10),
            width: size,
            height: size,
            child: Stack(
              children: [
                AnimatedBuilder(
                  animation: _controller,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [Colors.red, Colors.purple],
                      ),
                    ),
                  ),
                  builder: (BuildContext context, Widget? child) {
                    return Transform.rotate(
                      angle: _controller.value * 2.0 * math.pi,
                      child: child,
                    );
                  },
                ),
                Center(
                  child: CircleAvatar(
                    radius: size * 0.44,
                    backgroundImage: NetworkImage(urlList[index]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget circleColors() => Container(
        width: 200.0,
        height: 200.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.purple],
          ),
        ),
        child: textCenter(),
      );

  Widget textCenter() => Center(
        child: Text(
          'TEXT',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      );

  Widget _buildCenter() => Center(
        child: AnimatedBuilder(
          animation: _controller,
          child: circleColors(),
          builder: (BuildContext context, Widget? child) {
            return Transform.rotate(
              angle: _controller.value * 2.0 * math.pi,
              child: child,
            );
          },
        ),
      );
}
