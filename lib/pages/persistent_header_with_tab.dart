import 'package:flutter/material.dart';

void main() => runApp(PersistentHeaderWithTabPage());

class PersistentHeaderWithTabPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        body: Center(
          child: PersistentHeaderWithTab(),
        ),
      ),
    );
  }
}

class PersistentHeaderWithTab extends StatefulWidget {
  @override
  _PersistentHeaderWithTabState createState() =>
      _PersistentHeaderWithTabState();
}

class _PersistentHeaderWithTabState extends State<PersistentHeaderWithTab> {
  ScrollController _scrollController;
  final double _appBarHeight = 346.0;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(() => setState(() {}));
  }

  bool get _showTitle {
    return _scrollController.hasClients &&
        _scrollController.offset > _appBarHeight - kToolbarHeight;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: _appBarHeight,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: _showTitle ? Text('详情') : null,
                    background: Image.network(
                      "https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350",
                      fit: BoxFit.cover,
                    )),
              ),
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                  TabBar(
                    labelColor: Colors.black87,
                    unselectedLabelColor: Colors.grey,
                    tabs: [
                      Tab(icon: Icon(Icons.info), text: "Tab 1"),
                      Tab(icon: Icon(Icons.lightbulb_outline), text: "Tab 2"),
                    ],
                  ),
                ),
                pinned: true,
              ),
            ];
          },
          body: new TabBarView(children: <Widget>[
            new Center(child: new Text('tab1 view~')),
            Scrollbar(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16.0),
                child: Center(
                  child: Column(
                    // 动态创建一个List<Widget>
                    children: "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
                        .split("")
                        // 每一个字母都用一个Text显示,字体为原来的两倍
                        .map((c) => Text(
                              c,
                              textScaleFactor: 2.0,
                            ))
                        .toList(),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
      bottomNavigationBar: new Container(
        height: 51.0,
        child: new RaisedButton(
          child: const Text(
            '底部按钮～',
            style: TextStyle(
                color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
          ),
          color: Theme.of(context).accentColor,
          elevation: 4.0,
          //          splashColor: Colors.blueGrey,
          onPressed: () {
            // Perform some action
          },
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);
  final TabBar _tabBar;
  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
