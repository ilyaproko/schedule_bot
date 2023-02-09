/* 
// Example Usage
Map<String, dynamic> map = jsonDecode(<myJSONString>);
var myRootNode = Root.fromJson(map);
*/
class GroupInfo {
  String? name;
  late final int id;
  int? kurs;
  String? facul;
  String? yearName;
  int? facultyID;

  GroupInfo(
      {this.name,
      required this.id,
      this.kurs,
      this.facul,
      this.yearName,
      this.facultyID});

  GroupInfo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    kurs = json['kurs'];
    facul = json['facul'];
    yearName = json['yearName'];
    facultyID = json['facultyID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['id'] = id;
    data['kurs'] = kurs;
    data['facul'] = facul;
    data['yearName'] = yearName;
    data['facultyID'] = facultyID;
    return data;
  }
}

class Groups {
  List<GroupInfo?>? data;
  int? state;
  String? msg;

  Groups({this.data, this.state, this.msg});

  Groups.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <GroupInfo>[];
      json['data'].forEach((v) {
        data!.add(GroupInfo.fromJson(v));
      });
    }
    state = json['state'];
    msg = json['msg'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = Map<String, dynamic>();
  //   data['data'] = data != null ? data!.map((v) => v?.toJson()).toList() : null;
  //   data['state'] = state;
  //   data['msg'] = msg;
  //   return data;
  // }
}
