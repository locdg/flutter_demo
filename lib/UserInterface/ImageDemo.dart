import 'package:flutter/material.dart';

class ImageDemo extends StatefulWidget {
  const ImageDemo({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<ImageDemo> createState() => ImageDemoState();
}

class ImageDemoState extends State<ImageDemo> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Image.asset('assets/loading.gif',
            //     width: 300, height: 300, fit: BoxFit.contain),
            // Image.network(
            //   'https://picsum.photos/250?image=9',
            //   width: 300,
            //   fit: BoxFit.contain,
            // ),
            
            FadeInImage.assetNetwork(
                placeholder: 'assets/images/loading.gif',
                image: 'https://picsum.photos/250?image=9'),
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
