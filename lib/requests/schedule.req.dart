import 'dart:convert';
import "package:http/http.dart" as http;
import 'package:schedule_sibadi/types/schedule.response.dart';
import '../types/group.response.dart';
import '../types/schedule.response.dart';

class ScheduleReq {
  late final String url;
  late final String yearCompany;
  final String pathGroupList;
  final String pathScheGroup;

  ScheduleReq(
      {required this.url,
      required this.yearCompany,
      required this.pathGroupList,
      required this.pathScheGroup});

  Future<Groups?> getGroups() async {
    var uriGroups = Uri.https(url, pathGroupList, {"year": yearCompany});
    var response = await http.get(uriGroups);

    if (response.statusCode == 200) {
      var groups = Groups.fromJson(jsonDecode(response.body));
      return groups;
    }
    
    return null;
  }

  Future<Schedule?> getScheduleGroup({required int idGroup}) async {
    var currDate = DateTime.now(); // 2023-02-08

    var month = currDate.month.toString().length == 1
        ? "0${currDate.month}"
        : currDate.month.toString();

    var day = currDate.day.toString().length == 1
        ? "0${currDate.day}"
        : currDate.day.toString();

    var uriScheduleGroup = Uri.https(url, pathScheGroup, {
      "idGroup": idGroup.toString(),
      "sdate": "${currDate.year}-$month-$day"
    });

    var response = await http.get(uriScheduleGroup);

    if (response.statusCode == 200) {
      var schedule = Schedule.fromJson(jsonDecode(response.body));
      return schedule;
    }

    return null;
  }

  /// Если группа есть вернет объект GroupInfo.
  /// Если не найдет группу тогда null. Самым важным в возвращаемом
  /// объекте будет аттрибут id данной группы, в основном будет использован
  /// именно id для запросов к api
  Future<GroupInfo?> findGroup({required String name}) async {
    var schedule = await getGroups();
    GroupInfo? wantedGroup;

    if (schedule != null && schedule.data != null) {
      for (var group in (schedule.data as List<GroupInfo>)) {
        if (name.toLowerCase().trim() == group.name!.toLowerCase()) {
          wantedGroup = group;
          break;
        }
      }
    }

    return wantedGroup;
  }
}
