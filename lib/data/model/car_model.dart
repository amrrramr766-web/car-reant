import 'package:equatable/equatable.dart';

class CarModel extends Equatable {
  final int carId;
  final String brand;
  final String model;
  final String year;
  final double pricePerDay;
  final bool isAvailable;
  final String imageUrl;
  final String plateNumber;
  final String gas;
  final String gear;
  final int seat;

  CarModel({
    required this.carId,
    required this.brand,
    required this.model,
    required this.year,
    required this.pricePerDay,
    required this.isAvailable,
    required this.imageUrl,
    required this.plateNumber,
    required this.gas,
    required this.gear,
    required this.seat,
  });

  factory CarModel.fromJson(Map<String, dynamic> json) {
    return CarModel(
      carId: json['carID'],
      brand: json['brand'],
      model: json['model'],
      year: json['year'],
      pricePerDay: (json['pricePerDay'] as num).toDouble(),
      isAvailable: json['isAvailable'] as bool,
      imageUrl: json['imageUrl'],
      plateNumber: json['plateNumber'],
      gas: json['gas'],
      gear: json['gear'],
      seat: json['seat'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'CarID': carId,
      'Brand': brand,
      'Model': model,
      'Year': year,
      'PricePerDay': pricePerDay,
      'IsAvailable': isAvailable ? 1 : 0,
      'ImageURL': imageUrl,
      'PlateNumber': plateNumber,
      'Gas': gas,
      'Gear': gear,
      'Seat': seat,
    };
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
    carId,
    brand,
    model,
    year,
    pricePerDay,
    isAvailable ? 1 : 0,
    plateNumber,
    gas,
    gear,
    seat,
  ];
}
