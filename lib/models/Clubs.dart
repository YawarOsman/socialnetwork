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


/** This is an auto generated class representing the Clubs type in your schema. */
@immutable
class Clubs extends Model {
  static const classType = const _ClubsModelType();
  final String id;
  final String? _clubId;
  final String? _name;
  final Topics? _topicId;
  final Users? _userIdFounder;
  final List<FollowClubs>? _follow;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String get clubId {
    try {
      return _clubId!;
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
  
  Topics? get topicId {
    return _topicId;
  }
  
  Users? get userIdFounder {
    return _userIdFounder;
  }
  
  List<FollowClubs>? get follow {
    return _follow;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const Clubs._internal({required this.id, required clubId, required name, topicId, userIdFounder, follow, createdAt, updatedAt}): _clubId = clubId, _name = name, _topicId = topicId, _userIdFounder = userIdFounder, _follow = follow, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Clubs({String? id, required String clubId, required String name, Topics? topicId, Users? userIdFounder, List<FollowClubs>? follow}) {
    return Clubs._internal(
      id: id == null ? UUID.getUUID() : id,
      clubId: clubId,
      name: name,
      topicId: topicId,
      userIdFounder: userIdFounder,
      follow: follow != null ? List<FollowClubs>.unmodifiable(follow) : follow);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Clubs &&
      id == other.id &&
      _clubId == other._clubId &&
      _name == other._name &&
      _topicId == other._topicId &&
      _userIdFounder == other._userIdFounder &&
      DeepCollectionEquality().equals(_follow, other._follow);
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Clubs {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("clubId=" + "$_clubId" + ", ");
    buffer.write("name=" + "$_name" + ", ");
    buffer.write("topicId=" + (_topicId != null ? _topicId!.toString() : "null") + ", ");
    buffer.write("userIdFounder=" + (_userIdFounder != null ? _userIdFounder!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Clubs copyWith({String? id, String? clubId, String? name, Topics? topicId, Users? userIdFounder, List<FollowClubs>? follow}) {
    return Clubs._internal(
      id: id ?? this.id,
      clubId: clubId ?? this.clubId,
      name: name ?? this.name,
      topicId: topicId ?? this.topicId,
      userIdFounder: userIdFounder ?? this.userIdFounder,
      follow: follow ?? this.follow);
  }
  
  Clubs.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _clubId = json['clubId'],
      _name = json['name'],
      _topicId = json['topicId']?['serializedData'] != null
        ? Topics.fromJson(new Map<String, dynamic>.from(json['topicId']['serializedData']))
        : null,
      _userIdFounder = json['userIdFounder']?['serializedData'] != null
        ? Users.fromJson(new Map<String, dynamic>.from(json['userIdFounder']['serializedData']))
        : null,
      _follow = json['follow'] is List
        ? (json['follow'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => FollowClubs.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'clubId': _clubId, 'name': _name, 'topicId': _topicId?.toJson(), 'userIdFounder': _userIdFounder?.toJson(), 'follow': _follow?.map((FollowClubs? e) => e?.toJson()).toList(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id, 'clubId': _clubId, 'name': _name, 'topicId': _topicId, 'userIdFounder': _userIdFounder, 'follow': _follow, 'createdAt': _createdAt, 'updatedAt': _updatedAt
  };

  static final QueryField ID = QueryField(fieldName: "id");
  static final QueryField CLUBID = QueryField(fieldName: "clubId");
  static final QueryField NAME = QueryField(fieldName: "name");
  static final QueryField TOPICID = QueryField(
    fieldName: "topicId",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Topics).toString()));
  static final QueryField USERIDFOUNDER = QueryField(
    fieldName: "userIdFounder",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Users).toString()));
  static final QueryField FOLLOW = QueryField(
    fieldName: "follow",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (FollowClubs).toString()));
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Clubs";
    modelSchemaDefinition.pluralName = "Clubs";
    
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
      ModelIndex(fields: const ["userIdFounder2"], name: "byUser_clubs"),
      ModelIndex(fields: const ["topicId2"], name: "byTopic_clubs")
    ];
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Clubs.CLUBID,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Clubs.NAME,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
      key: Clubs.TOPICID,
      isRequired: false,
      targetName: "topicId2",
      ofModelName: (Topics).toString()
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
      key: Clubs.USERIDFOUNDER,
      isRequired: false,
      targetName: "userIdFounder2",
      ofModelName: (Users).toString()
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: Clubs.FOLLOW,
      isRequired: false,
      ofModelName: (FollowClubs).toString(),
      associatedKey: FollowClubs.CLUBID
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

class _ClubsModelType extends ModelType<Clubs> {
  const _ClubsModelType();
  
  @override
  Clubs fromJson(Map<String, dynamic> jsonData) {
    return Clubs.fromJson(jsonData);
  }
}