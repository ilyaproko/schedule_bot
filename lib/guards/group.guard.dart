
bool groupGuard(event) {
    var message = event.text;
    if (message != null &&
        message.split(" ").length >= 2 &&
        message.toLowerCase().trim().startsWith("группа")) return true;
    return false;
}