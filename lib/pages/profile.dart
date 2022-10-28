import 'dart:convert';
import 'dart:io';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/Users.dart';
import '../helper/helper.dart';
import '../provider/data.dart';
import '../provider/log.dart';
import '../submodels/style.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _twitterController = TextEditingController();
  final TextEditingController _instagramController = TextEditingController();
  final TextEditingController _snapchatController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  late MediaQueryData mediaQueryData;
  late double swidth;
  late double sheight;
  String tempBioValue = '';
  Map<String, IconData> socialLinkesData = {
    'twitter': FontAwesomeIcons.twitter,
    'instagram': FontAwesomeIcons.instagram,
    'snapchat': FontAwesomeIcons.snapchat,
  };
  Map<String, dynamic> socialLinkes = {};
  int socialLinksIndex = -1;
  Style style = Style();

  @override
  void initState() {
    super.initState();
    socialLinkes =
        jsonDecode(context.read<Data>().userData.social_links ?? '{}');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    swidth = mediaQueryData.size.width;
    sheight = mediaQueryData.size.height;

    return Consumer3<Data, Log, Helper>(
      builder: (context, data, log, helper, child) => Scaffold(
          appBar: AppBar(
            elevation: 0,
            automaticallyImplyLeading: false,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.green.shade700, Colors.green.shade400]),
              ),
            ),
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.arrow_back_ios,
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 13),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Icon(
                          Icons.bookmark_outline,
                          size: 25,
                        ),
                      ),
                      SizedBox(
                        width: 17,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Icon(
                          log.deviceType == TargetPlatform.iOS
                              ? Icons.ios_share_outlined
                              : Icons.share_outlined,
                          size: 25,
                        ),
                      ),
                      SizedBox(
                        width: 17,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/settings');
                        },
                        child: Icon(
                          Icons.settings_outlined,
                          size: 25,
                        ),
                      ),
                    ]),
              ),
            ],
            iconTheme: Theme.of(context).iconTheme,
            textTheme: Theme.of(context).textTheme,
            toolbarHeight: 40,
            titleSpacing: 0,
          ),
          body: RefreshIndicator(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            color: Colors.blue.shade600,
            onRefresh: () async {
              await Amplify.DataStore.query(Users.classType,
                      where: Users.EMAIL.eq(data.email))
                  .then((value) {
                data.setUserData(value.first);
                //todo
                data.setProfileImage();
                print(value.first);
              });
            },
            child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (overscroll) {
                overscroll.disallowIndicator();
                return true;
              },
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Container(
                            height: 87,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.green.shade700,
                                    Colors.green.shade400
                                  ],
                                ),
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(50))),
                            margin: EdgeInsets.only(bottom: 60),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 13),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, bottom: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 30),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            GestureDetector(
                                                onTap: onNameTapped(data),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      data.userData.userName!,
                                                      style: TextStyle(
                                                          fontSize: 23,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    SizedBox(
                                                      width: 8,
                                                    ),
                                                    Icon(
                                                      Icons.edit,
                                                      color: Colors.white,
                                                      size: 16,
                                                    )
                                                  ],
                                                )),
                                            SizedBox(
                                              height: 3,
                                            ),
                                            Text(
                                              data.userData.email!,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Column(
                                            children: [
                                              Text(
                                                '0',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              Text(
                                                ' clubs',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Column(
                                            children: [
                                              Text(
                                                '12',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              Text(
                                                ' following',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Column(
                                            children: [
                                              Text(
                                                '8',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              Text(
                                                ' followers',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: onProfilePictureTapped(),
                                  child: data.profileImage != ''
                                      ? CircleAvatar(
                                          radius: mediaQueryData.orientation ==
                                                  Orientation.portrait
                                              ? swidth / 7.1
                                              : sheight / 6.3,
                                          backgroundColor: Colors.grey,
                                          child: CircleAvatar(
                                              radius:
                                                  mediaQueryData.orientation ==
                                                          Orientation.portrait
                                                      ? swidth / 7.3
                                                      : sheight / 6.5,
                                              backgroundColor: Colors.grey,
                                              backgroundImage:
                                                  CachedNetworkImageProvider(
                                                data.profileImage,
                                              )),
                                        )
                                      : CircleAvatar(
                                          radius: mediaQueryData.orientation ==
                                                  Orientation.portrait
                                              ? swidth / 7.1
                                              : sheight / 6.3,
                                          backgroundColor: Colors.grey,
                                          child: CircleAvatar(
                                            radius:
                                                mediaQueryData.orientation ==
                                                        Orientation.portrait
                                                    ? swidth / 7.3
                                                    : sheight / 6.5,
                                            backgroundColor: Theme.of(context)
                                                .scaffoldBackgroundColor,
                                            child: Icon(
                                              Icons.person,
                                              size: 70,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                          padding: const EdgeInsets.only(
                              right: 13, left: 35, top: 8),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: onBioTapped(data),
                                  child: Wrap(
                                    children: [
                                      RichText(
                                          text: TextSpan(
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge!
                                                      .color,
                                                  fontWeight: FontWeight.w500),
                                              text: data.userData.bio != ''
                                                  ? data.userData.bio ??
                                                      'Add bio'
                                                  : 'Add bio',
                                              children: [
                                            WidgetSpan(
                                                child: SizedBox(
                                              width: 10,
                                            )),
                                            WidgetSpan(
                                                child: Icon(
                                              Icons.edit,
                                              size: 13,
                                            ))
                                          ])),
                                      // Text(
                                      //   data.userData.bio ?? 'Add bio',
                                      //   style: TextStyle(
                                      //       fontSize: 12,
                                      //       fontWeight: FontWeight.w500),
                                      // ),
                                    ],
                                  ),
                                ),
                                socialLinks(context, data)
                              ])),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 13),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'clubs you\'re admin in',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                      color: Theme.of(context).primaryColor),
                                ),
                                Text(
                                  'Show All',
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12),
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: 185,
                            padding: EdgeInsets.only(left: 10),
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: data.names.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) =>
                                    GestureDetector(
                                      onTap: () {},
                                      child: Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 13),
                                        child: Card(
                                          elevation: 2,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Container(
                                            width: swidth / 2.5,
                                            alignment: Alignment.bottomCenter,
                                            padding: EdgeInsets.only(top: 10),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: log.isDark
                                                  ? Color.fromARGB(
                                                      255, 34, 34, 34)
                                                  : Color.fromARGB(
                                                      255, 244, 244, 244),
                                            ),
                                            child: index > 0
                                                ? Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Column(
                                                        children: [
                                                          Text(
                                                            data.names[index],
                                                            style: TextStyle(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                          Text(
                                                            '3 room weekly',
                                                            style: TextStyle(
                                                                fontSize: 11,
                                                                color: log
                                                                        .isDark
                                                                    ? Color
                                                                        .fromARGB(
                                                                            255,
                                                                            105,
                                                                            105,
                                                                            105)
                                                                    : Color
                                                                        .fromARGB(
                                                                            255,
                                                                            66,
                                                                            66,
                                                                            66)),
                                                          ),
                                                        ],
                                                      ),
                                                      Container(
                                                        alignment:
                                                            Alignment.topCenter,
                                                        width: swidth / 2.5,
                                                        height: 95,
                                                        decoration:
                                                            BoxDecoration(
                                                          image: DecorationImage(
                                                              fit: BoxFit.cover,
                                                              image: AssetImage(
                                                                  'assets/images/${data.photos[index]}')),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                : Container(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          Icons.add,
                                                          color: Colors
                                                              .blue.shade600,
                                                        ),
                                                        Text(
                                                          'Create new club',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: Colors.blue
                                                                  .shade600),
                                                        ),
                                                      ],
                                                    ),
                                                    alignment: Alignment.center,
                                                  ),
                                          ),
                                        ),
                                      ),
                                    )),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 13),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'clubs you\'re in',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                      color: Theme.of(context).primaryColor),
                                ),
                                Text(
                                  'Show All',
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12),
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: 185,
                            padding: EdgeInsets.only(left: 10),
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: data.names.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) =>
                                    GestureDetector(
                                      onTap: () {},
                                      child: Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 13),
                                        child: Card(
                                          elevation: 2,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Container(
                                            width: swidth / 2.5,
                                            alignment: Alignment.bottomCenter,
                                            padding: EdgeInsets.only(top: 10),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: log.isDark
                                                  ? Color.fromARGB(
                                                      255, 34, 34, 34)
                                                  : Color.fromARGB(
                                                      255, 244, 244, 244),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  children: [
                                                    Text(
                                                      data.names[index],
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    Text(
                                                      '3 room weekly',
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          color: log.isDark
                                                              ? Color.fromARGB(
                                                                  255,
                                                                  105,
                                                                  105,
                                                                  105)
                                                              : Color.fromARGB(
                                                                  255,
                                                                  66,
                                                                  66,
                                                                  66)),
                                                    ),
                                                  ],
                                                ),
                                                Container(
                                                  alignment:
                                                      Alignment.topCenter,
                                                  width: swidth / 2.5,
                                                  height: 95,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: AssetImage(
                                                            'assets/images/${data.photos[index]}')),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    )),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 30, bottom: 20, left: 13),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Topics to Follow',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Theme.of(context).primaryColor),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                  width: swidth,
                                  child: Wrap(
                                    children: List.generate(
                                        data.topics.length,
                                        (index) => Container(
                                              margin: EdgeInsets.only(
                                                  right: 13, top: 13),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 13, vertical: 3),
                                              decoration: BoxDecoration(
                                                  color: log.isDark
                                                      ? Color.fromARGB(
                                                          255, 34, 34, 34)
                                                      : Color.fromARGB(
                                                          255, 244, 244, 244),
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              child: Text(
                                                data.topics[index],
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ))
                                      ..add(Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                vertical: 20),
                                            child: Row(
                                              children: [
                                                Text('Show all topics'),
                                                Icon(Icons.arrow_drop_down)
                                              ],
                                            ),
                                          ),
                                        ],
                                      )),
                                  ))
                            ]),
                      )
                    ]),
              ),
            ),
          )),
    );
  }

  VoidCallback onProfilePictureTapped() {
    return () {
      File selectedProfilePicture;
      showDialog(
          context: context,
          builder: (alertContext) => AlertDialog(
                title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        onTap: () async {
                          final helper =
                              Provider.of<Helper>(context, listen: false);
                          final data =
                              Provider.of<Data>(context, listen: false);
                          showDialog(
                              context: context,
                              builder: (viewImageContext) => Container(
                                  width: double.infinity,
                                  height: double.infinity,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: FutureBuilder(
                                      future: helper.getImages(
                                          data.userData.profile_image!),
                                      builder: ((context, snapshot) {
                                        return InteractiveViewer(
                                          child: Image.network(
                                            snapshot.data.toString(),
                                            errorBuilder: ((context, error,
                                                    stackTrace) =>
                                                Container(
                                                  width: 50,
                                                  height: 50,
                                                  color: Colors.grey.shade600,
                                                )),
                                            fit: BoxFit.cover,
                                          ),
                                        );
                                      }),
                                    ),
                                  )));
                        },
                        title: Text(
                          'View profile picture',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                      ListTile(
                        onTap: () async {
                          final selectedPicture = await ImagePicker()
                              .pickImage(source: ImageSource.camera);
                          updateProfilePicture(selectedPicture);
                        },
                        title: Text(
                          'Take a picture',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                      ListTile(
                        onTap: () async {
                          XFile? selectedProfilePicture = await ImagePicker()
                              .pickImage(source: ImageSource.gallery);
                          updateProfilePicture(selectedProfilePicture);
                        },
                        title: Text(
                          'Choose from gallery',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                    ]),
              ));
    };
  }

  VoidCallback onBioTapped(data) {
    return () {
      _bioController.text = context.read<Data>().userData.bio ?? '';

      showDialog(
          context: context,
          builder: (builderContext) => StatefulBuilder(
                builder: (stfContext, stfSetState) => AlertDialog(
                  titlePadding: EdgeInsets.only(left: 25, top: 15, bottom: 20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 25),
                  content: SizedBox(
                    width: MediaQuery.of(context).size.width - 120,
                    child: TextField(
                      controller: _bioController,
                      maxLines: 4,
                      maxLength: 100,
                      onChanged: (value) {
                        // remove newline
                        value = value.replaceAll('\n', '');
                        tempBioValue = _bioController.text = value;
                        _bioController.selection = TextSelection.fromPosition(
                            TextPosition(offset: _bioController.text.length));
                        if (tempBioValue.length < value.length) return;
                      },
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          hintText: 'Write your bio',
                          hintStyle: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  BorderSide(width: 0.3, color: Colors.grey)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  width: 0.5,
                                  color: Theme.of(context).iconTheme.color!))),
                    ),
                  ),
                  title: Text('Bio', style: TextStyle(fontSize: 15)),
                  actions: [
                    TextButton(
                        onPressed: () async {
                          Navigator.pop(context);
                          _bioController.clear();
                        },
                        child: Text('Cancel')),
                    TextButton(
                        onPressed: () async {
                          Navigator.pop(context);

                          try {
                            final userData = await Amplify.DataStore.query(
                                Users.classType,
                                where: Users.EMAIL.eq(data.email));
                            final updated = userData.first
                                .copyWith(bio: _bioController.text);
                            await Amplify.DataStore.save(updated)
                                .then((value) async {
                              context.read<Data>().setUserData(updated);
                            });
                          } catch (e) {
                            debugPrint(e.toString());
                          }
                        },
                        child: Text('Save'))
                  ],
                ),
              ));
    };
  }

  Padding socialLinks(BuildContext context, Data data) {
    return Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 35),
        child: Container(
            child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                direction: Axis.horizontal,
                children: List.generate(socialLinkes.length + 1, (index) {
                  if (index < socialLinkes.length) {
                    return InkWell(
                      onTap: () async {
                        if (socialLinkes.keys.elementAt(index) == 'twitter') {
                          String twitterWebsite = 'https://twitter.com/';
                          twitterWebsite +=
                              socialLinkes.values.elementAt(index);
                          final Uri url = Uri.parse(twitterWebsite);
                          await launchUrl(url);
                        } else if (socialLinkes.keys.elementAt(index) ==
                            'instagram') {
                          String instagramWebsite =
                              'https://www.instagram.com/';
                          instagramWebsite +=
                              socialLinkes.values.elementAt(index);
                          final Uri url = Uri.parse(instagramWebsite);
                          await launchUrl(url);
                        } else if (socialLinkes.keys.elementAt(index) ==
                            'snapchat') {
                          String snapchatWebsite =
                              'https://www.snapchat.com/add/';
                          snapchatWebsite +=
                              socialLinkes.values.elementAt(index);
                          final Uri url = Uri.parse(snapchatWebsite);
                          await launchUrl(url);
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            FaIcon(
                              socialLinkesData[
                                  socialLinkes.keys.elementAt(index)],
                              color: Colors.blue.shade600,
                              size: 15,
                            ),
                            SizedBox(width: 11),
                            Text(
                              socialLinkes.values.elementAt(index),
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.blue.shade600,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              width: 7,
                            )
                          ],
                        ),
                      ),
                    );
                  } else {
                    return GestureDetector(
                      onTap: () async {
                        socialLinkes.forEach((key, value) {
                          if (key == 'instagram')
                            _instagramController.text = value;
                          if (key == 'twitter') _twitterController.text = value;
                          if (key == 'snapchat')
                            _snapchatController.text = value;
                        });
                        showDialog(
                            context: context,
                            builder: (dialogContext) =>
                                dialogWhenAddSocialLinkTapped(data));
                      },
                      child: socialLinkes.length > 0
                          ? Icon(
                              Icons.edit,
                              color: Colors.blue.shade600,
                              size: 13,
                            )
                          : Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.add,
                                  color: Colors.blue.shade600,
                                  size: 16,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  'Add social link',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.blue.shade600),
                                ),
                              ],
                            ),
                    );
                  }
                  ;
                }))));
  }

  Widget dialogWhenAddSocialLinkTapped(data) {
    return StatefulBuilder(
        builder: (stfContext, stfSetState) => AlertDialog(
              titlePadding: EdgeInsets.only(left: 25, top: 15, bottom: 20),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              content: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                      itemCount: 3,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (builderContext, index) {
                        bool twitter =
                            index == 0 && _twitterController.text.isNotEmpty;
                        bool instagram =
                            index == 1 && _instagramController.text.isNotEmpty;
                        bool snapchat =
                            index == 2 && _snapchatController.text.isNotEmpty;
                        return ListTile(
                          focusColor: Colors.transparent,
                          leading: SizedBox(
                            width: MediaQuery.of(context).size.width / 1.7,
                            child: socialLinksIndex == index
                                ? Container(
                                    height: 35,
                                    child: TextField(
                                      controller: index == 0
                                          ? _twitterController
                                          : index == 1
                                              ? _instagramController
                                              : index == 2
                                                  ? _snapchatController
                                                  : null,
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 0),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(3),
                                            borderSide: BorderSide(
                                              color: Colors.blue.shade600,
                                              width: 1,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(3),
                                            borderSide: BorderSide(
                                              color: Colors.blue.shade600,
                                              width: 1,
                                            ),
                                          ),
                                          hintText:
                                              '${socialLinkesData.keys.elementAt(socialLinksIndex)} username',
                                          hintStyle: TextStyle(fontSize: 14)),
                                    ),
                                  )
                                : Row(
                                    children: [
                                      FaIcon(socialLinkesData.values
                                          .elementAt(index)),
                                      SizedBox(
                                        width: 40,
                                      ),
                                      Text(socialLinkesData.keys
                                          .elementAt(index))
                                    ],
                                  ),
                          ),
                          trailing: InkWell(
                            onTap: () {
                              deleteMessage() {
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          content: Text(
                                              'Are you sure you want to delete this social link?'),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text('cancel')),
                                            TextButton(
                                                onPressed: () async {
                                                  if (twitter) {
                                                    _twitterController.clear();
                                                    socialLinkes
                                                        .remove('twitter');
                                                  } else if (instagram) {
                                                    _instagramController
                                                        .clear();
                                                    socialLinkes
                                                        .remove('instagram');
                                                  } else if (snapchat) {
                                                    _snapchatController.clear();
                                                    socialLinkes
                                                        .remove('snapchat');
                                                  }

                                                  try {
                                                    //this piece of code is to update social links
                                                    final userData =
                                                        await Amplify.DataStore
                                                            .query(
                                                                Users.classType,
                                                                where: Users
                                                                    .EMAIL
                                                                    .eq(data
                                                                        .email));
                                                    final updated =
                                                        userData.first.copyWith(
                                                            social_links:
                                                                jsonEncode(
                                                                    socialLinkes));
                                                    await Amplify.DataStore
                                                            .save(updated)
                                                        .then((value) async {
                                                      context
                                                          .read<Data>()
                                                          .setUserData(updated);
                                                    });
                                                  } catch (e) {
                                                    debugPrint(e.toString());
                                                  }
                                                  stfSetState(() {
                                                    Navigator.pop(context);
                                                  });
                                                },
                                                child: Text('delete'))
                                          ],
                                        ));
                              }

                              if (twitter) {
                                stfSetState(() {
                                  socialLinksIndex = index;
                                });
                                deleteMessage();
                                return;
                              }
                              if (instagram) {
                                stfSetState(() {
                                  socialLinksIndex = index;
                                });
                                deleteMessage();
                                return;
                              }
                              if (snapchat) {
                                stfSetState(() {
                                  socialLinksIndex = index;
                                });
                                deleteMessage();
                                return;
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              color: Colors.blue.shade600,
                              child: Icon(
                                twitter
                                    ? FontAwesomeIcons.trashCan
                                    : instagram
                                        ? FontAwesomeIcons.trashCan
                                        : snapchat
                                            ? FontAwesomeIcons.trashCan
                                            : FontAwesomeIcons.add,
                                size: 16,
                                color: twitter
                                    ? Colors.red
                                    : instagram
                                        ? Colors.red
                                        : snapchat
                                            ? Colors.red
                                            : Colors.blue.shade600,
                              ),
                            ),
                          ),
                          onTap: () {
                            stfSetState(() {
                              socialLinksIndex = index;
                            });
                          },
                        );
                      })),
              title: Text('Social Links', style: TextStyle(fontSize: 15)),
              actions: [
                TextButton(
                    onPressed: () async {
                      Navigator.pop(context);
                      socialLinksIndex = -1;
                    },
                    child: Text('cancel')),
                TextButton(
                    onPressed: () async {
                      Navigator.pop(context);
                      socialLinksIndex = -1;

                      if (_twitterController.text.isNotEmpty)
                        socialLinkes['twitter'] = _twitterController.text;
                      else
                        socialLinkes.remove('twitter');
                      if (_instagramController.text.isNotEmpty)
                        socialLinkes['instagram'] = _instagramController.text;
                      else
                        socialLinkes.remove('instagram');
                      if (_snapchatController.text.isNotEmpty)
                        socialLinkes['snapchat'] = _snapchatController.text;
                      else
                        socialLinkes.remove('snapchat');

                      _twitterController.clear();
                      _instagramController.clear();
                      _snapchatController.clear();

                      try {
                        //this piece of code is to update social links
                        final userData = await Amplify.DataStore.query(
                            Users.classType,
                            where: Users.EMAIL.eq(data.email));
                        final updated = userData.first
                            .copyWith(social_links: jsonEncode(socialLinkes));
                        await Amplify.DataStore.save(updated)
                            .then((value) async {
                          context.read<Data>().setUserData(updated);
                        });
                      } catch (e) {
                        debugPrint(e.toString());
                      }
                    },
                    child: Text('save')),
              ],
            ));
  }

  updateProfilePicture(selectedPicture) async {
    if (selectedPicture == null) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('No image selected'),
              ));
      return;
    }
    Navigator.pop(context);
    final email = Provider.of<Data>(context, listen: false).email;
    await Provider.of<Helper>(context, listen: false)
        .createAndUploadFileWithOptions(File(selectedPicture.path), email)
        .then((value) {
      if (value != '') {
        dynamic provider = Provider.of<Data>(context, listen: false);
        provider.setUserData(value!);
        provider.setProfileImage();
      }
    });
    setState(() {});
  }

  VoidCallback onNameTapped(data) {
    return () {
      _nameController.text = context.read<Data>().userData.userName!;

      showDialog(
          context: context,
          builder: (builderContext) => StatefulBuilder(
                builder: (stfContext, stfSetState) => AlertDialog(
                  titlePadding: EdgeInsets.only(left: 25, top: 15, bottom: 20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 25),
                  content: SizedBox(
                    width: MediaQuery.of(context).size.width - 120,
                    child: TextField(
                      controller: _nameController,
                      maxLength: 20,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          hintText: 'Enter your new name',
                          hintStyle: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  BorderSide(width: 0.3, color: Colors.grey)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  width: 0.5,
                                  color: Theme.of(context).iconTheme.color!))),
                    ),
                  ),
                  title:
                      Text('Change your name', style: TextStyle(fontSize: 15)),
                  actions: [
                    TextButton(
                        onPressed: () async {
                          Navigator.pop(context);
                          _bioController.clear();
                        },
                        child: Text('Cancel')),
                    TextButton(
                        onPressed: () async {
                          bool isSure = false;
                          Navigator.pop(context);
                          try {
                            final userData = await Amplify.DataStore.query(
                                Users.classType,
                                where: Users.EMAIL.eq(data.email));
                            final updated = userData.first
                                .copyWith(userName: _nameController.text);
                            await Amplify.DataStore.save(updated)
                                .then((value) async {
                              context.read<Data>().setUserData(updated);
                            });
                          } catch (e) {
                            debugPrint(e.toString());
                          }
                        },
                        child: Text('Save'))
                  ],
                ),
              ));
    };
  }
}
