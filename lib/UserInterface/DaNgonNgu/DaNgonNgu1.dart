import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class DaNgonNgu1 extends StatefulWidget {
  const DaNgonNgu1({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<DaNgonNgu1> createState() => DaNgonNgu1State();
}

class DaNgonNgu1State extends State<DaNgonNgu1> {
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
              MyKey.hello,
              style: Theme.of(context).textTheme.headline4,
            ).tr(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const DaNgonNgu2(
                      title: 'Da Ngon Ngu 2',
                    )),
          );
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class DaNgonNgu2 extends StatefulWidget {
  const DaNgonNgu2({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<DaNgonNgu2> createState() => DaNgonNgu2State();
}

class DaNgonNgu2State extends State<DaNgonNgu2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Wrap(
          direction: Axis.vertical,
          spacing: 20,
          children: <Widget>[
            const Text(
              MyKey.hello,
              style: TextStyle(fontFamily: 'Raleway', fontWeight: FontWeight.w800),
            ).tr(),
            ElevatedButton(
                onPressed: () {
                  context.setLocale(MyLocale.vi);
                },
                child: const Text('Tiếng Việt')),
            ElevatedButton(
                onPressed: () {
                  context.setLocale(MyLocale.en);
                },
                child: const Text('Tiếng Anh'))
          ],
        ),
      ),
      floatingActionButton: const FloatingActionButton(
        onPressed: null,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class MyLocale {
  static const en = Locale('en', 'US');
  static const vi = Locale('vi', 'VN');

  static List<Locale> listLocale() {
    return const [MyLocale.en, MyLocale.vi];
  }
}

class MyKey {
  static const hello = 'hello';
}
