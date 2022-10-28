import 'dart:async';
import 'dart:io';
import 'package:amplify_api/amplify_api.dart';
import 'dart:convert';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../amplifyconfiguration.dart';
import '../models/ModelProvider.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as logDev;

class Helper extends ChangeNotifier {
  var uuid = Uuid();

  void configureAmplify() async {
    if (await Amplify.isConfigured) {
      return;
    }
    try {
      await Future.wait([
        Amplify.addPlugins([
          AmplifyAuthCognito(),
          AmplifyDataStore(modelProvider: ModelProvider.instance),
          AmplifyAPI(modelProvider: ModelProvider.instance),
          AmplifyStorageS3(),
        ])
      ]);
      Amplify.configure(amplifyconfig);
      debugPrint('Amplify configured');
    } on AmplifyAlreadyConfiguredException {
      debugPrint('amplify configuration error');
    }
  }

  Future<String?> getEmail() async {
    try {
      final result = await Amplify.Auth.fetchAuthSession();
      if (result.isSignedIn) {
        final authState = await Amplify.Auth.fetchAuthSession(
          options: CognitoSessionOptions(getAWSCredentials: true),
        );
        final identityId =
            parseJwt((authState as CognitoAuthSession).userPoolTokens!.idToken);

        final email = identityId['email'] as String;

        return email;
      }
    } on AmplifyException catch (e) {
      debugPrint(e.toString());
    }
  }

  Map<String, dynamic> parseJwt(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('invalid token');
    }

    final payload = _decodeBase64(parts[1]);
    final payloadMap = json.decode(payload);
    if (payloadMap is! Map<String, dynamic>) {
      throw Exception('invalid payload');
    }

    return payloadMap;
  }

  String _decodeBase64(String str) {
    String output = str.replaceAll('-', '+').replaceAll('_', '/');

    switch (output.length % 4) {
      case 0:
        break;
      case 2:
        output += '==';
        break;
      case 3:
        output += '=';
        break;
      default:
        throw Exception('Illegal base64url string!"');
    }

    return utf8.decode(base64Url.decode(output));
  }

  Future<String?> getImages(String link) async {
    try {
      final result =
          await Amplify.Storage.getUrl(key: link).catchError((error) {});
      return result.url;
    } on StorageException catch (e) {}
  }

  Future<Users?> createAndUploadFileWithOptions(File file, String email) async {
    // Set options
    final options = S3UploadFileOptions(accessLevel: StorageAccessLevel.guest);

    // Upload the file to S3 with options
    try {
      Users test = await Amplify.Storage.uploadFile(
        local: file,
        key: uuid.v4(),
        options: options,
      ).then((value) async {
        final currentUser = await Amplify.DataStore.query(Users.classType,
            where: Users.EMAIL.eq(email));

        final currentUserNewData = currentUser.first.copyWith(
          profile_image: value.key,
        );

        await Amplify.DataStore.save(currentUserNewData);
        return currentUserNewData;
      });
      return test;
    } on StorageException catch (e) {}
  }

  Future<Map> getOpenedRooms(String token) async {
    try {
      const url = 'https://api.videosdk.live/v2/rooms';
      final http.Response response =
          await http.get(Uri.parse(url), headers: {'Authorization': token});

      // logDev.log(
      //     '++++++++++++++++++++++++++++++++++: ${jsonDecode(response.body)['data']}');
      return jsonDecode(response.body);
    } catch (e) {
      return {};
    }
  }
}
