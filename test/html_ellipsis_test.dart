import 'package:html_ellipsis/html_ellipsis.dart';
import 'package:test/test.dart';

void main() {
  group('Truncate', () {
    test('Should truncate properly', () {
      List<List<dynamic>> testCases = [
        ['123', 4, '123'],
        ['123', 3, '123'],
        ['123', 2, '12'],
        ['123', 0, ''],
        ['ð©', 1, 'ð©'],
        ['ð©foo', 2, 'ð©f'],
        [span('foo'), 4, span('foo')],
        [span('foo'), 3, span('foo')],
        [span('foo'), 2, span('fo')],
        [span('foo'), 0, ''],
      ];
      for (List<dynamic> testCase in testCases) {
        expect(htmlEllipsis(testCase[0], testCase[1]), equals(testCase[2]));
      }
    });
    test('Should handle malformed HTML', () {
      expect(htmlEllipsis('<span>foo', 3), equals(span('foo')));
    });
    test('Should add a ellipsis at the end', () {
      expect(htmlEllipsis('123', 2, addEllipsis: true), equals('1&hellip;'));
      expect(htmlEllipsis('ð©foo', 2, addEllipsis: true), equals('ð©&hellip;'));
      expect(htmlEllipsis('<span>foo</span>', 2, addEllipsis: true),
          equals('<span>f&hellip;</span>'));
    });

    test('Should handle surrogate pairs', () {
      // the high surrogate of ð©
      expect(htmlEllipsis('\uD83D', 1), equals('\uD83D'));
      // ð©
      expect(htmlEllipsis('\uD83D\uDCA9', 1), equals('ð©'));
    });
  });
}

String span(String tag) {
  return '<span>$tag</span>';
}
