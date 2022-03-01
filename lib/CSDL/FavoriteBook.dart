import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:user_interface/main.dart';

class FavoriteBook extends StatefulWidget {
  const FavoriteBook({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<FavoriteBook> createState() => FavoriteBookState();
}

class FavoriteBookState extends State<FavoriteBook> {
  int _counter = 0;
  late Box<String> favoritedBookBox;

  void _incrementCounter() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const FavoriteBook2(title: 'FavoriteBook2')),
    );
  }

  @override
  void initState() {
    super.initState();
    favoritedBookBox = Hive.box(constFavoritesBox);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: ValueListenableBuilder(
              valueListenable: favoritedBookBox.listenable(),
              builder: (context, box, widget) {
                return ListView.builder(
                    itemCount: books.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(books[index]),
                        trailing: IconButton(
                            onPressed: () {
                              onFavoritePress(index);
                            },
                            icon: getIcon(index)),
                      );
                    });
              })),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget getIcon(int index) {
    if (favoritedBookBox.containsKey(index)) {
      return const Icon(Icons.favorite, color: Colors.red);
    }
    return const Icon(Icons.favorite_border);
  }

  void onFavoritePress(int index) {
    if (favoritedBookBox.containsKey(index)) {
      favoritedBookBox.delete(index);
      return;
    }
    favoritedBookBox.put(index, books[index]);
  }
  // ..
}

const List<String> books = [
  // book name, index
  'Harry Potter', // 0
  'To Kill a Mockingbird', // 1
  'The Hunger Games', // 2
  'The Giver', // 3
  'Brave New World', // 4
  'Unwind', // 5
  'World War Z', // 6
  'The Lord of the Rings', // etc...
  'The Hobbit',
  'Moby Dick',
  'War and Peace',
  'Crime and Punishment',
  'The Adventures of Huckleberry Finn',
  'Catch-22',
  'The Sound and the Fury',
  'The Grapes of Wrath',
  'Heart of Darkness',
];

class FavoriteBook2 extends StatefulWidget {
  const FavoriteBook2({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<FavoriteBook2> createState() => FavoriteBook2State();
}

class FavoriteBook2State extends State<FavoriteBook2> {
  int _counter = 0;
  late Box<String> favoritedBookBox;
  void _incrementCounter() {
    print(favoritedBookBox.values.toString());
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
    super.initState();
    favoritedBookBox = Hive.box(constFavoritesBox);
    setState(() {
      _counter = favoritedBookBox.values.length;
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
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
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
