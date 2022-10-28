import 'dart:convert';
import 'package:http/http.dart' as http;

String token =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhcGlrZXkiOiJmYzQ0ZDBiNy05NmE3LTQ4NTEtOWQ3Ni00YzgyNzc0ZWRiYzgiLCJwZXJtaXNzaW9ucyI6WyJhbGxvd19qb2luIl0sImlhdCI6MTY2NjgxMzI5MCwiZXhwIjoxNjY3NDE4MDkwfQ.r6gXDjEIdsc5ScYPKW5OjgggYCyIklXA8-ZS_f6UaaE';
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
