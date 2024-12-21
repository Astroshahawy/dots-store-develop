import 'package:json_annotation/json_annotation.dart';

import '../../../../../core/utils/response_model.dart';

part 'logout_m_res.g.dart';

@JsonSerializable(createToJson: false)
class LogoutMRes extends ResponseModel {
  const LogoutMRes({
    super.message,
    super.success,
    super.status,
  });

  factory LogoutMRes.fromJson(Map<String, dynamic> json) =>
      _$LogoutMResFromJson(json);
      
}
