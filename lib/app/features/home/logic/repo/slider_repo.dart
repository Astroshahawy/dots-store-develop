// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:dartz/dartz.dart';
import 'package:geeks_service/geeks_service.dart';

import '../../../../../core/network/api_urls.dart';
import '../../../../../core/network/network_service.dart';
import '../model/slider_model.dart';

abstract class SliderHomeRepo {
  Future<Either<Failure, Either<SliderHomeNoCashbackM, SliderHomeModel>>> get();
}

class SliderHomeImpl extends SliderHomeRepo {
  SliderHomeImpl(this.network);
  final NetworkService network;

  @override
  Future<Either<Failure, Either<SliderHomeNoCashbackM, SliderHomeModel>>> get() async {
    try {
      final response = await network.get(ApiUrls.sliderHome, hasToken: true);

      if (response.data.toString().contains('no cashback')) {
        return Right(
          Left(SliderHomeNoCashbackM.fromJson(response.data)),
        );
      } else {
        return Right(
          Right(SliderHomeModel.fromJson(response.data)),
        );
      }
    } on DioError catch (e) {
      return Left(Failure.fromCode(e));
    }
  }
}
