import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'static_pages_m_res.g.dart';

@JsonSerializable(createToJson: false)
class StaticPagesMRes extends Equatable {
  const StaticPagesMRes({
    this.success,
    this.status,
    this.message,
    this.data = const [],
  });

  final bool? success;
  final int? status;
  final String? message;
  final List<StaticPagesM> data;

  factory StaticPagesMRes.fromJson(Map<String, dynamic> json) =>
      _$StaticPagesMResFromJson(json);

  @override
  List<Object?> get props => [success, status, message, data];
}

@JsonSerializable(createToJson: false)
class StaticPagesM extends Equatable {
  const StaticPagesM({
    this.id,
    this.title,
    this.description,
  });

  final int? id;
  final String? title;
  final String? description;

  factory StaticPagesM.fromJson(Map<String, dynamic> json) =>
      _$StaticPagesMFromJson(json);

  @override
  List<Object?> get props => [id, title, description];
}
