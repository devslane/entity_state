class MethodNotOverridenError extends Error {
  String _reason;

  MethodNotOverridenError() {
    _reason = "Method should be overriden and not called with super.";
  }

  String getReason() {
    return _reason;
  }
}
