import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveDemmo extends StatefulWidget {
  const HiveDemmo({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HiveDemmo> createState() => HiveDemmoState();
}

class HiveDemmoState extends State<HiveDemmo> {
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
            Text(
                'You have pushed the button this many times -- Box => ${Hive.box('Settings').get('darkMode')}'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            ValueListenableBuilder<Box>(
                valueListenable: Hive.box('Settings').listenable(),
                builder: (context, box, widget) {
                  return Switch(
                      value: box.get('darkMode', defaultValue: false),
                      onChanged: (val) {
                        setState(() {
                          box.put('darkMode', val);
                        });
                      });
                })
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
