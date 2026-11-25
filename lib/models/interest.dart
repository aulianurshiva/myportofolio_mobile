import 'package:json_annotation/json_annotation.dart';

part 'interest.g.dart';

/// Interest portofolio yang disinkronkan dengan Django REST Framework API.
@JsonSerializable(fieldRename: FieldRename.snake)
class Interest {
  const Interest({
    this.id,
    required this.name,
    required this.category,
    this.description = '',
    this.starCount = 0,
  });

  factory Interest.fromJson(Map<String, dynamic> json) =>
      _$InterestFromJson(json);

  /// Dibuat oleh server, jadi tidak ikut dikirim saat POST.
  @JsonKey(includeToJson: false)
  final int? id;

  final String name;

  /// Nilai di model Django: `exploring` atau `fun`.
  final String category;

  @JsonKey(defaultValue: '')
  final String description;

  /// Dihitung server, hanya dibaca.
  @JsonKey(includeToJson: false, defaultValue: 0)
  final int starCount;

  String get categoryLabel =>
      category == 'fun' ? 'For Fun' : 'Currently Exploring';

  Map<String, dynamic> toJson() => _$InterestToJson(this);
}
