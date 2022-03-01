import 'package:flutter/material.dart';

class Animation5 extends StatefulWidget {
  const Animation5({Key? key}) : super(key: key);

  @override
  _Animation5State createState() => _Animation5State();
}

class _Animation5State extends State<Animation5> {
  bool selected = false;
  double iconSize = 100;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Animation 5"),
      ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 180.0,
            color: Colors.blue,
          ),
          SizedBox(
            width: double.infinity,
            height: 180.0 + iconSize / 3,
            child: AnimatedAlign(
              alignment: selectAlignment(),
              duration: const Duration(seconds: 1),
              curve: Curves.fastOutSlowIn,
              child: GestureDetector(
                onTap: changeAlignment,
                child: profilePicture(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget profilePicture() => Container(
        decoration: const BoxDecoration(
          color: Colors.black45,
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.account_circle_sharp,
          size: iconSize,
          color: Colors.blue,
        ),
      );

  changeAlignment() {
    setState(() {
      selected = !selected;
    });
  }

  selectAlignment() => selected ? Alignment.bottomLeft : Alignment.bottomCenter;
}
