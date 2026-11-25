import 'package:flutter_test/flutter_test.dart';
import 'package:myportofolio_mobile/models/interest.dart';

void main() {
  test('Interest.fromJson memetakan field snake_case dan default', () {
    final interest = Interest.fromJson({
      'id': 1,
      'name': 'Gaming',
      'category': 'fun',
      'star_count': 3,
    });

    expect(interest.id, 1);
    expect(interest.name, 'Gaming');
    expect(interest.description, '');
    expect(interest.starCount, 3);
    expect(interest.categoryLabel, 'For Fun');
  });

  test('Interest.toJson tidak mengirim id dan star_count', () {
    const interest = Interest(
      id: 1,
      name: 'Gaming',
      category: 'fun',
      description: 'Main game',
      starCount: 3,
    );

    final json = interest.toJson();

    expect(json.containsKey('id'), isFalse);
    expect(json.containsKey('star_count'), isFalse);
    expect(json['name'], 'Gaming');
    expect(json['description'], 'Main game');
  });
}
