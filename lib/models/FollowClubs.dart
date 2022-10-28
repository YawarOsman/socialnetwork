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


/** This is an auto generated class representing the FollowClubs type in your schema. */
@immutable
class FollowClubs extends Model {
  static const classType = const _FollowClubsModelType();
  final String id;
  final Clubs? _clubId;
  final Users? _userId;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  Clubs? get clubId {
    return _clubId;
  }
  
  Users? get userId {
    return _userId;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const FollowClubs._internal({required this.id, clubId, userId, createdAt, updatedAt}): _clubId = clubId, _userId = userId, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory FollowClubs({String? id, Clubs? clubId, Users? userId}) {
    return FollowClubs._internal(
      id: id == null ? UUID.getUUID() : id,
      clubId: clubId,
      userId: userId);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FollowClubs &&
      id == other.id &&
      _clubId == other._clubId &&
      _userId == other._userId;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("FollowClubs {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("clubId=" + (_clubId != null ? _clubId!.toString() : "null") + ", ");
    buffer.write("userId=" + (_userId != null ? _userId!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  FollowClubs copyWith({String? id, Clubs? clubId, Users? userId}) {
    return FollowClubs._internal(
      id: id ?? this.id,
      clubId: clubId ?? this.clubId,
      userId: userId ?? this.userId);
  }
  
  FollowClubs.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _clubId = json['clubId']?['serializedData'] != null
        ? Clubs.fromJson(new Map<String, dynamic>.from(json['clubId']['serializedData']))
        : null,
      _userId = json['userId']?['serializedData'] != null
        ? Users.fromJson(new Map<String, dynamic>.from(json['userId']['serializedData']))
        : null,
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'clubId': _clubId?.toJson(), 'userId': _userId?.toJson(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };

  static final QueryField ID = QueryField(fieldName: "id");
  static final QueryField CLUBID = QueryField(
    fieldName: "clubId",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Clubs).toString()));
  static final QueryField USERID = QueryField(
    fieldName: "userId",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Users).toString()));
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "FollowClubs";
    modelSchemaDefinition.pluralName = "FollowClubs";
    
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
    
    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
      key: FollowClubs.CLUBID,
      isRequired: false,
      targetName: "clubId2",
      ofModelName: (Clubs).toString()
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
      key: FollowClubs.USERID,
      isRequired: false,
      targetName: "userId2",
      ofModelName: (Users).toString()
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

class _FollowClubsModelType extends ModelType<FollowClubs> {
  const _FollowClubsModelType();
  
  @override
  FollowClubs fromJson(Map<String, dynamic> jsonData) {
    return FollowClubs.fromJson(jsonData);
  }
}