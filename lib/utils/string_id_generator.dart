
class StringIdGenerator {

  var _chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

  next(i) {
    return _chars[i];
  }
}