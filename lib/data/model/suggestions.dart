class SuggestionsModel {
  final int? id;
  final String? title;
  final int? carId;
  final String? category;
  final bool? isActive;
  final String? createdAt;
  final String? carName;

  SuggestionsModel({
    this.id,
    this.title,
    this.carId,
    this.category,
    this.isActive,
    this.createdAt,
    this.carName,
  });

  factory SuggestionsModel.fromJson(Map<String, dynamic> json) {
    return SuggestionsModel(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id'].toString()),
      title: json['title'] as String?,
      carId: json['carId'] is int
          ? json['carId']
          : int.tryParse(json['carId']?.toString() ?? ''),
      category: json['category'] as String?,
      isActive: json['isActive'] as bool?,
      createdAt: json['createdAt'] as String?,
      carName: json['carName'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'carId': carId,
      'category': category,
      'isActive': isActive,
      'createdAt': createdAt,
      'carName': carName,
    };
  }
}
