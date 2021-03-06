import 'package:flutter/material.dart';
// https://blog.csdn.net/yuezheyue123/article/details/84345219
// https://upload-images.jianshu.io/upload_images/8921320-9b4bfbc8b81a4621.jpg
class AnimationExamplePage extends StatefulWidget {
  @override
  _AnimationExamplePageState createState() => _AnimationExamplePageState();
}


class _AnimationExamplePageState extends State<AnimationExamplePage> with SingleTickerProviderStateMixin {
  Animation movement;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _initController();
    _initAni();
    _startAnimation();
  }

  void _initController() {
    _controller = AnimationController(
      duration: Duration(milliseconds: 5000),
      vsync: this,
    );
  }

  void _initAni() {
    movement = EdgeInsetsTween(
      begin: EdgeInsets.only(top: 0.0, right: 0.0),
      end: EdgeInsets.only(top: 0.0, right: 200.0),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.1,
          0.5,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    )
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((AnimationStatus status) {
        print(status);
      });
  }

  Future _startAnimation() async{
    try{
      await _controller.repeat();
      await _controller.forward().orCancel;
      await _controller.reverse().orCancel;
    } on TickerCanceled {
      print('Animation Failed');
    }
  }

  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => new AlertDialog(
        title: new Text("Dialog Title"),
        content: new AnimatedBuilder(
          animation: movement,
          builder: (BuildContext context, Widget child) {
            return new Container(
              color: Colors.blue,
              height: 200.0,
              width: 1000.0,
              padding: movement.value,
              child: new Center(
                child: new Text(
                  'movement',
                  style: new TextStyle(
                    color: Colors.white,
                    fontSize: 16.0
                  ),
                ),
              ),
            );
          },
        ),
        actions:<Widget>[
          new FlatButton(child:new Text("CANCEL"), onPressed: (){
            Navigator.of(context).pop();

          },),
          new FlatButton(child:new Text("OK"), onPressed: (){
            Navigator.of(context).pop();

          },)
        ]

      ));
  }

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        new Container(
          color: Colors.blue,
          height: 200.0,
          width: 1000.0,
          padding: movement.value,
          child: new Center(
            child: new Text(
              'movement',
              style: new TextStyle(
                color: Colors.white,
                fontSize: 16.0
              ),
            ),
          ),
        ),
        new RaisedButton(
          child: new Text(
            'show dialog',
            style: new TextStyle(
              fontSize: 18.0, //textsize
              color: Colors.white, // textcolor
            ),
          ),
          onPressed: () {
            showAlertDialog(context);
          }
        )
      ],
    );
  }
}
