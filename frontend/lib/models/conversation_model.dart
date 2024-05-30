// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:chat_ws/models/message_model.dart';
import 'package:chat_ws/models/user_model.dart';

class ConversationModel {
  final String? id;
  final List<MessageModel> messages;
  final List<UserModel> participants;
  final String? createdAt;
  final String? updatedAt;
  ConversationModel({
    this.id,
    required this.messages,
    required this.participants,
    this.createdAt,
    this.updatedAt,
  });

  ConversationModel copyWith({
    String? id,
    List<MessageModel>? messages,
    List<UserModel>? participants,
    String? createdAt,
    String? updatedAt,
  }) {
    return ConversationModel(
      id: id ?? this.id,
      messages: messages ?? this.messages,
      participants: participants ?? this.participants,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'messages': messages.map((x) => x.toMap()).toList(),
      'participants': participants.map((x) => x.toMap()).toList(),
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory ConversationModel.fromMap(Map<String, dynamic> map) {
    return ConversationModel(
      id: map['_id'] != null ? map['_id'] as String : null,
      messages: List<MessageModel>.from((map['messages'] as List<int>).map<MessageModel>((x) => MessageModel.fromMap(x as Map<String,dynamic>),),),
      participants: List<UserModel>.from((map['participants'] as List<int>).map<UserModel>((x) => UserModel.fromMap(x as Map<String,dynamic>),),),
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
      updatedAt: map['updatedAt'] != null ? map['updatedAt'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ConversationModel.fromJson(String source) => ConversationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ConversationModel(id: $id, messages: $messages, participants: $participants, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant ConversationModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      listEquals(other.messages, messages) &&
      listEquals(other.participants, participants) &&
      other.createdAt == createdAt &&
      other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      messages.hashCode ^
      participants.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;
  }
}
