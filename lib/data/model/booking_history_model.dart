import 'package:equatable/equatable.dart';

class BookingHistoryModel extends Equatable {
  final int? bookingID;
  final int? userID;
  final int? carID;
  final int? totalPrice;
  final String? status;
  final String? startDate;
  final String? endDate;
  final String? createdAt;
  final String? fullName;
  final String? brand;
  final String? model;
  final String? year;

  const BookingHistoryModel({
    this.bookingID,
    this.userID,
    this.carID,
    this.totalPrice,
    this.status,
    this.startDate,
    this.endDate,
    this.createdAt,
    this.fullName,
    this.brand,
    this.model,
    this.year,
  });

  factory BookingHistoryModel.fromJson(Map<String, dynamic> json) {
    return BookingHistoryModel(
      bookingID: json['bookingID'] as int?,
      userID: json['userID'] as int?,
      carID: json['carID'] as int?,
      totalPrice: json['totalPrice'] as int?,
      status: json['status'] as String?,
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
      createdAt: json['createdAt'] as String?,
      fullName: json['fullName'] as String?,
      brand: json['brand'] as String?,
      model: json['model'] as String?,
      year: json['year'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['bookingID'] = bookingID;
    data['userID'] = userID;
    data['carID'] = carID;
    data['totalPrice'] = totalPrice;
    data['status'] = status;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['createdAt'] = createdAt;
    data['fullName'] = fullName;
    data['brand'] = brand;
    data['model'] = model;
    data['year'] = year;
    return data;
  }

  @override
  List<Object?> get props => [
    bookingID,
    userID,
    carID,
    totalPrice,
    status,
    startDate,
    endDate,
    createdAt,
    fullName,
    brand,
    model,
    year,
  ];
}
