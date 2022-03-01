import 'package:flutter/material.dart';

class MyInheritedWidget extends InheritedWidget {
  /* Là constructor của MyInheritedWidget, constructor này nhận ít nhất 2 param: 
  thứ nhất là child chính là những widget con của nó - 
  những widget mà sau này sẽ giơ cao cánh tay lên chộp lấy data từ nó đó 😄. 
  Thứ 2 là myData chính là data mà nó sẽ chia sẻ đến cho các widget con của nó đó. */
  MyInheritedWidget(this.myData, {required Widget child}) : super(child: child);

  final int myData;

  @override
  bool updateShouldNotify(MyInheritedWidget oldWidget) {
    return (myData != oldWidget.myData && oldWidget.myData % 2 == 0);
  }
  /* Hàm of là một hàm static, hàm này truyền vào một BuildContext, sẽ giúp các widget truy cập trực tiếp 
  vào MyInheritedWidget để lấy data bằng cách gọi MyInheritedWidget.of(context)
  Hàm dependOnInheritedWidgetOfExactType truyền vào Widget type. 
  Nó sẽ giúp ta get được Widget cha gần vị trí context nhất theo cái Type mình truyền vào */

  static MyInheritedWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MyInheritedWidget>();
  }
}

class DemoInherited extends StatefulWidget {
  const DemoInherited({Key? key, required this.child}) : super(key: key);
  final Widget child;
  @override
  State<DemoInherited> createState() => DemoInheritedState();
}

class DemoInheritedState extends State<DemoInherited> {
  int counter = 10;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Inherited Widget'),
        ),
        body: MyInheritedWidget(counter, child: widget.child),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              counter++;
            });
          },
          child: const Icon(Icons.add),
        ));
  }
}

class CenterInherited extends StatelessWidget {
  const CenterInherited({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: TextInherited(),
    );
  }
}

class TextInherited extends StatelessWidget {
  const TextInherited({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final counter = MyInheritedWidget.of(context)?.myData;
    return Text('Data hien tai: $counter');
  }
}
