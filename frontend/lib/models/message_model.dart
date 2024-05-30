// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:chat_ws/models/user_model.dart';

class MessageModel {
  final String? id;
  final UserModel receiverUser;
  final UserModel senderUser;
  final String? createdAt;
  final String? updatedAt;

  MessageModel({
    this.id,
    required this.receiverUser,
    required this.senderUser,
    this.createdAt,
    this.updatedAt,
  });

  MessageModel copyWith({
    String? id,
    UserModel? receiverUser,
    UserModel? senderUser,
    String? createdAt,
    String? updatedAt,
  }) {
    return MessageModel(
      id: id ?? this.id,
      receiverUser: receiverUser ?? this.receiverUser,
      senderUser: senderUser ?? this.senderUser,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'receiverUser': receiverUser.toMap(),
      'senderUser': senderUser.toMap(),
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      id: map['_id'] != null ? map['_id'] as String : null,
      receiverUser: UserModel.fromMap(map['receiverUser'] as Map<String,dynamic>),
      senderUser: UserModel.fromMap(map['senderUser'] as Map<String,dynamic>),
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
      updatedAt: map['updatedAt'] != null ? map['updatedAt'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageModel.fromJson(String source) => MessageModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MessageModel(id: $id, receiverUser: $receiverUser, senderUser: $senderUser, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant MessageModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.receiverUser == receiverUser &&
      other.senderUser == senderUser &&
      other.createdAt == createdAt &&
      other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      receiverUser.hashCode ^
      senderUser.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;
  }
}
