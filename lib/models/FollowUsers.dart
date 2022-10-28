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

import 'package:amplify_core/amplify_core.dart';
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the FollowUsers type in your schema. */
@immutable
class FollowUsers extends Model {
  static const classType = const _FollowUsersModelType();
  final String id;
  final String? _userIdFollower;
  final String? _userIdFollowed;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String get userIdFollower {
    try {
      return _userIdFollower!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get userIdFollowed {
    try {
      return _userIdFollowed!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const FollowUsers._internal({required this.id, required userIdFollower, required userIdFollowed, createdAt, updatedAt}): _userIdFollower = userIdFollower, _userIdFollowed = userIdFollowed, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory FollowUsers({String? id, required String userIdFollower, required String userIdFollowed}) {
    return FollowUsers._internal(
      id: id == null ? UUID.getUUID() : id,
      userIdFollower: userIdFollower,
      userIdFollowed: userIdFollowed);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FollowUsers &&
      id == other.id &&
      _userIdFollower == other._userIdFollower &&
      _userIdFollowed == other._userIdFollowed;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("FollowUsers {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("userIdFollower=" + "$_userIdFollower" + ", ");
    buffer.write("userIdFollowed=" + "$_userIdFollowed" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  FollowUsers copyWith({String? id, String? userIdFollower, String? userIdFollowed}) {
    return FollowUsers._internal(
      id: id ?? this.id,
      userIdFollower: userIdFollower ?? this.userIdFollower,
      userIdFollowed: userIdFollowed ?? this.userIdFollowed);
  }
  
  FollowUsers.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _userIdFollower = json['userIdFollower'],
      _userIdFollowed = json['userIdFollowed'],
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'userIdFollower': _userIdFollower, 'userIdFollowed': _userIdFollowed, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };

  static final QueryField ID = QueryField(fieldName: "id");
  static final QueryField USERIDFOLLOWER = QueryField(fieldName: "userIdFollower");
  static final QueryField USERIDFOLLOWED = QueryField(fieldName: "userIdFollowed");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "FollowUsers";
    modelSchemaDefinition.pluralName = "FollowUsers";
    
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
      key: FollowUsers.USERIDFOLLOWER,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: FollowUsers.USERIDFOLLOWED,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
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

class _FollowUsersModelType extends ModelType<FollowUsers> {
  const _FollowUsersModelType();
  
  @override
  FollowUsers fromJson(Map<String, dynamic> jsonData) {
    return FollowUsers.fromJson(jsonData);
  }
}