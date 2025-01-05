import 'package:uuid/uuid.dart';

class TodoModel {
  final Uuid id;
  final String title;
  final String? description;
  final DateTime? doDate;
  final bool isChecked;
  final DateTime? createdAt;

  const TodoModel({
    Uuid? id,
    required this.title,
    this.description,
    this.doDate,
    required this.isChecked,
    this.createdAt
  }) : id = id ?? const Uuid();

  Map<String, Object?> toMap() {
    Map<String, Object?> map = <String, Object?>{};
    map['id'] = id.v4();
    map['title'] = title;
    if (description != null) map['description'] = description;
    if (doDate != null) map['doDate'] = doDate;
    map['isChecked'] = isChecked;
    if (createdAt != null) map['createdAt'] = createdAt;

    return map;
  }

}
