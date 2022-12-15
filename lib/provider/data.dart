import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/Users.dart';
import '../helper/helper.dart';

class Data extends ChangeNotifier {
  final Helper helper = Helper();
  List _name = [
    'Roberto Berrys',
    'Ray Kavita',
    'Williams Kishi',
    'Meya Navid',
    'Xansa Ray',
    'Marall 20',
    'General Oklo',
    'Emma',
    'Nihad Ali',
    'Kali',
    'dany deep',
    'Roberto Berry',
    'Ray Kavita',
    'Xansa Ray',
    'Marall 20',
    'General Oklo',
    'Emma',
    'Nihad Ali',
    'Kali',
    'dany deep',
    'Roberto Berry',
    'Ray Kavita',
  ];
  List _photo = [
    '1.jpeg',
    '2.jpeg',
    '3.jpeg',
    '4.jpeg',
    '5.jpeg',
    '6.jpeg',
    '7.jpeg',
    '8.jpeg',
    '9.jpeg',
    '10.jpeg',
    '11.jpeg',
    '1.jpeg',
    '2.jpeg',
    '6.jpeg',
    '7.jpeg',
    '8.jpeg',
    '9.jpeg',
    '10.jpeg',
    '11.jpeg',
    '1.jpeg',
    '2.jpeg',
  ];
  List _topics = [
    'meet people',
    'psychology',
    'authors',
    'programming',
    'networking',
    'education',
    'algebra',
    'self driving cars',
    'physics',
    'mathematics',
    'geology',
    'love',
    'English',
    'meet people',
    'psychology',
    'authors',
    'programming',
    'networking',
    'educatino',
    'algebra',
    'self driving cars',
    'physics',
    'mathematics',
    'geology',
    'love',
    'English',
  ];
  List _messages = [
    'ok bye',
    'sometimes i feel like i am not good',
    'in antoher side that is not good',
    'lets talk about something',
    'nevermind',
    'don\'t worry',
    'sorry, i gotta go',
    'self driving cars',
    'lights so bright when i see them',
    'why do people like to talk about themselves',
    'yes, it is true',
    'all right',
    'hello dude, how is it going?',
  ];
  String _email = '';
  Users? _userData;
  String _profileImage = '';

  get email => _email;

  Users? get userData => _userData;

  Future get getEmail async {
    final prefs = await SharedPreferences.getInstance();
    _email = prefs.getString('email') ?? '';
    notifyListeners();
    return _email;
  }

  Future get getUserData async {
    await Amplify.DataStore.query(Users.classType,
            where: Users.EMAIL.eq(_email))
        .then((value) {
      if (value.isNotEmpty) {
        _userData = value.first;
        notifyListeners();
      }
    });
  }

  get getInternetConnection async {
    final connection = await Connectivity().checkConnectivity();
    return connection;
  }

  get names => _name;

  get photos => _photo;

  get topics => _topics;

  get messages => _messages;

  get profileImage => _profileImage;

  void removeEmail() async {
    _email = '';
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('email');
  }

  void setEmail(String email) async {
    _email = email;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
  }

  void setUserData(Users userData) async {
    _userData = userData;
    notifyListeners();
  }

  Future setProfileImage() async {
    // String? profile_image = '';
    // if (userData.profile_image != null) {
    //   profile_image = await helper.getImages(userData.profile_image ?? '');
    // }
    // _profileImage = profile_image ?? '';
    // notifyListeners();
  }
}
