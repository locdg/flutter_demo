import 'package:flutter/material.dart';

class Lannguage {
  static String defaultLanguage = Lang.en.name;

  static Map<String, Map<String, String>> localizedValues = {
    'en': {
      'title': 'Storefront',
      'language': 'Language',
      'googleLogin': 'Login with Google'
    },
    'vn': {
      'title': 'Cửa hàng',
      'language': 'Ngôn ngữ',
      'googleLogin': 'Đăng Nhập với Google'
    }
  };

  static setlanguage(String lang) {
    defaultLanguage = lang;
  }

  static String getLanguage(String key) {
    var result = localizedValues[defaultLanguage] ?? {'': ''};
    return result[key] ?? '';
  }
}

class KeyLang {
  static const String title = 'title';
  static const String language = 'language';
  static const String googleLogin = 'googleLogin';
}

enum Lang { en, vn }

class LanguageDemo extends StatefulWidget {
  const LanguageDemo({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<LanguageDemo> createState() => LanguageDemoState();
}

class LanguageDemoState extends State<LanguageDemo> {
  int _counter = 0;

  bool isEn = true;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void changeLanguage() {
    setState(() {
      isEn = !isEn;
      Lannguage.defaultLanguage = isEn ? Lang.en.name : Lang.vn.name;
    });
  }

  @override
  Widget build(BuildContext context) {
    String title = Lannguage.getLanguage(KeyLang.title);
    String language = Lannguage.getLanguage(KeyLang.language);
    String googleLogin = Lannguage.getLanguage(KeyLang.googleLogin);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('$title\n$language\n$googleLogin'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: changeLanguage,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
