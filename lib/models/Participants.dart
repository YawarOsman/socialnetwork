/*
* Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

// NOTE: This file is generated and may not follow lint rules defined in your app
// Generated files can be excluded from analysis in analysis_options.yaml
// For more info, see: https://dart.dev/guides/language/analysis-options#excluding-code-from-analysis

// ignore_for_file: public_member_api_docs, annotate_overrides, dead_code, dead_codepublic_member_api_docs, depend_on_referenced_packages, file_names, library_private_types_in_public_api, no_leading_underscores_for_library_prefixes, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, null_check_on_nullable_type_parameter, prefer_adjacent_string_concatenation, prefer_const_constructors, prefer_if_null_operators, prefer_interpolation_to_compose_strings, slash_for_doc_comments, sort_child_properties_last, unnecessary_const, unnecessary_constructor_name, unnecessary_late, unnecessary_new, unnecessary_null_aware_assignments, unnecessary_nullable_for_final_variable_declarations, unnecessary_string_interpolations, use_build_context_synchronously

import 'ModelProvider.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the Participants type in your schema. */
@immutable
class Participants extends Model {
  static const classType = const _ParticipantsModelType();
  final String id;
  final String? _participantsId;
  final String? _role;
  final Users? _userId;
  final Rooms? _roomId;
  final Status? _participantStatus;
  final List<RoomChats>? _participantIdSender;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String? get participantsId {
    return _participantsId;
  }
  
  String? get role {
    return _role;
  }
  
  Users? get userId {
    return _userId;
  }
  
  Rooms? get roomId {
    return _roomId;
  }
  
  Status? get participantStatus {
    return _participantStatus;
  }
  
  List<RoomChats>? get participantIdSender {
    return _participantIdSender;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const Participants._internal({required this.id, participantsId, role, userId, roomId, participantStatus, participantIdSender, createdAt, updatedAt}): _participantsId = participantsId, _role = role, _userId = userId, _roomId = roomId, _participantStatus = participantStatus, _participantIdSender = participantIdSender, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Participants({String? id, String? participantsId, String? role, Users? userId, Rooms? roomId, Status? participantStatus, List<RoomChats>? participantIdSender}) {
    return Participants._internal(
      id: id == null ? UUID.getUUID() : id,
      participantsId: participantsId,
      role: role,
      userId: userId,
      roomId: roomId,
      participantStatus: participantStatus,
      participantIdSender: participantIdSender != null ? List<RoomChats>.unmodifiable(participantIdSender) : participantIdSender);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Participants &&
      id == other.id &&
      _participantsId == other._participantsId &&
      _role == other._role &&
      _userId == other._userId &&
      _roomId == other._roomId &&
      _participantStatus == other._participantStatus &&
      DeepCollectionEquality().equals(_participantIdSender, other._participantIdSender);
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Participants {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("participantsId=" + "$_participantsId" + ", ");
    buffer.write("role=" + "$_role" + ", ");
    buffer.write("userId=" + (_userId != null ? _userId!.toString() : "null") + ", ");
    buffer.write("roomId=" + (_roomId != null ? _roomId!.toString() : "null") + ", ");
    buffer.write("participantStatus=" + (_participantStatus != null ? enumToString(_participantStatus)! : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Participants copyWith({String? id, String? participantsId, String? role, Users? userId, Rooms? roomId, Status? participantStatus, List<RoomChats>? participantIdSender}) {
    return Participants._internal(
      id: id ?? this.id,
      participantsId: participantsId ?? this.participantsId,
      role: role ?? this.role,
      userId: userId ?? this.userId,
      roomId: roomId ?? this.roomId,
      participantStatus: participantStatus ?? this.participantStatus,
      participantIdSender: participantIdSender ?? this.participantIdSender);
  }
  
  Participants.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _participantsId = json['participantsId'],
      _role = json['role'],
      _userId = json['userId']?['serializedData'] != null
        ? Users.fromJson(new Map<String, dynamic>.from(json['userId']['serializedData']))
        : null,
      _roomId = json['roomId']?['serializedData'] != null
        ? Rooms.fromJson(new Map<String, dynamic>.from(json['roomId']['serializedData']))
        : null,
      _participantStatus = enumFromString<Status>(json['participantStatus'], Status.values),
      _participantIdSender = json['participantIdSender'] is List
        ? (json['participantIdSender'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => RoomChats.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'participantsId': _participantsId, 'role': _role, 'userId': _userId?.toJson(), 'roomId': _roomId?.toJson(), 'participantStatus': enumToString(_participantStatus), 'participantIdSender': _participantIdSender?.map((RoomChats? e) => e?.toJson()).toList(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id, 'participantsId': _participantsId, 'role': _role, 'userId': _userId, 'roomId': _roomId, 'participantStatus': _participantStatus, 'participantIdSender': _participantIdSender, 'createdAt': _createdAt, 'updatedAt': _updatedAt
  };

  static final QueryField ID = QueryField(fieldName: "id");
  static final QueryField PARTICIPANTSID = QueryField(fieldName: "participantsId");
  static final QueryField ROLE = QueryField(fieldName: "role");
  static final QueryField USERID = QueryField(
    fieldName: "userId",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Users).toString()));
  static final QueryField ROOMID = QueryField(
    fieldName: "roomId",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Rooms).toString()));
  static final QueryField PARTICIPANTSTATUS = QueryField(fieldName: "participantStatus");
  static final QueryField PARTICIPANTIDSENDER = QueryField(
    fieldName: "participantIdSender",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (RoomChats).toString()));
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Participants";
    modelSchemaDefinition.pluralName = "Participants";
    
    modelSchemaDefinition.authRules = [
      AuthRule(
        authStrategy: AuthStrategy.PUBLIC,
        operations: [
          ModelOperation.CREATE,
          ModelOperation.UPDATE,
          ModelOperation.DELETE,
          ModelOperation.READ
        ])
    ];
    
    modelSchemaDefinition.indexes = [
      ModelIndex(fields: const ["userId2"], name: "byUser_participants"),
      ModelIndex(fields: const ["roomId2"], name: "byRoom_participants")
    ];
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Participants.PARTICIPANTSID,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Participants.ROLE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
      key: Participants.USERID,
      isRequired: false,
      targetName: "userId2",
      ofModelName: (Users).toString()
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
      key: Participants.ROOMID,
      isRequired: false,
      targetName: "roomId2",
      ofModelName: (Rooms).toString()
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Participants.PARTICIPANTSTATUS,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.enumeration)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: Participants.PARTICIPANTIDSENDER,
      isRequired: false,
      ofModelName: (RoomChats).toString(),
      associatedKey: RoomChats.PARTICIPANTIDSENDER
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
      fieldName: 'createdAt',
      isRequired: false,
      isReadOnly: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
      fieldName: 'updatedAt',
      isRequired: false,
      isReadOnly: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
  });
}

class _ParticipantsModelType extends ModelType<Participants> {
  const _ParticipantsModelType();
  
  @override
  Participants fromJson(Map<String, dynamic> jsonData) {
    return Participants.fromJson(jsonData);
  }
}