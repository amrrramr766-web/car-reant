import 'package:equatable/equatable.dart';

class BookingModel extends Equatable {
  int? id;
  String? startDate;
  String? endDate;
  double? totalPrice;
  Enum? status;
  int? userId;
  int? carId;

  BookingModel({
    this.id,
    this.startDate,
    this.endDate,
    this.totalPrice,
    this.status,
    this.userId,
    this.carId,
  });

  BookingModel.fromJson(Map<String, dynamic> json) {
    id = json['bookingID'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    totalPrice = json['totalPrice'];
    status = json['status'];
    userId = json['userID'];
    carId = json['carID'];
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
