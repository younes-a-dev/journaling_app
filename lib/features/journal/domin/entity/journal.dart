import 'dart:typed_data';

import 'package:hive_flutter/hive_flutter.dart';

part 'journal.g.dart';

// enum Status { win, lose }

// enum Direction { long, short }

@HiveType(typeId: 1)
class Journal extends HiveObject {
  @HiveField(0)
  final String? title;
  @HiveField(1)
  final Uint8List? imageByte;
  @HiveField(2)
  final String? description;
  @HiveField(3)
  final String? risk;
  @HiveField(4)
  final String? status;
  @HiveField(5)
  final String? direction;
  @HiveField(6)
  final DateTime? selectedDateTime;
  @HiveField(7)
  final double? riskReward;
  @HiveField(8)
  final int? colorValue;
  @HiveField(9)
  final DateTime? date;

  Journal({
    this.title,
    this.imageByte,
    this.description,
    this.risk,
    this.status,
    this.direction,
    this.selectedDateTime,
    this.riskReward,
    this.colorValue,
    this.date,
  });
}
