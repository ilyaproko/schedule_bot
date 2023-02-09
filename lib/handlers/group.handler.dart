import 'package:schedule_sibadi/requests/schedule.req.dart';
import 'package:schedule_sibadi/types/group.response.dart';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:teledart/model.dart';

Future<Function(TeleDartMessage)> groupHandler(
    {required ScheduleReq scheduleReq, required String stickersDir}) async {
  return (TeleDartMessage event) async {
    var message = event.text!;
    var nameGroup = message.split(" ")[1];

    GroupInfo? group = await scheduleReq.findGroup(name: nameGroup);

    if (group != null) {
      var idGroup = group.id;
      var scheduleGroup = await scheduleReq.getScheduleGroup(idGroup: idGroup);

      if (scheduleGroup!.data!.rasp!.isNotEmpty) {
        var scheduleWeek = <String, List<String>>{};

        for (var schedule in scheduleGroup.data!.rasp!) {
          if (!scheduleWeek.keys.contains(
              "<b>${schedule!.dayWeekStr}</b> ${schedule.date.year}/${schedule.date.month}/${schedule.date.day}")) {
            scheduleWeek[
                "<b>${schedule.dayWeekStr}</b> ${schedule.date.year}/${schedule.date.month}/${schedule.date.day}"] = [
              "${schedule.start.replaceAll("-", ":")}/${schedule.end.replaceAll("-", ":")} аудитория: ${schedule.audience}\n${schedule.discipline}, ${schedule.teacher}"
            ];
          } else {
            scheduleWeek[
                    "<b>${schedule.dayWeekStr}</b> ${schedule.date.year}/${schedule.date.month}/${schedule.date.day}"]
                ?.add(
                    "${schedule.start.replaceAll("-", ":")}/${schedule.end.replaceAll("-", ":")} аудитория: ${schedule.audience}\n${schedule.discipline}, ${schedule.teacher}");
          }
        }

        for (var day in [
          "понедельник",
          "вторник",
          "среда",
          "четверг",
          "пятница",
          "суббота",
          "воскресенье"
        ]) {
          for (var key in scheduleWeek.keys) {
            if (key.toLowerCase().contains(day)) {
              await event.reply("$key\n\n${scheduleWeek[key]?.join("\n\n")}",
                  parseMode: "html");
            }
          }
        }
      } else {
        event.reply("расписания на неделю отсутствует");
      }
    } else {
      event.reply("Группа $nameGroup не найдена");
      event.replySticker(io.File(join(stickersDir, "filin.webp")));
    }
  };
}
