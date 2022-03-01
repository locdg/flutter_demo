import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_interface/SateManager/provider/home_push_firebase.dart';

/*
ChangeNotifier: Nó có nhiệm vụ thông báo cho người nghe.
ChangeNotifierProvider: Nó sẽ lắng nghe khi ChangeNotifier.notifyListeners được gọi và 
thông báo tới các hàm build liên quan .
Consumer: đơn giản nó chỉ là một Widget do thư viện cung cấp . 
Chúng ta dùng widget này để lấy ra object thay vì phải gọi Provider.of.
*/

class UI with ChangeNotifier {
  double _fontSize = 0.5;

  set fontSize(newValue) {
    _fontSize = newValue;
    notifyListeners();
  }

  double get fontSize => _fontSize * 30;

  double get sliderFontSize => _fontSize;
}

const kTitle = 'Provider';

class DrawerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Center(
              child: Text(
                kTitle,
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.headline6?.fontSize,
                  color: Colors.white,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.teal,
            ),
          ),
          getListTile('Home', onTap: () {
            Navigator.pushNamed(context, Home.routerName);
          }),
          getLine(),
          getListTile('About', onTap: () {
            Navigator.pushNamed(context, '/about');
          }),
          getLine(),
          getListTile('Settings', onTap: () {
            Navigator.pushNamed(context, Settings.routerName);
          }),
        ],
      ),
    );
  }

  Widget getLine() {
    return SizedBox(
      height: 0.5,
      child: Container(
        color: Colors.grey,
      ),
    );
  }

  Widget getListTile(title, {required Function onTap}) {
    return ListTile(
      title: Text(title),
      onTap: () {
        onTap();
      },
    );
  }
}

const kAppTitle = 'State Management by Provider';
const kStateType = 'Provider';

class About extends StatelessWidget {
  static final routerName = '/about';
  String text =
      '=TEXT (Giá trị bạn muốn định dạng, "Mã định dạng bạn muốn áp dụng"). Dưới đây là một số ví dụ phổ biến mà bạn có thể sao chép trực tiếp vào Excel để thử nghiệm ...';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
        backgroundColor: Colors.teal,
      ),
      drawer: DrawerMenu(),
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: Consumer<UI>(
          builder: (context, ui, child) {
            return RichText(
              text: TextSpan(
                text: text,
                style:
                    TextStyle(fontSize: ui.fontSize, color: Colors.lightBlue),
              ),
            );
          },
        ),
      ),
    );
  }
}

class Settings extends StatelessWidget {
  static final routerName = '/setting';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Settings'),
      ),
      drawer: DrawerMenu(),
      body: Consumer<UI>(builder: (context, ui, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 20, top: 20),
              child: Text(
                'Font Size: ${ui.fontSize.toInt()}',
                style: TextStyle(
                    fontSize: Theme.of(context).textTheme.headline5?.fontSize),
              ),
            ),
            Slider(
                min: 0.5,
                value: ui.sliderFontSize,
                onChanged: (newValue) {
                  ui.fontSize = newValue;
                }),
          ],
        );
      }),
    );
  }
}

final Map<String, WidgetBuilder> routes = {
  Home.routerName: (context) => Home(),
  About.routerName: (context) => About(),
  Settings.routerName: (context) => Settings(),
};

class NotificationBadge extends StatelessWidget {
  final int totalNotifications;

  const NotificationBadge({required this.totalNotifications});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.0,
      height: 40.0,
      decoration: new BoxDecoration(
        color: Colors.red,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '$totalNotifications',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
