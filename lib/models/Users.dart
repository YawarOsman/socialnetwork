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


/** This is an auto generated class representing the Users type in your schema. */
@immutable
class Users extends Model {
  static const classType = const _UsersModelType();
  final String id;
  final String? _userId;
  final String? _userName;
  final String? _email;
  final String? _phone;
  final String? _bio;
  final String? _social_links;
  final String? _profile_image;
  final List<FollowUsers>? _followUsersFollower;
  final List<FollowUsers>? _followUsersReciever;
  final List<FollowClubs>? _followClubs;
  final List<Clubs>? _clubs;
  final List<UserTopics>? _userTopics;
  final List<UserChats>? _userChatSender;
  final List<UserChats>? _userChatReciever;
  final List<Participants>? _participants;
  final List<Rooms>? _rooms;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String get userId {
    try {
      return _userId!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String? get userName {
    return _userName;
  }
  
  String? get email {
    return _email;
  }
  
  String? get phone {
    return _phone;
  }
  
  String? get bio {
    return _bio;
  }
  
  String? get social_links {
    return _social_links;
  }
  
  String? get profile_image {
    return _profile_image;
  }
  
  List<FollowUsers>? get followUsersFollower {
    return _followUsersFollower;
  }
  
  List<FollowUsers>? get followUsersReciever {
    return _followUsersReciever;
  }
  
  List<FollowClubs>? get followClubs {
    return _followClubs;
  }
  
  List<Clubs>? get clubs {
    return _clubs;
  }
  
  List<UserTopics>? get userTopics {
    return _userTopics;
  }
  
  List<UserChats>? get userChatSender {
    return _userChatSender;
  }
  
  List<UserChats>? get userChatReciever {
    return _userChatReciever;
  }
  
  List<Participants>? get participants {
    return _participants;
  }
  
  List<Rooms>? get rooms {
    return _rooms;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const Users._internal({required this.id, required userId, userName, email, phone, bio, social_links, profile_image, followUsersFollower, followUsersReciever, followClubs, clubs, userTopics, userChatSender, userChatReciever, participants, rooms, createdAt, updatedAt}): _userId = userId, _userName = userName, _email = email, _phone = phone, _bio = bio, _social_links = social_links, _profile_image = profile_image, _followUsersFollower = followUsersFollower, _followUsersReciever = followUsersReciever, _followClubs = followClubs, _clubs = clubs, _userTopics = userTopics, _userChatSender = userChatSender, _userChatReciever = userChatReciever, _participants = participants, _rooms = rooms, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Users({String? id, required String userId, String? userName, String? email, String? phone, String? bio, String? social_links, String? profile_image, List<FollowUsers>? followUsersFollower, List<FollowUsers>? followUsersReciever, List<FollowClubs>? followClubs, List<Clubs>? clubs, List<UserTopics>? userTopics, List<UserChats>? userChatSender, List<UserChats>? userChatReciever, List<Participants>? participants, List<Rooms>? rooms}) {
    return Users._internal(
      id: id == null ? UUID.getUUID() : id,
      userId: userId,
      userName: userName,
      email: email,
      phone: phone,
      bio: bio,
      social_links: social_links,
      profile_image: profile_image,
      followUsersFollower: followUsersFollower != null ? List<FollowUsers>.unmodifiable(followUsersFollower) : followUsersFollower,
      followUsersReciever: followUsersReciever != null ? List<FollowUsers>.unmodifiable(followUsersReciever) : followUsersReciever,
      followClubs: followClubs != null ? List<FollowClubs>.unmodifiable(followClubs) : followClubs,
      clubs: clubs != null ? List<Clubs>.unmodifiable(clubs) : clubs,
      userTopics: userTopics != null ? List<UserTopics>.unmodifiable(userTopics) : userTopics,
      userChatSender: userChatSender != null ? List<UserChats>.unmodifiable(userChatSender) : userChatSender,
      userChatReciever: userChatReciever != null ? List<UserChats>.unmodifiable(userChatReciever) : userChatReciever,
      participants: participants != null ? List<Participants>.unmodifiable(participants) : participants,
      rooms: rooms != null ? List<Rooms>.unmodifiable(rooms) : rooms);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Users &&
      id == other.id &&
      _userId == other._userId &&
      _userName == other._userName &&
      _email == other._email &&
      _phone == other._phone &&
      _bio == other._bio &&
      _social_links == other._social_links &&
      _profile_image == other._profile_image &&
      DeepCollectionEquality().equals(_followUsersFollower, other._followUsersFollower) &&
      DeepCollectionEquality().equals(_followUsersReciever, other._followUsersReciever) &&
      DeepCollectionEquality().equals(_followClubs, other._followClubs) &&
      DeepCollectionEquality().equals(_clubs, other._clubs) &&
      DeepCollectionEquality().equals(_userTopics, other._userTopics) &&
      DeepCollectionEquality().equals(_userChatSender, other._userChatSender) &&
      DeepCollectionEquality().equals(_userChatReciever, other._userChatReciever) &&
      DeepCollectionEquality().equals(_participants, other._participants) &&
      DeepCollectionEquality().equals(_rooms, other._rooms);
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Users {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("userId=" + "$_userId" + ", ");
    buffer.write("userName=" + "$_userName" + ", ");
    buffer.write("email=" + "$_email" + ", ");
    buffer.write("phone=" + "$_phone" + ", ");
    buffer.write("bio=" + "$_bio" + ", ");
    buffer.write("social_links=" + "$_social_links" + ", ");
    buffer.write("profile_image=" + "$_profile_image" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Users copyWith({String? id, String? userId, String? userName, String? email, String? phone, String? bio, String? social_links, String? profile_image, List<FollowUsers>? followUsersFollower, List<FollowUsers>? followUsersReciever, List<FollowClubs>? followClubs, List<Clubs>? clubs, List<UserTopics>? userTopics, List<UserChats>? userChatSender, List<UserChats>? userChatReciever, List<Participants>? participants, List<Rooms>? rooms}) {
    return Users._internal(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      bio: bio ?? this.bio,
      social_links: social_links ?? this.social_links,
      profile_image: profile_image ?? this.profile_image,
      followUsersFollower: followUsersFollower ?? this.followUsersFollower,
      followUsersReciever: followUsersReciever ?? this.followUsersReciever,
      followClubs: followClubs ?? this.followClubs,
      clubs: clubs ?? this.clubs,
      userTopics: userTopics ?? this.userTopics,
      userChatSender: userChatSender ?? this.userChatSender,
      userChatReciever: userChatReciever ?? this.userChatReciever,
      participants: participants ?? this.participants,
      rooms: rooms ?? this.rooms);
  }
  
  Users.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _userId = json['userId'],
      _userName = json['userName'],
      _email = json['email'],
      _phone = json['phone'],
      _bio = json['bio'],
      _social_links = json['social_links'],
      _profile_image = json['profile_image'],
      _followUsersFollower = json['followUsersFollower'] is List
        ? (json['followUsersFollower'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => FollowUsers.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _followUsersReciever = json['followUsersReciever'] is List
        ? (json['followUsersReciever'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => FollowUsers.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _followClubs = json['followClubs'] is List
        ? (json['followClubs'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => FollowClubs.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
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
      _userChatSender = json['userChatSender'] is List
        ? (json['userChatSender'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => UserChats.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _userChatReciever = json['userChatReciever'] is List
        ? (json['userChatReciever'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => UserChats.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _participants = json['participants'] is List
        ? (json['participants'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => Participants.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _rooms = json['rooms'] is List
        ? (json['rooms'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => Rooms.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'userId': _userId, 'userName': _userName, 'email': _email, 'phone': _phone, 'bio': _bio, 'social_links': _social_links, 'profile_image': _profile_image, 'followUsersFollower': _followUsersFollower?.map((FollowUsers? e) => e?.toJson()).toList(), 'followUsersReciever': _followUsersReciever?.map((FollowUsers? e) => e?.toJson()).toList(), 'followClubs': _followClubs?.map((FollowClubs? e) => e?.toJson()).toList(), 'clubs': _clubs?.map((Clubs? e) => e?.toJson()).toList(), 'userTopics': _userTopics?.map((UserTopics? e) => e?.toJson()).toList(), 'userChatSender': _userChatSender?.map((UserChats? e) => e?.toJson()).toList(), 'userChatReciever': _userChatReciever?.map((UserChats? e) => e?.toJson()).toList(), 'participants': _participants?.map((Participants? e) => e?.toJson()).toList(), 'rooms': _rooms?.map((Rooms? e) => e?.toJson()).toList(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id, 'userId': _userId, 'userName': _userName, 'email': _email, 'phone': _phone, 'bio': _bio, 'social_links': _social_links, 'profile_image': _profile_image, 'followUsersFollower': _followUsersFollower, 'followUsersReciever': _followUsersReciever, 'followClubs': _followClubs, 'clubs': _clubs, 'userTopics': _userTopics, 'userChatSender': _userChatSender, 'userChatReciever': _userChatReciever, 'participants': _participants, 'rooms': _rooms, 'createdAt': _createdAt, 'updatedAt': _updatedAt
  };

  static final QueryField ID = QueryField(fieldName: "id");
  static final QueryField USERID = QueryField(fieldName: "userId");
  static final QueryField USERNAME = QueryField(fieldName: "userName");
  static final QueryField EMAIL = QueryField(fieldName: "email");
  static final QueryField PHONE = QueryField(fieldName: "phone");
  static final QueryField BIO = QueryField(fieldName: "bio");
  static final QueryField SOCIAL_LINKS = QueryField(fieldName: "social_links");
  static final QueryField PROFILE_IMAGE = QueryField(fieldName: "profile_image");
  static final QueryField FOLLOWUSERSFOLLOWER = QueryField(
    fieldName: "followUsersFollower",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (FollowUsers).toString()));
  static final QueryField FOLLOWUSERSRECIEVER = QueryField(
    fieldName: "followUsersReciever",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (FollowUsers).toString()));
  static final QueryField FOLLOWCLUBS = QueryField(
    fieldName: "followClubs",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (FollowClubs).toString()));
  static final QueryField CLUBS = QueryField(
    fieldName: "clubs",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Clubs).toString()));
  static final QueryField USERTOPICS = QueryField(
    fieldName: "userTopics",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (UserTopics).toString()));
  static final QueryField USERCHATSENDER = QueryField(
    fieldName: "userChatSender",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (UserChats).toString()));
  static final QueryField USERCHATRECIEVER = QueryField(
    fieldName: "userChatReciever",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (UserChats).toString()));
  static final QueryField PARTICIPANTS = QueryField(
    fieldName: "participants",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Participants).toString()));
  static final QueryField ROOMS = QueryField(
    fieldName: "rooms",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Rooms).toString()));
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Users";
    modelSchemaDefinition.pluralName = "Users";
    
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
      key: Users.USERID,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Users.USERNAME,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Users.EMAIL,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Users.PHONE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Users.BIO,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Users.SOCIAL_LINKS,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Users.PROFILE_IMAGE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: Users.FOLLOWUSERSFOLLOWER,
      isRequired: false,
      ofModelName: (FollowUsers).toString(),
      associatedKey: FollowUsers.USERIDFOLLOWER
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: Users.FOLLOWUSERSRECIEVER,
      isRequired: false,
      ofModelName: (FollowUsers).toString(),
      associatedKey: FollowUsers.USERIDFOLLOWED
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: Users.FOLLOWCLUBS,
      isRequired: false,
      ofModelName: (FollowClubs).toString(),
      associatedKey: FollowClubs.USERID
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: Users.CLUBS,
      isRequired: false,
      ofModelName: (Clubs).toString(),
      associatedKey: Clubs.USERIDFOUNDER
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: Users.USERTOPICS,
      isRequired: false,
      ofModelName: (UserTopics).toString(),
      associatedKey: UserTopics.USERID
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: Users.USERCHATSENDER,
      isRequired: false,
      ofModelName: (UserChats).toString(),
      associatedKey: UserChats.USERIDSENDER
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: Users.USERCHATRECIEVER,
      isRequired: false,
      ofModelName: (UserChats).toString(),
      associatedKey: UserChats.USERIDRECIEVER
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: Users.PARTICIPANTS,
      isRequired: false,
      ofModelName: (Participants).toString(),
      associatedKey: Participants.USERID
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: Users.ROOMS,
      isRequired: false,
      ofModelName: (Rooms).toString(),
      associatedKey: Rooms.FOUNDERID
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

class _UsersModelType extends ModelType<Users> {
  const _UsersModelType();
  
  @override
  Users fromJson(Map<String, dynamic> jsonData) {
    return Users.fromJson(jsonData);
  }
}