class CommandNotFoundException implements Exception {
  final String _command;
  CommandNotFoundException(this._command);
  String getMessage() {
    return 'Command $_command was not found, please make sure it is correctly installed.';
  }
}
