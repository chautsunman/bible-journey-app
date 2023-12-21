enum RecordState {
  READ,
  ADD,
  EDIT,
}

abstract class ValidObj {
  bool isValid();

  bool isInvalid() {
    return !isValid();
  }
}
