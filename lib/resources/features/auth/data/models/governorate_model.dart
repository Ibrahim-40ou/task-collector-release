import 'package:tasks_collector/resources/features/auth/domain/entities/governorate_entity.dart';

class GovernorateModel extends GovernorateEntity {
  GovernorateModel({
    required super.name,
    required super.id,
  });

  factory GovernorateModel.fromJson(Map<String, dynamic> json) {
    return GovernorateModel(
      name: json['name'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'id': id,
    };
  }
}
