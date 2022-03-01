// import 'package:flutter/material.dart';
// import 'package:flutter_redux/flutter_redux.dart';
// import 'package:redux/redux.dart';

// class ReduxDemo extends StatefulWidget {
//   const ReduxDemo({Key? key, required this.title}) : super(key: key);

//   final String title;

//   @override
//   State<ReduxDemo> createState() => ReduxDemoState();
// }

// class ReduxDemoState extends State<ReduxDemo> {
//   final store = new Store<int>(counterReducer, initialState: 0);
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: StoreProvider<int>(
//         store: store,
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               const Text(
//                 'You have pushed the button this many times:',
//               ),
//               StoreConnector<int, String>(
//                   builder: (context, count) {
//                     return Text(count);
//                   },
//                   converter: (store) => store.state.toString())

//               // child: Text(
//               //   '$_counter',
//               //   style: Theme.of(context).textTheme.headline4,
//               // ),
//               // ),
//             ],
//           ),
//         ),
//       ),
//       floatingActionButton: StoreConnector<int, VoidCallback>(
//         converter: (store) {
//           return () => store.dispatch(Actions.increment);
//         },
//         builder: (context, callback) {
//           return FloatingActionButton(
//             onPressed: callback,
//             tooltip: 'Increment',
//             child: Icon(Icons.add),
//           );
//         },
//       ),
//     );
//   }
// }

// // Tao 1 action tang
// enum Actions { increment }

// // The reducer : Khi nhận được Action:  Increment, thì biến số state sẽ thay đổi- tăng lên 1
// int counterReducer(int state, dynamic action) {
//   return action == Actions.increment ? (state + 1) : state;
// }
