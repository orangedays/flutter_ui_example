import 'package:flutter/material.dart';
import 'package:flutter_ui_example/pages/persistent_header_with_tab.dart';
import 'package:flutter_ui_example/widgets/widgets.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter UI Example',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: ''),
      //注册路由表
      routes:{
        "persistent_header_with_tab":(context)=>PersistentHeaderWithTabPage(),
      } ,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          final theme = Theme.of(context);
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
              ),
              child: Column(
                children: <Widget>[
                  OutlineButton(
                    borderSide:BorderSide(color: Theme.of(context).primaryColor),
                    child: Text('线框按钮',style: TextStyle(color: Theme.of(context).primaryColor),),
                    onPressed: (){},
                  ),
                  Theme(
                    data: theme.copyWith(primaryColor: Colors.red),
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: "Change TextField's Underline",
                        labelStyle: theme.textTheme.caption.copyWith(color: theme.primaryColor),
                      ),
                    ),
                  ),
                  ChipWithBorder(text: '可改变边框颜色的chip', icon: Icon(Icons.home),),
                  Card(
                    elevation: 3,
                    margin: EdgeInsets.all(20),
                    child: Padding(padding: EdgeInsets.all(20), child: Text('带阴影卡片')),
                  ),
                  new ClipRRect(
                    borderRadius: new BorderRadius.circular(30.0),
                    child: Image.network(
                      'https://avatars0.githubusercontent.com/u/11648898?s=40&v=4',
                      height: 150.0,
                      width: 100.0,
                    ),
                  ),
                  FlatButton(
                    child: Text("persistent_header_with_tab_page"),
                    textColor: Colors.blue,
                    onPressed: () {
                      //导航到新路由   
                      Navigator.pushNamed(context, "persistent_header_with_tab");
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
