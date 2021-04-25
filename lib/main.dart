import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sleep_manager/test.dart';
import 'package:sleep_manager/utils/uidata.dart';

bool darkmode = true;
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: '수면사이클',
      theme: darkmode ? UIData.darkTheme : UIData.lightTheme,
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '수면사이클',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).accentColor,
        elevation: 0,
        bottom: TabBar(
          unselectedLabelColor: Colors.white,
          labelColor: Colors.black,
          indicatorSize: TabBarIndicatorSize.tab,
          indicator: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5.0),
              topRight: Radius.circular(5.0),
            ),
            color: Colors.white,
          ),
          tabs: [
            Tab(
              icon: Icon(Icons.king_bed),
              text: '수면사이클',
            ),
            Tab(icon: Icon(Icons.schedule), text: '알람'),
            Tab(icon: Icon(Icons.nights_stay), text: '야식타임'),
          ],
          controller: _tabController,
        ),
      ),
      body: TabBarView(
        children: [screen1(), screen1(), screen1()],
        controller: _tabController,
      ),
    );
  }

  Widget screen1() {
    DateTime _tempTime = DateTime.now();
    String _formattedDate = DateFormat('a kk:mm').format(_tempTime);

    return Container(
      decoration: BoxDecoration(color: Theme.of(context).backgroundColor),
      child: Column(
        children: [
          Container(
            child: Column(
              children: [
                defaultText(
                    text: '만약 ${_formattedDate}시에 잠들면',
                    color: Theme.of(context).accentColor),
                defaultText(
                  text: '시에 일어나야 합니다.',
                  color: Theme.of(context).accentColor,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                Card(
                  child: Container(
                    padding: EdgeInsets.only(
                        right: 20, left: 20, top: 20, bottom: 20),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Text(
                              '1',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w800),
                            ),
                            Text(
                              '사이클',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w800),
                            )
                          ],
                        ),
                        // VerticalDivider(
                        //   width: 2,
                        //   thickness: 2,
                        //   color: Colors.white,
                        // ),
                        SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '21/4/24 오후 11:52',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w800),
                              ),
                              Text(
                                '낮잠 03h14m',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w800),
                              )
                            ],
                          ),
                        ),
                        Icon(Icons.alarm),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget defaultText(
          {String text,
          Color color,
          FontWeight fontWeight = FontWeight.w600}) =>
      Text(text, style: TextStyle(color: color, fontWeight: fontWeight));
}
