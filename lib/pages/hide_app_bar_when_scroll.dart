import 'package:flutter/material.dart';

// https://flutterdoc.com/animating-app-bars-in-flutter-cf034cd6c68b
// https://docs.flutter.io/flutter/widgets/SliverFixedExtentList-class.html

class hideAppBarWhenScrollPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new CustomScrollView(slivers: <Widget>[
        const SliverAppBar(
          title: const Text('Sliver App Bar'),
        ),
        new SliverList(delegate: new SliverChildListDelegate(buildTextViews(50))),
        // SliverFixedExtentList(
        //   itemExtent: 50.0,
        //   delegate: SliverChildBuilderDelegate(
        //     (BuildContext context, int index) {
        //       return Container(
        //         alignment: Alignment.center,
        //         color: Colors.lightBlue[100 * (index % 9)],
        //         child: Text('list item $index'),
        //       );
        //     },
        //   ),
        // )
      ])
    );
  }
}

List buildTextViews(int count) {
  List<Widget> strings = List();
  for (int i = 0; i < count; i++) {
    strings.add(new Padding(
      padding: new EdgeInsets.all(16.0),
      child: new Text(
        "Item number " + i.toString(),
        style: new TextStyle(fontSize: 20.0)
      )
    ));
  }
  return strings;
}
