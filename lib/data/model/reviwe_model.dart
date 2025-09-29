import 'package:equatable/equatable.dart';

class ReviewModel extends Equatable {
  final int reviewId;
  final int carId;
  final int userId;
  final int stars;
  final String review;
  final DateTime createdAt;

  // Extra info from joins
  final String? userFullName;
  final String? carBrand;
  final String? carModel;

  ReviewModel({
    required this.reviewId,
    required this.carId,
    required this.userId,
    required this.stars,
    required this.review,
    required this.createdAt,
    this.userFullName,
    this.carBrand,
    this.carModel,
  });

  // Factory to create from JSON
  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      reviewId: json['reviewId'] as int,
      carId: json['carId'] as int,
      userId: json['userId'] as int,
      stars: json['stars'] as int,
      review: json['review'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
      userFullName: json['userFullName'],
      carBrand: json['carBrand'],
      carModel: json['carModel'],
    );
  }

  // Convert to JSON (useful for sending new reviews to API)
  Map<String, dynamic> toJson() {
    return {
      'reviewId': reviewId,
      'carId': carId,
      'userId': userId,
      'stars': stars,
      'review': review,
      'createdAt': createdAt.toIso8601String(),
      'userFullName': userFullName,
      'carBrand': carBrand,
      'carModel': carModel,
    };
  }

  @override
  List<Object?> get props => [
    reviewId,
    carId,
    userId,
    stars,
    review,
    createdAt,
    userFullName,
    carBrand,
    carModel,
  ];
}
