class BackgroundColor {
  static const String BLACK = "\x1B[40m";
  static const String RED = "\x1B[41m";
  static const String GREEN = "\x1B[42m";
  static const String YELLOW = "\x1B[43m";
  static const String BLUE = "\x1B[44m";
  static const String PURPLE = "\x1B[45m";
  static const String CYAN = "\x1B[46m";
  static const String WHITE = "\x1B[47m";

  static const String BRIGHT_BLACK = "\x1B[40;1m";
  static const String BRIGHT_RED = "\x1B[41;1m";
  static const String BRIGHT_GREEN = "\x1B[42;1m";
  static const String BRIGHT_YELLOW = "\x1B[43;1m";
  static const String BRIGHT_BLUE = "\x1B[44;1m";
  static const String BRIGHT_PURPLE = "\x1B[45;1m";
  static const String BRIGHT_CYAN = "\x1B[46;1m";
  static const String BRIGHT_WHITE = "\x1B[47;1m";
}

class FrontColor {
  static const String BLACK = "\x1B[30m";
  static const String RED = "\x1B[31m";
  static const String GREEN = "\x1B[32m";
  static const String YELLOW = "\x1B[33m";
  static const String BLUE = "\x1B[34m";
  static const String PURPLE = "\x1B[35m";
  static const String CYAN = "\x1B[36m";
  static const String WHITE = "\x1B[37m";

  static const String BRIGHT_BLACK = "\x1B[30;1m";
  static const String BRIGHT_RED = "\x1B[31;1m";
  static const String BRIGHT_GREEN = "\x1B[32;1m";
  static const String BRIGHT_YELLOW = "\x1B[33;1m";
  static const String BRIGHT_BLUE = "\x1B[34;1m";
  static const String BRIGHT_PURPLE = "\x1B[35;1m";
  static const String BRIGHT_CYAN = "\x1B[36;1m";
  static const String BRIGHT_WHITE = "\x1B[37;1m";
}

class Console {
  static const String _RESET = "\x1B[0m";

  static void info(String message) => print("[info] $message");

  static void success(String message) =>
      print("${FrontColor.BRIGHT_GREEN}[success] $message$_RESET");

  static void warning(String message) =>
      print("${FrontColor.BRIGHT_YELLOW}[warning] $message$_RESET");

  static void error(String message) =>
      print("${FrontColor.BRIGHT_RED}[error] $message$_RESET");

  static void custom(String message,
          {String? backgroundColor, String? frontColor}) =>
      print(
          "${backgroundColor ?? _RESET}${frontColor ?? _RESET}[custom] $message$_RESET");
}
