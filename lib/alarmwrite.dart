import 'package:flutter/material.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:day_night_time_picker/lib/constants.dart';
import 'package:flutter_alarm_s4/data/database.dart';
import 'package:flutter_alarm_s4/data/alarm.dart';

class AlarmWritePage extends StatefulWidget {
  final Alarm alarm;

  AlarmWritePage({Key? key, required this.alarm}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AlarmWritePageState();
  }
}

class _AlarmWritePageState extends State<AlarmWritePage> {
  //TimeOfDay _time = TimeOfDay.now().replacing(hour: 11, minute: 30);
  TimeOfDay _time = TimeOfDay.now();

  bool? _isRepeatWeek = false;
  double _Volvalue = 5.0;
  bool _locationToggle = false;
  bool _repeatToggle = false;
  bool _smartToggle = false;

  final AlarmNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.blueGrey,
          leading: Row(
            children: [
              GestureDetector(
                  onTap: () {
                    Navigator.pop(context, false);
                  },
                  child: Container(
                    padding: EdgeInsets.only(left: 10),
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                  )),
              Image.asset(
                'assets/clock.png',
                height: 29,
              ),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () {},
                child: Text(
                  '취소',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                )),
            TextButton(
                onPressed: () {},
                child: Text(
                  '저장',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                )),
          ],
        ),
        body: Column(
          children: [
            Expanded(
             child: SingleChildScrollView(
              child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[

                        SizedBox(height: 10,),

                        Container(
                          child: createInlinePicker(
                              elevation: 1,
                              value: _time,
                              onChange: onTimeChanged,
                              minuteInterval: MinuteInterval.ONE,
                              iosStylePicker: false,
                              minHour: 0,
                              maxHour: 23,
                              is24HrFormat: false,
                              isOnChangeValueMode: true,
                              dialogInsetPadding: EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 10.0)),
                        ),

                        SizedBox(height: 10,),

                        WeekChecker(),    // 요일 선택

                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text("매주반복", style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),),
                              Checkbox(
                                side: BorderSide(
                                    color: Colors.white,
                                    width: 1.5
                                ),
                                checkColor: Colors.green,
                                value: _isRepeatWeek,
                                onChanged: (value){
                                  setState(() {
                                    _isRepeatWeek = value;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),

                        Divider(color: Colors.grey,),

                        ListTile(
                          title: Text("알람 방식", style: TextStyle(color: Colors.white),),
                          subtitle: Text("벨소리", style: TextStyle(color: Colors.grey),),
                          trailing: Container(
                            decoration: BoxDecoration(
                              color: Colors.blueGrey,
                              shape: BoxShape.circle,
                            ),
                            width: 40,
                            child:  Icon(Icons.arrow_forward_ios_rounded, color: Colors.white,size: 20,),
                          ),
                        ),

                        Divider(color: Colors.grey,),

                        ListTile(
                          title: Text("알람음", style: TextStyle(color: Colors.white),),
                          subtitle: Text("기본 알림음", style: TextStyle(color: Colors.grey),),
                          trailing: Container(
                            decoration: BoxDecoration(
                              color: Colors.blueGrey,
                              shape: BoxShape.circle,
                            ),
                            width: 40,
                            child:  Icon(Icons.arrow_forward_ios_rounded, color: Colors.white,size: 20,),
                          ),
                        ),

                        Divider(color: Colors.grey,),

                       Container(
                         child: Row(
                           children: [
                             Container(
                               margin: EdgeInsets.only(left: 20),
                               child: Icon(Icons.volume_up, color: Colors.white,),
                             ),
                             Container(
                               width: MediaQuery.of(context).size.width - 50,
                               child: Slider(
                                 min: 0.0,
                                 max: 100.0,
                                 value: _Volvalue,
                                 onChanged: (value) {
                                   setState(() {
                                     _Volvalue = value;
                                     print(value);
                                   });
                                 },
                               )
                             ),

                           ],
                         ),
                       ),

                        Divider(color: Colors.grey,),
                        
                      SwitchListTile.adaptive(
                          title: Text("위치 알람", style: TextStyle(color: Colors.white),),
                          value: _locationToggle,
                          onChanged: (value){
                            setState(() {
                              _locationToggle = value;
                            });
                            print(value);
                          }
                      ),

                        Divider(color: Colors.grey,),

                        SwitchListTile.adaptive(
                            title: Text("다시 알람", style: TextStyle(color: Colors.white),),
                            subtitle: Text("5분, 3회", style: TextStyle(color: Colors.grey),),
                            value: _repeatToggle,
                            onChanged: (value){
                              setState(() {
                                _repeatToggle = value;
                              });
                              print(value);
                            }
                        ),

                        Divider(color: Colors.grey,),

                        SwitchListTile.adaptive(
                            title: Text("스마트 알람", style: TextStyle(color: Colors.white),),
                            subtitle: Text("3분, 요정의 분수", style: TextStyle(color: Colors.grey),),
                            value: _smartToggle,
                            onChanged: (value){
                              setState(() {
                                _smartToggle = value;
                              });
                              print(value);
                            }
                        ),

                        Divider(color: Colors.grey,),

                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 15),
                                child:  Text("이름", style: TextStyle(color: Colors.white, fontSize: 17),),
                              ),
                              SizedBox(height: 10,),

                              Container(
                                margin: EdgeInsets.only(left: 15),
                                child: TextField(
                                  controller: AlarmNameController,
                                  decoration: InputDecoration(
                                    labelText: '알람',
                                    //hintText: 'Enter your email',
                                    labelStyle: TextStyle(color: Colors.grey, fontSize: 17),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                      borderSide: BorderSide(width: 1, color: Colors.grey),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                      borderSide: BorderSide(width: 1, color: Colors.grey),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                    ),
                                  ),
                                  keyboardType: TextInputType.text,
                                ),
                              ),



                            ],
                          ),
                        ),

                      ],
                    ),





            ),
    )
          ],
        ),
      ),
    );
  }

  void onTimeChanged(TimeOfDay newTime) {
    setState(() {
      _time = newTime;
      print(_time);
    });
  }



  Widget WeekChecker() {
    return  Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: 50,
            height: 50,
            color: Colors.blueGrey,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  bottom: 15,
                  child: Text("일", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                ),
                Positioned(
                    bottom: 10,
                    left: 5,
                    child: Text("____", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),)
                ),
              ],
            ),
          ),
          Container(
            width: 50,
            height: 50,
            color: Colors.blueGrey,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  bottom: 15,
                  child: Text("월", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                ),
                Positioned(
                    bottom: 10,
                    left: 5,
                    child: Text("____", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),)
                ),
              ],
            ),
          ),
          Container(
            width: 50,
            height: 50,
            color: Colors.blueGrey,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  bottom: 15,
                  child: Text("화", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                ),
                Positioned(
                    bottom: 10,
                    left: 5,
                    child: Text("____", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),)
                ),
              ],
            ),
          ),
          Container(
            width: 50,
            height: 50,
            color: Colors.blueGrey,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  bottom: 15,
                  child: Text("수", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                ),
                Positioned(
                    bottom: 10,
                    left: 5,
                    child: Text("____", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),)
                ),
              ],
            ),
          ),
          Container(
            width: 50,
            height: 50,
            color: Colors.blueGrey,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  bottom: 15,
                  child: Text("목", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                ),
                Positioned(
                    bottom: 10,
                    left: 5,
                    child: Text("____", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),)
                ),
              ],
            ),
          ),
          Container(
            width: 50,
            height: 50,
            color: Colors.blueGrey,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  bottom: 15,
                  child: Text("금", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                ),
                Positioned(
                    bottom: 10,
                    left: 5,
                    child: Text("____", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),)
                ),
              ],
            ),
          ),
          Container(
            width: 50,
            height: 50,
            color: Colors.blueGrey,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  bottom: 15,
                  child: Text("토", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                ),
                Positioned(
                    bottom: 10,
                    left: 5,
                    child: Text("____", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),)
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
