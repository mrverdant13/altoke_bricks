bool doesNotThrow(void Function() f) {
  try {
    f();
    return true;
  } on Object {
    return false;
  }
}
