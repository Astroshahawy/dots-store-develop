// import 'package:equatable/equatable.dart';
// import 'package:json_annotation/json_annotation.dart';

// part 'how_to_use_m_res.g.dart';

// @JsonSerializable(createToJson: false)
// class HowToUseMRes extends Equatable {
//   const HowToUseMRes({
//     this.success,
//     this.status,
//     this.message,
//     this.data = const [],
//   });

//   final bool? success;
//   final int? status;
//   final String? message;
//   final List<HowToUseM> data;

//   factory HowToUseMRes.fromJson(Map<String, dynamic> json) =>
//       _$HowToUseMResFromJson(json);

//   @override
//   List<Object?> get props => [success, status, message, data];
// }

// @JsonSerializable(createToJson: false)
// class HowToUseM extends Equatable {
//   const HowToUseM({
//     this.id,
//     this.title,
//     this.description,
//   });

//   final int? id;
//   final String? title;
//   final String? description;

//   factory HowToUseM.fromJson(Map<String, dynamic> json) =>
//       _$HowToUseMFromJson(json);

//   @override
//   List<Object?> get props => [id, title, description];
// }
