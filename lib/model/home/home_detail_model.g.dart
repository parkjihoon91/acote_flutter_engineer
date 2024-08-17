// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeDetailModel _$HomeDetailModelFromJson(Map<String, dynamic> json) =>
    HomeDetailModel(
      json['full_name'] as String,
      json['description'] as String?,
      (json['stargazers_count'] as num).toInt(),
      json['language'] as String?,
    );

Map<String, dynamic> _$HomeDetailModelToJson(HomeDetailModel instance) =>
    <String, dynamic>{
      'full_name': instance.fullName,
      'description': instance.description,
      'stargazers_count': instance.stargazersCount,
      'language': instance.language,
    };
