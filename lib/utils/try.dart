import 'console.dart';

class Try {
  static _onSyncException(String exception, Function? onException,
      bool returnException, bool showInternalException) {
    if (showInternalException) Console.error(exception);

    final result = onException?.call();

    return returnException ? exception : result;
  }

  static syncCall(Function function,
      {Function? onException,
      bool returnException = false,
      bool showInternalException = true}) {
    try {
      return function();
    } catch (exception) {
      return _onSyncException(exception.toString(), onException,
          returnException, showInternalException);
    }
  }

  static _onAsyncException(String exception, Function? onException,
      bool returnException, bool showInternalException) async {
    if (showInternalException) Console.error(exception);

    final result = await onException?.call();

    return returnException ? exception : result;
  }

  static Future asyncCall(Function function,
      {Function? onException,
      bool returnException = false,
      bool showInternalException = true}) async {
    try {
      return await function();
    } catch (exception) {
      return await _onAsyncException(exception.toString(), onException,
          returnException, showInternalException);
    }
  }
}
