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
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the RoomChats type in your schema. */
@immutable
class RoomChats extends Model {
  static const classType = const _RoomChatsModelType();
  final String id;
  final String? _roomChatId;
  final String? _content;
  final Participants? _participantIdSender;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String get roomChatId {
    try {
      return _roomChatId!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String? get content {
    return _content;
  }
  
  Participants? get participantIdSender {
    return _participantIdSender;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const RoomChats._internal({required this.id, required roomChatId, content, participantIdSender, createdAt, updatedAt}): _roomChatId = roomChatId, _content = content, _participantIdSender = participantIdSender, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory RoomChats({String? id, required String roomChatId, String? content, Participants? participantIdSender}) {
    return RoomChats._internal(
      id: id == null ? UUID.getUUID() : id,
      roomChatId: roomChatId,
      content: content,
      participantIdSender: participantIdSender);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RoomChats &&
      id == other.id &&
      _roomChatId == other._roomChatId &&
      _content == other._content &&
      _participantIdSender == other._participantIdSender;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("RoomChats {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("roomChatId=" + "$_roomChatId" + ", ");
    buffer.write("content=" + "$_content" + ", ");
    buffer.write("participantIdSender=" + (_participantIdSender != null ? _participantIdSender!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  RoomChats copyWith({String? id, String? roomChatId, String? content, Participants? participantIdSender}) {
    return RoomChats._internal(
      id: id ?? this.id,
      roomChatId: roomChatId ?? this.roomChatId,
      content: content ?? this.content,
      participantIdSender: participantIdSender ?? this.participantIdSender);
  }
  
  RoomChats.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _roomChatId = json['roomChatId'],
      _content = json['content'],
      _participantIdSender = json['participantIdSender']?['serializedData'] != null
        ? Participants.fromJson(new Map<String, dynamic>.from(json['participantIdSender']['serializedData']))
        : null,
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'roomChatId': _roomChatId, 'content': _content, 'participantIdSender': _participantIdSender?.toJson(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id, 'roomChatId': _roomChatId, 'content': _content, 'participantIdSender': _participantIdSender, 'createdAt': _createdAt, 'updatedAt': _updatedAt
  };

  static final QueryField ID = QueryField(fieldName: "id");
  static final QueryField ROOMCHATID = QueryField(fieldName: "roomChatId");
  static final QueryField CONTENT = QueryField(fieldName: "content");
  static final QueryField PARTICIPANTIDSENDER = QueryField(
    fieldName: "participantIdSender",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Participants).toString()));
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "RoomChats";
    modelSchemaDefinition.pluralName = "RoomChats";
    
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
      ModelIndex(fields: const ["participantIdSender2"], name: "byParticipants_participantIdSender")
    ];
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: RoomChats.ROOMCHATID,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: RoomChats.CONTENT,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
      key: RoomChats.PARTICIPANTIDSENDER,
      isRequired: false,
      targetName: "participantIdSender2",
      ofModelName: (Participants).toString()
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

class _RoomChatsModelType extends ModelType<RoomChats> {
  const _RoomChatsModelType();
  
  @override
  RoomChats fromJson(Map<String, dynamic> jsonData) {
    return RoomChats.fromJson(jsonData);
  }
}