import 'package:plan_your_live/shared/utils/utils.dart';

class TodoModel {
  final String id;
  String title;
  String? description;
  DateTime? doDate;
  bool isChecked;
  final DateTime? createdAt;

  TodoModel({
    String? id,
    required this.title,
    this.description,
    this.doDate,
    required this.isChecked,
    this.createdAt
  }) : id = id ?? Utils.getUuid();

  factory TodoModel.fromMap(Map<String, dynamic> todo) => TodoModel(
    id: todo['id'] as String,
    title: todo['title'] as String,
    description: todo['description'] ?? '',
    doDate: DateTime.tryParse(todo['doDate'] ?? ''),
    isChecked: todo['isChecked'] == 1,
    createdAt: DateTime.tryParse(todo['createdAt'] as String),
  );

  Map<String, Object?> toMap(String todolistId) {
    Map<String, Object?> map = <String, Object?>{};
    map['id'] = id;
    map['title'] = title;
    if (description != null) map['description'] = description;
    if (doDate != null) map['doDate'] = doDate?.toIso8601String();
    map['isChecked'] = isChecked ? 1 : 0;
    if (createdAt != null) map['createdAt'] = createdAt?.toIso8601String();
    map['todolistId'] = todolistId;

    return map;
  }

}
