// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:geeks_service/geeks_service.dart';

import '../../../../../core/enum/time_data.dart';
import '../../../../../core/network/api_urls.dart';
import '../../../../../core/network/network_service.dart';
import '../model/offer_details_model.dart';
import '../model/offer_model.dart';

abstract class OffersRepo {
  Future<Either<Failure, OfferModel>> getOffers();
  Future<Either<Failure, OfferDetailsModel>> postOffersDate(OfferParams params);
}

class OffersRepoImpl extends OffersRepo {
  OffersRepoImpl(this.network);
  final NetworkService network;

  @override
  Future<Either<Failure, OfferModel>> getOffers() async {
    try {
      final response = await network.get(ApiUrls.offersList, hasToken: false);
      return Right(OfferModel.fromJson(response.data));
    } on DioError catch (e) {
      return Left(Failure.fromCode(e));
    }
  }

  @override
  Future<Either<Failure, OfferDetailsModel>> postOffersDate(
      OfferParams params) async {
    try {
      final response = await network.post(ApiUrls.cashbackRequest,
          hasToken: true, data: params.toJson());

      return Right(OfferDetailsModel.fromJson(response.data));
    } on DioError catch (e) {
      return Left(Failure.fromCode(e));
    }
  }
}

class OfferParams extends Equatable {
  final String? packageId;
  final int? tax;
  final String? percentage;
  final String? descriptionAr;
  final String? descriptionEn;
  final String? beneficiaries;
  final TimeDate? timing;
  final String? minimumPurchasePrice;
  final DotsPackage? dotsPackage;
  final String? date;
  final PaymentMethod? paymentMethod;

  const OfferParams({
    this.dotsPackage,
    this.tax,
    this.percentage,
    this.date,
    this.packageId,
    this.descriptionAr,
    this.descriptionEn,
    this.beneficiaries,
    this.timing,
    this.minimumPurchasePrice,
    this.paymentMethod,
    
  });
  Map<String, dynamic> toJson() => {
        'date': date,
        'package_id': packageId,
        'description_ar': "descriptionAr",
        'description_en': "descriptionEn",
        'beneficiaries': beneficiaries,
        'timing': timing?.id,
        'minimum_purchase_price': minimumPurchasePrice,
        'payment_method': paymentMethod?.id,
      };

  OfferParams copyWith({
    String? packageId,
    String? percentage,
    int? tax,
    String? descriptionAr,
    String? descriptionEn,
    String? beneficiaries,
    TimeDate? timing,
    String? minimumPurchasePrice,
    String? date,
    DotsPackage? offerData,
    PaymentMethod? paymentMethod,
  }) {
    return OfferParams(
      packageId: packageId ?? this.packageId,
      percentage: percentage ?? percentage,
      tax: tax ?? this.tax,
      descriptionAr: descriptionAr ?? this.descriptionAr,
      descriptionEn: descriptionEn ?? this.descriptionEn,
      beneficiaries: beneficiaries ?? this.beneficiaries,
      timing: timing ?? this.timing,
      minimumPurchasePrice: minimumPurchasePrice ?? this.minimumPurchasePrice,
      date: date ?? this.date,
      dotsPackage: offerData ?? dotsPackage,
      paymentMethod: paymentMethod ?? this.paymentMethod,
    );
  }

  @override
  List<Object?> get props => [
        packageId,
        descriptionAr,
        percentage,
        descriptionEn,
        beneficiaries,
        timing,
        minimumPurchasePrice,
        date,
        dotsPackage,
        packageId,
        tax,
        paymentMethod,
      ];
  bool isFillObject() {
    if (date == null &&
        beneficiaries == null &&
        minimumPurchasePrice == null &&
        packageId == null &&
        timing == null) {
      return false;
    } else {
      return true;
    }
  }
}
enum PaymentMethod{
  visa(1),
  sadad(2),
  byNinja(3);

  final int id ;
 const PaymentMethod(this.id);
}