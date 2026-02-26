import 'package:equatable/equatable.dart';

class CategoryEntity {
  final String id;
  final String name;
  final bool isSynced;
  final bool isDeleted;

  const CategoryEntity({
    required this.id,
    required this.name,
    this.isSynced = false,
    this.isDeleted = false,
  });
}