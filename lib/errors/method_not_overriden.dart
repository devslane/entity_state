class MethodGetIdNotOverridenError extends Error {
  String _reason;

  MethodGetIdNotOverridenError() {
    _reason = "Method GetId should be overriden and not called with super.";
  }

  String getReason() {
    return _reason;
  }
}
