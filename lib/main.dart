import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sleep_manager/test.dart';
import 'package:sleep_manager/utils/uidata.dart';
import 'package:sleep_manager/widget/cycle_item.dart';

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
        children: [screen1(), notImplemented(), notImplemented()],
        controller: _tabController,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (mounted) setState(() {});
        },
        child: Icon(Icons.refresh),
      ),
    );
  }

  Widget screen1() {
    DateTime _tempTime = DateTime.now();
    String _formattedDate =
        CycleItem.timeEnToKo(DateFormat('a hh:mm').format(_tempTime));

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
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                DateTime wakeUpTime = _tempTime.add(
                    Duration(hours: 1, minutes: 44) +
                        Duration(hours: 1, minutes: 30) * index);
                return CycleItem(
                  cycle: index + 1,
                  nowTime: _tempTime,
                  wakeUpTime: wakeUpTime,
                );
              },
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

  Widget notImplemented() => Container(
        color: Theme.of(context).backgroundColor,
        child: Center(
          child: Text(
            '준비중',
            style: TextStyle(
                color: Colors.redAccent,
                fontSize: 54,
                fontWeight: FontWeight.w800),
          ),
        ),
      );
}
