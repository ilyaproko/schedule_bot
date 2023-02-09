import 'package:schedule_sibadi/handlers/group.handler.dart';
import 'package:schedule_sibadi/requests/schedule.req.dart';
import 'package:schedule_sibadi/types/group.response.dart';
import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';
import 'package:teledart/telegram.dart';
import 'package:schedule_sibadi/guards/group.guard.dart' show groupGuard;
import 'dart:io' as io;
import 'package:path/path.dart';

void main(List<String> arguments) async {
  const BOT_TOKEN = "";
  final user = (await Telegram(BOT_TOKEN).getMe());
  var teledart = TeleDart(BOT_TOKEN, Event(user.username!));
  var projectDir = io.Directory.current;
  var stickersDir = join(projectDir.path, "stickers");

  var scheduleReq = ScheduleReq(
      url: "umu.sibadi.org",
      yearCompany: "2022-2023",
      pathGroupList: "api/raspGrouplist",
      pathScheGroup: "api/Rasp");

  teledart.onCommand("start").listen((message) async {
    await message.replySticker(io.File(join(stickersDir, "greet.webp")));
    message.reply(
        "Привет <b>${message.from?.firstName}</b>! Чтобы получить расписание на неделю напиши боту свою группу.\n<b>Пример:</b> <i>группа АДб-19С1</i>",
        parseMode: "html");
  });

  teledart.onCommand("groups").listen((event) async {
    var groups = (await scheduleReq.getGroups())!.data as List<GroupInfo>;

    String answerText =
        "${groups.map((e) => e.name).toList().join('\n')}\n<i><b>Всего: ${groups.length}</b></i>";

    await event.reply(answerText, parseMode: "HTML");
  });

  teledart.onMessage().where(groupGuard).listen(
      await groupHandler(scheduleReq: scheduleReq, stickersDir: stickersDir));

  teledart.setMyCommands([
    BotCommand(command: "start", description: "запуск бота"),
    BotCommand(command: "groups", description: "получить список всех групп"),
  ]);

  teledart.start();
  print("bot is running!");
}
