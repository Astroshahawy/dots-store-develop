import 'package:equatable/equatable.dart';

class PaymentMethods extends Equatable {
  final String name;
  final String image;
  const PaymentMethods({required this.name, required this.image});

  @override
  List<Object?> get props => [name, image];
}
