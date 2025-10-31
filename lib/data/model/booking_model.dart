import 'package:equatable/equatable.dart';

class BookingModel extends Equatable {
  final int? id;
  final String? startDate;
  final String? endDate;
  final double? totalPrice;
  final Enum? status;
  final int? userId;
  final int? carId;

  const BookingModel({
    this.id,
    this.startDate,
    this.endDate,
    this.totalPrice,
    this.status,
    this.userId,
    this.carId,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['bookingID'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      totalPrice: json['totalPrice'] is int
          ? (json['totalPrice'] as int).toDouble()
          : json['totalPrice'] as double?,
      status: json['status'],
      userId: json['userID'],
      carId: json['carID'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bookingID'] = id;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['totalPrice'] = totalPrice;
    data['status'] = status;
    data['userID'] = userId;
    data['carID'] = carId;
    return data;
  }

  @override
  List<Object?> get props => [
    id,
    startDate,
    endDate,
    totalPrice,
    status,
    userId,
    carId,
  ];
}
