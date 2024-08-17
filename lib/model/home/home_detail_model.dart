import 'package:json_annotation/json_annotation.dart';

part 'home_detail_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class HomeDetailModel {
  String fullName;
  String? description;
  int stargazersCount;
  String? language;

  HomeDetailModel(
    this.fullName,
    this.description,
    this.stargazersCount,
    this.language,
  );

  factory HomeDetailModel.fromJson(Map<String, dynamic> json) {
    return _$HomeDetailModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$HomeDetailModelToJson(this);
}
