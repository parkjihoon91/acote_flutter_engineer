
import 'package:json_annotation/json_annotation.dart';

part 'home_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class HomeModel {
  String login;
  String avatarUrl;

  HomeModel(this.login, this.avatarUrl);
  
  factory HomeModel.fromJson(Map<String, dynamic> json) {
      return _$HomeModelFromJson(json);
    }
  
  Map<String, dynamic> toJson() => _$HomeModelToJson(this);
}