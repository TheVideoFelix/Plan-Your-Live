import 'package:plan_your_live/shared/utils/utils.dart';

class TodoModel {
  final String id;
  final String title;
  final String? description;
  final DateTime? doDate;
  final bool isChecked;
  final DateTime? createdAt;

  TodoModel({
    String? id,
    required this.title,
    this.description,
    this.doDate,
    required this.isChecked,
    this.createdAt
  }) : id = id ?? Utils.getUuid();

  Map<String, Object?> toMap(String todolistId) {
    Map<String, Object?> map = <String, Object?>{};
    map['id'] = id;
    map['title'] = title;
    if (description != null) map['description'] = description;
    if (doDate != null) map['doDate'] = doDate;
    map['isChecked'] = isChecked ? 1 : 0;
    if (createdAt != null) map['createdAt'] = createdAt;
    map['todolistId'] = todolistId;

    return map;
  }

}
