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


/** This is an auto generated class representing the Rooms type in your schema. */
@immutable
class Rooms extends Model {
  static const classType = const _RoomsModelType();
  final String id;
  final String? _roomId;
  final String? _name;
  final String? _description;
  final TemporalDateTime? _dateTime;
  final Users? _founderId;
  final List<Participants>? _participants;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String get roomId {
    try {
      return _roomId!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get name {
    try {
      return _name!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String? get description {
    return _description;
  }
  
  TemporalDateTime? get dateTime {
    return _dateTime;
  }
  
  Users? get founderId {
    return _founderId;
  }
  
  List<Participants>? get participants {
    return _participants;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const Rooms._internal({required this.id, required roomId, required name, description, dateTime, founderId, participants, createdAt, updatedAt}): _roomId = roomId, _name = name, _description = description, _dateTime = dateTime, _founderId = founderId, _participants = participants, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Rooms({String? id, required String roomId, required String name, String? description, TemporalDateTime? dateTime, Users? founderId, List<Participants>? participants}) {
    return Rooms._internal(
      id: id == null ? UUID.getUUID() : id,
      roomId: roomId,
      name: name,
      description: description,
      dateTime: dateTime,
      founderId: founderId,
      participants: participants != null ? List<Participants>.unmodifiable(participants) : participants);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Rooms &&
      id == other.id &&
      _roomId == other._roomId &&
      _name == other._name &&
      _description == other._description &&
      _dateTime == other._dateTime &&
      _founderId == other._founderId &&
      DeepCollectionEquality().equals(_participants, other._participants);
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Rooms {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("roomId=" + "$_roomId" + ", ");
    buffer.write("name=" + "$_name" + ", ");
    buffer.write("description=" + "$_description" + ", ");
    buffer.write("dateTime=" + (_dateTime != null ? _dateTime!.format() : "null") + ", ");
    buffer.write("founderId=" + (_founderId != null ? _founderId!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Rooms copyWith({String? id, String? roomId, String? name, String? description, TemporalDateTime? dateTime, Users? founderId, List<Participants>? participants}) {
    return Rooms._internal(
      id: id ?? this.id,
      roomId: roomId ?? this.roomId,
      name: name ?? this.name,
      description: description ?? this.description,
      dateTime: dateTime ?? this.dateTime,
      founderId: founderId ?? this.founderId,
      participants: participants ?? this.participants);
  }
  
  Rooms.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _roomId = json['roomId'],
      _name = json['name'],
      _description = json['description'],
      _dateTime = json['dateTime'] != null ? TemporalDateTime.fromString(json['dateTime']) : null,
      _founderId = json['founderId']?['serializedData'] != null
        ? Users.fromJson(new Map<String, dynamic>.from(json['founderId']['serializedData']))
        : null,
      _participants = json['participants'] is List
        ? (json['participants'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => Participants.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'roomId': _roomId, 'name': _name, 'description': _description, 'dateTime': _dateTime?.format(), 'founderId': _founderId?.toJson(), 'participants': _participants?.map((Participants? e) => e?.toJson()).toList(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };

  static final QueryField ID = QueryField(fieldName: "id");
  static final QueryField ROOMID = QueryField(fieldName: "roomId");
  static final QueryField NAME = QueryField(fieldName: "name");
  static final QueryField DESCRIPTION = QueryField(fieldName: "description");
  static final QueryField DATETIME = QueryField(fieldName: "dateTime");
  static final QueryField FOUNDERID = QueryField(
    fieldName: "founderId",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Users).toString()));
  static final QueryField PARTICIPANTS = QueryField(
    fieldName: "participants",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Participants).toString()));
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Rooms";
    modelSchemaDefinition.pluralName = "Rooms";
    
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
      key: Rooms.ROOMID,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Rooms.NAME,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Rooms.DESCRIPTION,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Rooms.DATETIME,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
      key: Rooms.FOUNDERID,
      isRequired: false,
      targetName: "founderId2",
      ofModelName: (Users).toString()
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: Rooms.PARTICIPANTS,
      isRequired: false,
      ofModelName: (Participants).toString(),
      associatedKey: Participants.ROOMID
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

class _RoomsModelType extends ModelType<Rooms> {
  const _RoomsModelType();
  
  @override
  Rooms fromJson(Map<String, dynamic> jsonData) {
    return Rooms.fromJson(jsonData);
  }
}