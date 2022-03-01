import 'package:flutter/material.dart';

class ListViewDemo extends StatefulWidget {
  const ListViewDemo({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<ListViewDemo> createState() => ListViewDemoState();
}

class ListViewDemoState extends State<ListViewDemo> {
  int _counter = 0;
  final List<String> listJob = [
    'IOS',
    'Android AndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroid',
    ' Flutter',
    'Java',
    'IOS',
    'Android AndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroid',
    ' Flutter',
    'Java',
    'IOS',
    'Android AndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroid',
    ' Flutter',
    'Java',
    'IOS',
    'Android AndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroid',
    ' Flutter',
    'Java',
    'IOS',
    'Android AndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroid',
    ' Flutter',
    'Java',
    'IOS',
    'Android AndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroidAndroid',
    ' Flutter',
    'Java'
  ];

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
      body: ListJobIT(
        listJob: listJob,
        sendNameJob: (String nameJob) {
          print(nameJob);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ListJobIT extends StatelessWidget {
  final List<String> listJob;
  const ListJobIT({Key? key, required this.listJob, required this.sendNameJob})
      : super(key: key);
  final Function(String) sendNameJob;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.all(20),
      child: ListView.builder(
        itemCount: listJob.length,
        itemBuilder: (context, index) {
          return ItemListJob(
            namJob: listJob[index],
            sendNameJob: (String nameJob) {
              sendNameJob(nameJob);
            },
          );
        },
      ),
    );
  }
}

class ItemListJob extends StatelessWidget {
  final String namJob;
  const ItemListJob({
    Key? key,
    required this.namJob,
    required this.sendNameJob,
  }) : super(key: key);
  final Function(String) sendNameJob;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 10),
        child: Card(
          child: Container(
              padding: const EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(child: Text(namJob), flex: 9),
                  Expanded(
                      flex: 1,
                      child: IconButton(
                          onPressed: () {
                            sendNameJob(namJob);
                          },
                          icon: const Icon(Icons.add)))
                ],
              )),
        ));
  }
}
