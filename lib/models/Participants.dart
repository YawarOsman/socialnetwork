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
  final String? _role;
  final TemporalDateTime? _joinDate;
  final String? _peeringId;
  final Users? _participantsId;
  final Rooms? _roomId;
  final List<RoomChats>? _participantIdSender;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String? get role {
    return _role;
  }
  
  TemporalDateTime? get joinDate {
    return _joinDate;
  }
  
  String get peeringId {
    try {
      return _peeringId!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  Users? get participantsId {
    return _participantsId;
  }
  
  Rooms? get roomId {
    return _roomId;
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
  
  const Participants._internal({required this.id, role, joinDate, required peeringId, participantsId, roomId, participantIdSender, createdAt, updatedAt}): _role = role, _joinDate = joinDate, _peeringId = peeringId, _participantsId = participantsId, _roomId = roomId, _participantIdSender = participantIdSender, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Participants({String? id, String? role, TemporalDateTime? joinDate, required String peeringId, Users? participantsId, Rooms? roomId, List<RoomChats>? participantIdSender}) {
    return Participants._internal(
      id: id == null ? UUID.getUUID() : id,
      role: role,
      joinDate: joinDate,
      peeringId: peeringId,
      participantsId: participantsId,
      roomId: roomId,
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
      _role == other._role &&
      _joinDate == other._joinDate &&
      _peeringId == other._peeringId &&
      _participantsId == other._participantsId &&
      _roomId == other._roomId &&
      DeepCollectionEquality().equals(_participantIdSender, other._participantIdSender);
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Participants {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("role=" + "$_role" + ", ");
    buffer.write("joinDate=" + (_joinDate != null ? _joinDate!.format() : "null") + ", ");
    buffer.write("peeringId=" + "$_peeringId" + ", ");
    buffer.write("participantsId=" + (_participantsId != null ? _participantsId!.toString() : "null") + ", ");
    buffer.write("roomId=" + (_roomId != null ? _roomId!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Participants copyWith({String? id, String? role, TemporalDateTime? joinDate, String? peeringId, Users? participantsId, Rooms? roomId, List<RoomChats>? participantIdSender}) {
    return Participants._internal(
      id: id ?? this.id,
      role: role ?? this.role,
      joinDate: joinDate ?? this.joinDate,
      peeringId: peeringId ?? this.peeringId,
      participantsId: participantsId ?? this.participantsId,
      roomId: roomId ?? this.roomId,
      participantIdSender: participantIdSender ?? this.participantIdSender);
  }
  
  Participants.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _role = json['role'],
      _joinDate = json['joinDate'] != null ? TemporalDateTime.fromString(json['joinDate']) : null,
      _peeringId = json['peeringId'],
      _participantsId = json['participantsId']?['serializedData'] != null
        ? Users.fromJson(new Map<String, dynamic>.from(json['participantsId']['serializedData']))
        : null,
      _roomId = json['roomId']?['serializedData'] != null
        ? Rooms.fromJson(new Map<String, dynamic>.from(json['roomId']['serializedData']))
        : null,
      _participantIdSender = json['participantIdSender'] is List
        ? (json['participantIdSender'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => RoomChats.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'role': _role, 'joinDate': _joinDate?.format(), 'peeringId': _peeringId, 'participantsId': _participantsId?.toJson(), 'roomId': _roomId?.toJson(), 'participantIdSender': _participantIdSender?.map((RoomChats? e) => e?.toJson()).toList(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };

  static final QueryField ID = QueryField(fieldName: "id");
  static final QueryField ROLE = QueryField(fieldName: "role");
  static final QueryField JOINDATE = QueryField(fieldName: "joinDate");
  static final QueryField PEERINGID = QueryField(fieldName: "peeringId");
  static final QueryField PARTICIPANTSID = QueryField(
    fieldName: "participantsId",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Users).toString()));
  static final QueryField ROOMID = QueryField(
    fieldName: "roomId",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Rooms).toString()));
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
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Participants.ROLE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Participants.JOINDATE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Participants.PEERINGID,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
      key: Participants.PARTICIPANTSID,
      isRequired: false,
      targetName: "participantsId2",
      ofModelName: (Users).toString()
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
      key: Participants.ROOMID,
      isRequired: false,
      targetName: "roomId2",
      ofModelName: (Rooms).toString()
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