import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_interface/Animation/Animation4.dart';
import 'package:user_interface/Animation/Animation6.dart';
import 'package:user_interface/CSDL/FavoriteBook.dart';
import 'package:user_interface/CSDL/HiveDemo.dart';
import 'package:user_interface/DynamicUserInterface/CustomScrollView.dart';
import 'package:user_interface/DynamicUserInterface/ListViewDemo.dart';
import 'package:user_interface/Media/video.dart';
import 'package:user_interface/RestfulAPI/DioDemo.dart';
import 'package:user_interface/RestfulAPI/HttpDemo.dart';
import 'package:user_interface/SateManager/provider/home_push_firebase.dart';
import 'package:user_interface/SateManager/provider/provider_demo.dart';
import 'package:user_interface/SateManager/redux_demo.dart';
import 'package:user_interface/UserInterface/DaNgonNgu/DaNgonNgu1.dart';
import 'package:user_interface/UserInterface/ImageDemo.dart';
import 'package:hive/hive.dart';
import 'Animation/Animation5.dart';
import 'CSDL/stogared.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'Stream/BlockPartern.dart';
import 'Stream/StreamDemo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  initHive();
  runApp(EasyLocalization(
    child: const MyApp(),
    supportedLocales: MyLocale.listLocale(),
    path: 'assets/i18n',
    saveLocale: true,
    fallbackLocale: MyLocale.vi,
  ));
}

const constFavoritesBox = 'favorite_books';
void initHive() async {
  await Hive.initFlutter();
  await Hive.openBox<String>(constFavoritesBox);

  // var box = await Hive.openBox('testBox');
  // box.put('name', 'Dong Gia Loc');
  // print('Name: ${box.get('name', defaultValue: '')}');

  // var box = await Hive.openBox('box');

  // box.put('key', 'value');
  // print(box.get('key')); // value

  // var lazyBox = await Hive.openLazyBox('lazyBox');

  // var future = lazyBox.put('key', 'value');
  // print(lazyBox.get('key')); // null

  // await future;
  // print(lazyBox.get('key')); // value
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var color = const Color(0xFF45D1FD);
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => UI()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          title: 'Flutter Demo',
          theme: ThemeData(
              fontFamily: 'Roboto',
              primaryColor: color,
              textTheme:
                  const TextTheme(bodyText2: TextStyle(color: Colors.red)),
              primarySwatch: Colors.pink,
              elevatedButtonTheme: ElevatedButtonThemeData(
                  style: ElevatedButton.styleFrom(
                      // primary: color,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14))))),
          initialRoute: Home.routerName,
          routes: routes,
        ));
  }
}

//  initialRoute: SplashScreen.routeName,
//       routes: routes,