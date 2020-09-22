class StringIdGenerator {

  var _chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  var _nextId = [0];

  next() {
    print('entrou');
    var r = [];
    for (var char in this._nextId) {
      r.insert(0, this._chars[char]);
    }
    this._increment();
    return r.join('');
  }

  _increment() {
    for (var i = 0; i < this._nextId.length; i++) {
      var val = this._nextId[i] + 1;
      if (val >= this._chars.length) {
        this._nextId[i] = 0;
      } else {
        return;
      }
    }
    this._nextId.add(0);
  }

}