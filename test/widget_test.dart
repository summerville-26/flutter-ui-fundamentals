import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Identitas mahasiswa pada Course Explorer', () {
    const String studentName = 'I Komang Candra Aryadinata';
    const String studentId = '2415051085';

    expect(studentName, isNotEmpty);
    expect(studentId, isNotEmpty);
  });
}
