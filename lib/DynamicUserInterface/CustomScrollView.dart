import 'package:flutter/material.dart';

class CustomScrollViewDemo extends StatefulWidget {
  const CustomScrollViewDemo({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<CustomScrollViewDemo> createState() => CustomScrollViewDemoState();
}

class CustomScrollViewDemoState extends State<CustomScrollViewDemo> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  List<int> top = <int>[];
  List<int> bottom = <int>[0];

  @override
  Widget build(BuildContext context) {
    const Key centerKey = ValueKey<String>('bottom-sliver-list');
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              setState(() {
                top.add(-top.length - 1);
                bottom.add(bottom.length);
              });
            }),
      ),
      body: CustomScrollView(
        center: centerKey,
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  alignment: Alignment.center,
                  color: Colors.blue[200 + top[index] % 4 * 100],
                  height: 100 + top[index] % 4 * 20.0,
                  child: Text('Item: ${top[index]}'),
                );
              },
              childCount: top.length,
            ),
          ),
          SliverList(
            key: centerKey,
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  alignment: Alignment.center,
                  color: Colors.blue[200 + bottom[index] % 4 * 100],
                  height: 100 + bottom[index] % 4 * 20.0,
                  child: Text('Item: ${bottom[index]}'),
                );
              },
              childCount: bottom.length,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
