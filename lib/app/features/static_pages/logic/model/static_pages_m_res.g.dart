// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'static_pages_m_res.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StaticPagesMRes _$StaticPagesMResFromJson(Map<String, dynamic> json) =>
    StaticPagesMRes(
      success: json['success'] as bool?,
      status: json['status'] as int?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => StaticPagesM.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

StaticPagesM _$StaticPagesMFromJson(Map<String, dynamic> json) => StaticPagesM(
      id: json['id'] as int?,
      title: json['title'] as String?,
      description: json['description'] as String?,
    );
