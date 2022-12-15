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


/** This is an auto generated class representing the UserTopics type in your schema. */
@immutable
class UserTopics extends Model {
  static const classType = const _UserTopicsModelType();
  final String id;
  final Users? _userId;
  final Topics? _topicId;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  Users? get userId {
    return _userId;
  }
  
  Topics? get topicId {
    return _topicId;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const UserTopics._internal({required this.id, userId, topicId, createdAt, updatedAt}): _userId = userId, _topicId = topicId, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory UserTopics({String? id, Users? userId, Topics? topicId}) {
    return UserTopics._internal(
      id: id == null ? UUID.getUUID() : id,
      userId: userId,
      topicId: topicId);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserTopics &&
      id == other.id &&
      _userId == other._userId &&
      _topicId == other._topicId;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("UserTopics {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("userId=" + (_userId != null ? _userId!.toString() : "null") + ", ");
    buffer.write("topicId=" + (_topicId != null ? _topicId!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  UserTopics copyWith({String? id, Users? userId, Topics? topicId}) {
    return UserTopics._internal(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      topicId: topicId ?? this.topicId);
  }
  
  UserTopics.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _userId = json['userId']?['serializedData'] != null
        ? Users.fromJson(new Map<String, dynamic>.from(json['userId']['serializedData']))
        : null,
      _topicId = json['topicId']?['serializedData'] != null
        ? Topics.fromJson(new Map<String, dynamic>.from(json['topicId']['serializedData']))
        : null,
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'userId': _userId?.toJson(), 'topicId': _topicId?.toJson(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id, 'userId': _userId, 'topicId': _topicId, 'createdAt': _createdAt, 'updatedAt': _updatedAt
  };

  static final QueryField ID = QueryField(fieldName: "id");
  static final QueryField USERID = QueryField(
    fieldName: "userId",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Users).toString()));
  static final QueryField TOPICID = QueryField(
    fieldName: "topicId",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Topics).toString()));
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "UserTopics";
    modelSchemaDefinition.pluralName = "UserTopics";
    
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
      ModelIndex(fields: const ["userId2"], name: "byUser_userTopics"),
      ModelIndex(fields: const ["topicId2"], name: "byTopic_userTopics")
    ];
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
      key: UserTopics.USERID,
      isRequired: false,
      targetName: "userId2",
      ofModelName: (Users).toString()
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
      key: UserTopics.TOPICID,
      isRequired: false,
      targetName: "topicId2",
      ofModelName: (Topics).toString()
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

class _UserTopicsModelType extends ModelType<UserTopics> {
  const _UserTopicsModelType();
  
  @override
  UserTopics fromJson(Map<String, dynamic> jsonData) {
    return UserTopics.fromJson(jsonData);
  }
}