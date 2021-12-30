
class Alarm {
  int? alarm_id;
  int alarm_date_apm;
  int alarm_date_time;
  String alarm_title;
  String alarm_memo;
  String alarm_days;
  int alarm_enable;

  Alarm({
    this.alarm_id,
    required this.alarm_date_apm,
    required this.alarm_date_time,
    required this.alarm_title,
    required this.alarm_memo,
    required this.alarm_days,
    required this.alarm_enable,
  });
}