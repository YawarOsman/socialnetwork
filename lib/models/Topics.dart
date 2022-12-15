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


/** This is an auto generated class representing the Topics type in your schema. */
@immutable
class Topics extends Model {
  static const classType = const _TopicsModelType();
  final String id;
  final String? _topicId;
  final String? _name;
  final String? _description;
  final List<Clubs>? _clubs;
  final List<UserTopics>? _userTopics;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String get topicId {
    try {
      return _topicId!;
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
  
  List<Clubs>? get clubs {
    return _clubs;
  }
  
  List<UserTopics>? get userTopics {
    return _userTopics;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const Topics._internal({required this.id, required topicId, required name, description, clubs, userTopics, createdAt, updatedAt}): _topicId = topicId, _name = name, _description = description, _clubs = clubs, _userTopics = userTopics, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Topics({String? id, required String topicId, required String name, String? description, List<Clubs>? clubs, List<UserTopics>? userTopics}) {
    return Topics._internal(
      id: id == null ? UUID.getUUID() : id,
      topicId: topicId,
      name: name,
      description: description,
      clubs: clubs != null ? List<Clubs>.unmodifiable(clubs) : clubs,
      userTopics: userTopics != null ? List<UserTopics>.unmodifiable(userTopics) : userTopics);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Topics &&
      id == other.id &&
      _topicId == other._topicId &&
      _name == other._name &&
      _description == other._description &&
      DeepCollectionEquality().equals(_clubs, other._clubs) &&
      DeepCollectionEquality().equals(_userTopics, other._userTopics);
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Topics {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("topicId=" + "$_topicId" + ", ");
    buffer.write("name=" + "$_name" + ", ");
    buffer.write("description=" + "$_description" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Topics copyWith({String? id, String? topicId, String? name, String? description, List<Clubs>? clubs, List<UserTopics>? userTopics}) {
    return Topics._internal(
      id: id ?? this.id,
      topicId: topicId ?? this.topicId,
      name: name ?? this.name,
      description: description ?? this.description,
      clubs: clubs ?? this.clubs,
      userTopics: userTopics ?? this.userTopics);
  }
  
  Topics.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _topicId = json['topicId'],
      _name = json['name'],
      _description = json['description'],
      _clubs = json['clubs'] is List
        ? (json['clubs'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => Clubs.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _userTopics = json['userTopics'] is List
        ? (json['userTopics'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => UserTopics.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'topicId': _topicId, 'name': _name, 'description': _description, 'clubs': _clubs?.map((Clubs? e) => e?.toJson()).toList(), 'userTopics': _userTopics?.map((UserTopics? e) => e?.toJson()).toList(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id, 'topicId': _topicId, 'name': _name, 'description': _description, 'clubs': _clubs, 'userTopics': _userTopics, 'createdAt': _createdAt, 'updatedAt': _updatedAt
  };

  static final QueryField ID = QueryField(fieldName: "id");
  static final QueryField TOPICID = QueryField(fieldName: "topicId");
  static final QueryField NAME = QueryField(fieldName: "name");
  static final QueryField DESCRIPTION = QueryField(fieldName: "description");
  static final QueryField CLUBS = QueryField(
    fieldName: "clubs",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Clubs).toString()));
  static final QueryField USERTOPICS = QueryField(
    fieldName: "userTopics",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (UserTopics).toString()));
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Topics";
    modelSchemaDefinition.pluralName = "Topics";
    
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
      key: Topics.TOPICID,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Topics.NAME,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Topics.DESCRIPTION,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: Topics.CLUBS,
      isRequired: false,
      ofModelName: (Clubs).toString(),
      associatedKey: Clubs.TOPICID
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: Topics.USERTOPICS,
      isRequired: false,
      ofModelName: (UserTopics).toString(),
      associatedKey: UserTopics.TOPICID
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

class _TopicsModelType extends ModelType<Topics> {
  const _TopicsModelType();
  
  @override
  Topics fromJson(Map<String, dynamic> jsonData) {
    return Topics.fromJson(jsonData);
  }
}