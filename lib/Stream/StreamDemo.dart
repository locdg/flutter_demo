import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class StreamDemo extends StatefulWidget {
  const StreamDemo({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<StreamDemo> createState() => StreamDemoState();
}

class StreamDemoState extends State<StreamDemo> {
  MyStream stream = MyStream();

  @override
  void dispose() {
    stream.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: StreamBuilder(
            stream: stream.counterStream,
            builder: (context, snapshot) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'You have pushed the button this many times:',
                  ),
                  Text(
                    snapshot.hasData ? snapshot.data.toString() : '0',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ],
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          stream.increment();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

// Dung broadcast phai quan ly tranh lead memory
class MyStream {
  int counter = 0;
  StreamController counterController = StreamController<int>.broadcast();
  Stream get counterStream => counterController.stream.transform(editCounter);

  var editCounter =
      StreamTransformer<int, int>.fromHandlers(handleData: (data, sink) {
    data += 10;
    sink.add(data);
  });
  void increment() {
    counter += 1;
    counterController.sink.add(counter);
  }

  void dispose() {
    counterController.close();
  }
}
