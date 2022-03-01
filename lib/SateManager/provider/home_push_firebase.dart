import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_interface/SateManager/provider/provider_demo.dart';

class Home extends StatefulWidget {
  static final routerName = '/home';

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final FirebaseMessaging _messaging;
  PushNotification? _notificationInfo;

  late int _totalNotifications;

  String text =
      '=TEXT (Giá trị bạn muốn định dạng, "Mã định dạng bạn muốn áp dụng"). Dưới đây là một số ví dụ phổ biến mà bạn có thể sao chép trực tiếp vào Excel để thử nghiệm ...';

  @override
  void initState() {
    _totalNotifications = 0;
    super.initState();
    registerNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(kAppTitle),
        backgroundColor: Colors.teal,
      ),
      drawer: DrawerMenu(),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            child: Consumer<UI>(
              builder: (context, ui, child) {
                return RichText(
                  text: TextSpan(
                    text: text,
                    style:
                        TextStyle(fontSize: ui.fontSize, color: Colors.black),
                  ),
                );
              },
            ),
          ),
          Text(
            'TITLE: ${_notificationInfo?.title}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
          Text(
            'BODY: ${_notificationInfo?.body}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
          NotificationBadge(totalNotifications: _totalNotifications),
        ],
      ),
    );
  }

  void registerNotification() async {
    // 1. Initialize the Firebase app
    await Firebase.initializeApp();

    // 2. Instantiate Firebase Messaging
    _messaging = FirebaseMessaging.instance;

    _messaging.getToken().then((token) {
      print(token);
    });

    // 3. On iOS, this helps to take the user permissions
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        // Parse the message received
        PushNotification notification = PushNotification(
          title: message.notification?.title,
          body: message.notification?.body,
        );

        setState(() {
          _notificationInfo = notification;
          _totalNotifications++;
        });
      });
    } else {
      print('User declined or has not accepted permission');
    }
  }
}

class PushNotification {
  PushNotification({
    this.title,
    this.body,
  });
  String? title;
  String? body;
}
