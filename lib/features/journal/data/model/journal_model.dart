// import 'package:flutter/material.dart';
// import 'package:trading_journal/features/journal/domin/entity/journal_entity.dart';

// class JournalModel extends JournalEntity {
//   const JournalModel({
//     String? id,
//     String? title,
//     String? imageUrl,
//     String? description,
//     String? risk,
//     String? xTrade,
//     Status? status,
//     Direction? direction,
//     DateTime? dateTime,
//     double? winLoseRate,
//     Color? color,
//   }) : super(
//           id: id,
//           title: title,
//           imageUrl: imageUrl,
//           description: description,
//           risk: risk,
//           xTrade: xTrade,
//           status: status,
//           direction: direction,
//           dateTime: dateTime,
//           winLoseRate: winLoseRate,
//           color: color,
//         );

//   factory JournalModel.fromJson(Map<String, dynamic> json) {
//     return JournalModel(
//       id: json['id'],
//       title: json['title'],
//       imageUrl: json['image_url'],
//       description: json['description'],
//       risk: json['risk'],
//       xTrade: json['xTrade'],
//       status: json['status'],
//       direction: json['direction'],
//       dateTime: json['date_time'],
//       winLoseRate: json['win_lose_rate'],
//       color: json['color'],
//     );
//   }
// }
