import 'dart:math';

class RandomData {
  static const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  final Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(
        Iterable.generate(
          length,
          (_) => _chars.codeUnitAt(
            _rnd.nextInt(_chars.length),
          ),
        ),
      );

  List<int> getRandomIntList(int length) {
    List<int> res = [];
    for (int i = 0; i < length; ++i) {
      res.add(_rnd.nextInt(256));
    }
    return res;
  }
}
