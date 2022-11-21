import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

final token = dotenv.env['TOKEN']!;

Future<String> createMeeting() async {
  final http.Response httpResponse = await http.post(
    Uri.parse("https://api.videosdk.live/v1/meetings"),
    headers: {'Authorization': token},
  );
  return json.decode(httpResponse.body)['meetingId'];
}

Future<void> endMeetingg(String roomId) async {
  final http.Response httpResponse = await http.post(
    Uri.parse("https://api.videosdk.live/v2/sessions/end"),
    headers: {'Authorization': token},
    body: {"roomId": roomId},
  );
}
