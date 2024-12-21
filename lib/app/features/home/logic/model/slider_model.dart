import 'package:equatable/equatable.dart';
import '../../../../../core/utils/response_model.dart';

class SliderHomeModel extends ResponseModel {
  const SliderHomeModel({
    this.data,
    super.message,
    super.success,
    super.status,
  });
  final SliderHomeDateM? data;

  factory SliderHomeModel.fromJson(Map<String, dynamic> json) =>
      SliderHomeModel(
        success: json['success'] as bool,
        status: json['status'] as int,
        message: json['message'] as String,
        data: json['data'] == null
            ? null
            : SliderHomeDateM.fromJson(json['data']),
      );
}

class SliderHomeDateM extends Equatable {
  const SliderHomeDateM({
    this.dateM,
    this.usagePercentage,
    this.description,
    this.remainCustomersNumber,
    this.rating,
  });
  final String? usagePercentage;
  final String? description;
  final String? remainCustomersNumber;
  final SliderHomePromotionalDateM? dateM;
  final double? rating;

  @override
  List<Object?> get props =>
      [usagePercentage, description, remainCustomersNumber, dateM, rating];

  factory SliderHomeDateM.fromJson(Map<String, dynamic> json) =>
      SliderHomeDateM(
        usagePercentage: '${json['usage_percentage']}',
        description: json['description'] ?? '',
        remainCustomersNumber: '${json['remain_customers_number']}',
        rating: json['rating'] ?? 0.0,
        dateM:
            SliderHomePromotionalDateM.fromJson(json['promotional_meal'] ?? {}),
      );
}

class SliderHomePromotionalDateM extends Equatable {
  const SliderHomePromotionalDateM({
    this.mealCount,
    this.mealName,
    this.usagePercentage,
    this.remainCustomersNumber,
  });
  final String? mealName;
  final int? mealCount;
  final double? usagePercentage;
  final String? remainCustomersNumber;

  @override
  List<Object?> get props => [
        mealCount,
        mealName,
        usagePercentage,
        remainCustomersNumber,
      ];

  factory SliderHomePromotionalDateM.fromJson(Map<String, dynamic> json) =>
      SliderHomePromotionalDateM(
        mealCount: json['meal_count'] ?? 0,
        mealName: '${json['meal_name']}',
        usagePercentage: (json['usage_percentage']?? 0).toDouble() ,
        remainCustomersNumber: '${json['remain_customers_number']}',
      );
}

class SliderHomeNoCashbackM extends ResponseModel {
  const SliderHomeNoCashbackM({
    this.data,
    super.message,
    super.success,
    super.status,
  });
  final String? data;

  factory SliderHomeNoCashbackM.fromJson(Map<String, dynamic> json) =>
      SliderHomeNoCashbackM(
        success: json['success'] as bool,
        status: json['status'] as int,
        message: json['message'] as String,
        data: json['data'] ?? '',
      );
}
