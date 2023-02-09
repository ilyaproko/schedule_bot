/* 
// Example Usage
Map<String, dynamic> map = jsonDecode(<myJSONString>);
var myRootNode = Root.fromJson(map);
*/
class Data {
  List<Rasp?>? rasp;

  Data({this.rasp});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['rasp'] != null) {
      rasp = <Rasp>[];
      json['rasp'].forEach((v) {
        rasp!.add(Rasp.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rasp'] = rasp != null ? rasp!.map((v) => v?.toJson()).toList() : null;
    return data;
  }
}

class Rasp {
  int? code;
  late DateTime date;
  late String start;
  late DateTime startDate;
  late DateTime endDate;
  late String end;
  late int dayWeekNum;
  late String dayWeekStr;
  String? mail;
  String? day;
  int? semesterCode;
  int? typeWeek;
  int? subgroupNumber;
  late String discipline;
  late String teacher;
  late String audience;
  String? academicYear;
  String? group;
  String? custom1;
  String? hours;
  int? startWeek;
  int? endWeek;
  bool? replacement;
  int? teacherCode;
  int? groupCode;
  String? teacherFullName;
  bool? scheduleCycleElement;
  String? subject;
  int? employmentNumbers;

  Rasp(
      {this.code,
      required this.date,
      required this.start,
      required this.startDate,
      required this.endDate,
      required this.end,
      required this.dayWeekNum,
      required this.dayWeekStr,
      this.mail,
      this.day,
      this.semesterCode,
      this.typeWeek,
      this.subgroupNumber,
      required this.discipline,
      required this.teacher,
      required this.audience,
      this.academicYear,
      this.group,
      this.custom1,
      this.hours,
      this.startWeek,
      this.endWeek,
      this.replacement,
      this.teacherCode,
      this.groupCode,
      this.teacherFullName,
      this.scheduleCycleElement,
      this.subject,
      this.employmentNumbers});

  Rasp.fromJson(Map<String, dynamic> json) {
    code = json['код'];
    date = DateTime.parse(json['дата']);
    start = json['начало'];
    startDate = DateTime.parse(json['датаНачала']);
    endDate = DateTime.parse(json['датаОкончания']);
    end = json['конец'];
    dayWeekNum = json['деньНедели'];
    dayWeekStr = json['день_недели'];
    mail = json['почта'];
    day = json['день'];
    semesterCode = json['код_Семестра'];
    typeWeek = json['типНедели'];
    subgroupNumber = json['номерПодгруппы'];
    discipline = json['дисциплина'];
    teacher = json['преподаватель'];
    audience = json['аудитория'];
    academicYear = json['учебныйГод'];
    group = json['группа'];
    custom1 = json['custom1'];
    hours = json['часы'];
    startWeek = json['неделяНачала'];
    endWeek = json['неделяОкончания'];
    replacement = json['замена'];
    teacherCode = json['кодПреподавателя'];
    groupCode = json['кодГруппы'];
    teacherFullName = json['фиоПреподавателя'];
    scheduleCycleElement = json['элементЦиклРасписания'];
    subject = json['тема'];
    employmentNumbers = json['номерЗанятия'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['код'] = code;
    data['дата'] = date;
    data['начало'] = start;
    data['датаНачала'] = startDate;
    data['датаОкончания'] = endDate;
    data['конец'] = end;
    data['деньНедели'] = dayWeekNum;
    data['день_недели'] = dayWeekStr;
    data['почта'] = mail;
    data['день'] = day;
    data['код_Семестра'] = semesterCode;
    data['типНедели'] = typeWeek;
    data['номерПодгруппы'] = subgroupNumber;
    data['дисциплина'] = discipline;
    data['преподаватель'] = teacher;
    data['аудитория'] = audience;
    data['учебныйГод'] = academicYear;
    data['группа'] = group;
    data['custom1'] = custom1;
    data['часы'] = hours;
    data['неделяНачала'] = startWeek;
    data['неделяОкончания'] = endWeek;
    data['замена'] = replacement;
    data['кодПреподавателя'] = teacherCode;
    data['кодГруппы'] = groupCode;
    data['фиоПреподавателя'] = teacherFullName;
    data['элементЦиклРасписания'] = scheduleCycleElement;
    data['тема'] = subject;
    data['номерЗанятия'] = employmentNumbers;
    return data;
  }
}

class Schedule {
  Data? data;
  int? state;
  String? msg;

  Schedule({this.data, this.state, this.msg});

  Schedule.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data?.fromJson(json['data']) : null;
    state = json['state'];
    msg = json['msg'];
  }

  // Map<String, dynamic> toJson() {
  //     final Map<String, dynamic> data = <String, dynamic>{};
  //     data['data'] = dataT!.toJson();
  //     data['state'] = state;
  //     data['msg'] = msg;
  //     return data;
  // }
}
