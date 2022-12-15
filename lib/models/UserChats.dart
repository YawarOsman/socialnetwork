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


/** This is an auto generated class representing the UserChats type in your schema. */
@immutable
class UserChats extends Model {
  static const classType = const _UserChatsModelType();
  final String id;
  final String? _userChatId;
  final String? _content;
  final String? _userIdSender;
  final String? _userIdReciever;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String get userChatId {
    try {
      return _userChatId!;
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
  
  String get userIdSender {
    try {
      return _userIdSender!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get userIdReciever {
    try {
      return _userIdReciever!;
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
  
  const UserChats._internal({required this.id, required userChatId, content, required userIdSender, required userIdReciever, createdAt, updatedAt}): _userChatId = userChatId, _content = content, _userIdSender = userIdSender, _userIdReciever = userIdReciever, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory UserChats({String? id, required String userChatId, String? content, required String userIdSender, required String userIdReciever}) {
    return UserChats._internal(
      id: id == null ? UUID.getUUID() : id,
      userChatId: userChatId,
      content: content,
      userIdSender: userIdSender,
      userIdReciever: userIdReciever);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserChats &&
      id == other.id &&
      _userChatId == other._userChatId &&
      _content == other._content &&
      _userIdSender == other._userIdSender &&
      _userIdReciever == other._userIdReciever;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("UserChats {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("userChatId=" + "$_userChatId" + ", ");
    buffer.write("content=" + "$_content" + ", ");
    buffer.write("userIdSender=" + "$_userIdSender" + ", ");
    buffer.write("userIdReciever=" + "$_userIdReciever" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  UserChats copyWith({String? id, String? userChatId, String? content, String? userIdSender, String? userIdReciever}) {
    return UserChats._internal(
      id: id ?? this.id,
      userChatId: userChatId ?? this.userChatId,
      content: content ?? this.content,
      userIdSender: userIdSender ?? this.userIdSender,
      userIdReciever: userIdReciever ?? this.userIdReciever);
  }
  
  UserChats.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _userChatId = json['userChatId'],
      _content = json['content'],
      _userIdSender = json['userIdSender'],
      _userIdReciever = json['userIdReciever'],
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'userChatId': _userChatId, 'content': _content, 'userIdSender': _userIdSender, 'userIdReciever': _userIdReciever, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id, 'userChatId': _userChatId, 'content': _content, 'userIdSender': _userIdSender, 'userIdReciever': _userIdReciever, 'createdAt': _createdAt, 'updatedAt': _updatedAt
  };

  static final QueryField ID = QueryField(fieldName: "id");
  static final QueryField USERCHATID = QueryField(fieldName: "userChatId");
  static final QueryField CONTENT = QueryField(fieldName: "content");
  static final QueryField USERIDSENDER = QueryField(fieldName: "userIdSender");
  static final QueryField USERIDRECIEVER = QueryField(fieldName: "userIdReciever");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "UserChats";
    modelSchemaDefinition.pluralName = "UserChats";
    
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
      ModelIndex(fields: const ["userIdSender"], name: "byUser_userChatSender"),
      ModelIndex(fields: const ["userIdReciever"], name: "byUser_userChatReciever")
    ];
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: UserChats.USERCHATID,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: UserChats.CONTENT,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: UserChats.USERIDSENDER,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: UserChats.USERIDRECIEVER,
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

class _UserChatsModelType extends ModelType<UserChats> {
  const _UserChatsModelType();
  
  @override
  UserChats fromJson(Map<String, dynamic> jsonData) {
    return UserChats.fromJson(jsonData);
  }
}