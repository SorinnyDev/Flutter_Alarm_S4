import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter_alarm_s4/alarmwrite.dart';
import 'package:flutter_alarm_s4/data/alarm.dart';
import 'package:flutter_alarm_s4/data/database.dart';
import 'data/util.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final dbHelper = DatabaseHelper.instance;

  int selectedTabIndex = 0;
  final alertColor = 1;
  List<Alarm> alarm = [];

  @override
  void initState() {
    super.initState();
    getAllAlarm();
  }

  void getAllAlarm() async{
    alarm = await dbHelper.getAllAlarm();
  }

  @override
  Widget build(BuildContext context) => DefaultTabController(
    length: 4,
    child: SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 50,
          bottom: TabBar(
            onTap: (idx){
              setState(() {
                selectedTabIndex = idx;
              });
            },
            tabs: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  children: [
                    Icon(Icons.alarm, color: selectedTabIndex == 0 ? Colors.white : Colors.grey,),
                    Container(height: 5,),
                    Text("알람", style: TextStyle(color: selectedTabIndex == 0 ? Colors.white : Colors.grey, fontWeight: FontWeight.bold),)
                  ],
                ),
              ),
              Container(
                //margin: EdgeInsets.all(20),
                child: Column(
                  children: [
                    SvgPicture.asset("assets/web.svg",
                      color: selectedTabIndex == 1 ? Colors.white : Colors.grey,
                    ),
                    Container(height: 5,),
                    Text("세계시각", style: TextStyle(color: selectedTabIndex == 1 ? Colors.white : Colors.grey, fontWeight: FontWeight.bold),),
                  ],
                ),
              ),
              Container(
                //margin: EdgeInsets.all(20),
                child: Column(
                  children:[
                    Icon(Icons.timer_outlined, color: selectedTabIndex == 2 ? Colors.white : Colors.grey,),
                    Container(height: 5,),
                    Text("스톱워치", style: TextStyle(color: selectedTabIndex == 2 ? Colors.white : Colors.grey, fontWeight: FontWeight.bold),),
                  ],
                ),
              ),
              Container(
                //margin: EdgeInsets.all(20),
                child: Column(
                  children:[
                    SvgPicture.asset("assets/timer-sand.svg",
                      color: selectedTabIndex == 3 ? Colors.white : Colors.grey,
                    ),
                    Container(height: 5,),
                    Text("타이머", style: TextStyle(color: selectedTabIndex == 3 ? Colors.white : Colors.grey, fontWeight: FontWeight.bold),),
                  ],
                ),
              ),
            ],
          ),
        ),

        body: TabBarView(
          children: [
            alarmPage(),
            Container(child: Text("Tab2")),
            Container(child: Text("Tab3")),
            Container(child: Text("Tab4")),
          ],
        ),
      ),
    ),
  );

  Widget alarmPage() {

    Alarm _a;

    return Container(
      color: Colors.black,
      child: ListView.builder(
        itemBuilder: (ctx, idx){
          if(idx == 0){

            return InkWell(
              child: Container(
                color: Colors.blueGrey,
                child: ListTile(
                  leading: Text("알람 추가", style: TextStyle(color: Colors.white, fontSize: 20),),
                  trailing: Icon(Icons.add, color: Colors.white,),
                  dense: true,
                ),
              ),
              onTap: (){

                _a = Alarm(
                    alarm_date_apm: 0,
                    alarm_date_time: Utils.getFormatTime(DateTime.now()),
                    alarm_title: "제목",
                    alarm_memo: "메모",
                    alarm_days: "1,1,1,1,1,1,1",
                    alarm_enable: 0
                );

                Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctx) =>
                        AlarmWritePage(alarm: _a)));
              },
            );

          }else {

            return InkWell(

              child: Container(
                height: 70,
                decoration: BoxDecoration(
                  image:      (idx % 2 == 0) ?
                  DecorationImage(image: AssetImage('assets/back_day.jpeg'), fit: BoxFit.fitWidth,
                      colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.9), BlendMode.dstATop))
                      :
                  DecorationImage(image: AssetImage('assets/back_night.jpeg'), fit: BoxFit.fitWidth,
                      colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.dstATop))
                  ,
                  border: Border.symmetric(horizontal: BorderSide(color: Colors.black54, width: .5)),
                ),
                child: ListTile(
                  tileColor: Colors.grey,
                  onTap: (){
                    print("아이템클릭");
                  },
                  onLongPress: (){
                    print("아이템 롱 프레스");
                  },
                  leading: Text("오후 4:38", style: TextStyle(color: Colors.white, fontSize: 20),),
                  title: Text("알람", style: TextStyle(color: Colors.white, fontSize: 20),),
                  subtitle: Text("일 월 화 수 목 금 토", style: TextStyle(color: Colors.greenAccent, fontSize: 20),),
                  trailing:
                  IconButton(
                    icon: idx % 2 == 0 ? Icon(Icons.alarm, color: Colors.greenAccent,) : Icon(Icons.alarm, color: Colors.grey,) ,
                    //Icon(Icons.alarm, color: Colors.white,),
                    onPressed: (){
                      print("아이콘클릭 : ${alarm}");

                    },
                  ),
                  dense: true,
                ),
              ),
            );
          }
        },
        itemCount: alarm.length + 1,
      ),
    );
  }
}
