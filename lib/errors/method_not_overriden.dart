class MethodGetIdNotOverriddenError extends Error {
  String _reason;

  MethodGetIdNotOverriddenError() {
    _reason = "Method GetId should be overriden and not called with super.";
  }

  String getReason() {
    return _reason;
  }
}
