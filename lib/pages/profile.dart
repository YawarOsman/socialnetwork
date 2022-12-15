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
import '../provider/themeProvider.dart';
import '../submodels/appBars/profileAppBar.dart';
import '../submodels/classModels/style.dart';

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
  late final FocusNode _twitterFocusNode;
  late final FocusNode _instagramFocusNode;
  late final FocusNode _snapchatFocusNode;

  late MediaQueryData mediaQueryData;
  late double swidth;
  late double sheight;
  String tempBioValue = '';
  Map<String, IconData> socialLinkesIcons = {
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
    _twitterFocusNode = FocusNode();
    _instagramFocusNode = FocusNode();
    _snapchatFocusNode = FocusNode();

    socialLinkes =
        jsonDecode(context.read<Data>().userData!.social_links ?? '{}');
    setState(() {});
  }

  @override
  void dispose() {
    _twitterFocusNode.dispose();
    _instagramFocusNode.dispose();
    _snapchatFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    swidth = mediaQueryData.size.width;
    sheight = mediaQueryData.size.height;

    return Consumer4<Data, Log, Helper, ThemeProvider>(
      builder: (context, data, log, helper, themeProvider, child) => Scaffold(
          appBar: PreferredSize(
              preferredSize: const Size.fromHeight(40),
              child: ProfileAppBar(log: log)),
          body: RefreshIndicator(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            color: Colors.blue.shade600,
            onRefresh: () async {
              await data.getUserData;
              final Users userData = data.userData!;
              socialLinkes = jsonDecode(userData.social_links ?? '{}');
              setState(() {});
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
                                borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(50))),
                            margin: const EdgeInsets.only(bottom: 60),
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
                                                      data.userData!.userName!,
                                                      style: const TextStyle(
                                                          fontSize: 23,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    const SizedBox(
                                                      width: 8,
                                                    ),
                                                    const Icon(
                                                      Icons.edit,
                                                      color: Colors.white,
                                                      size: 16,
                                                    )
                                                  ],
                                                )),
                                            const SizedBox(
                                              height: 3,
                                            ),
                                            Text(
                                              data.userData!.email!,
                                              style: const TextStyle(
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
                                            children: const [
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
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Column(
                                            children: const [
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
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Column(
                                            children: const [
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
                                            child: const Icon(
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
                                              text: data.userData!.bio != ''
                                                  ? data.userData!.bio ??
                                                      'Add bio'
                                                  : 'Add bio',
                                              children: const [
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
                                    ],
                                  ),
                                ),
                                socialLinks(data)
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
                                const Text(
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
                            padding: const EdgeInsets.only(left: 10),
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: data.names.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) =>
                                    GestureDetector(
                                      onTap: () {},
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 13),
                                        child: Card(
                                          elevation: 2,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Container(
                                            width: swidth / 2.5,
                                            alignment: Alignment.bottomCenter,
                                            padding:
                                                const EdgeInsets.only(top: 10),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: themeProvider.isDark
                                                  ? const Color.fromARGB(
                                                      255, 34, 34, 34)
                                                  : const Color.fromARGB(
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
                                                            style: const TextStyle(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                          Text(
                                                            '3 room weekly',
                                                            style: TextStyle(
                                                                fontSize: 11,
                                                                color: themeProvider
                                                                        .isDark
                                                                    ? const Color
                                                                            .fromARGB(
                                                                        255,
                                                                        105,
                                                                        105,
                                                                        105)
                                                                    : const Color
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
                                                : Align(
                                                    alignment: Alignment.center,
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
                                                  ),
                                          ),
                                        ),
                                      ),
                                    )),
                          ),
                          const SizedBox(
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
                                const Text(
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
                            padding: const EdgeInsets.only(left: 10),
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: data.names.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) =>
                                    GestureDetector(
                                      onTap: () {},
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 13),
                                        child: Card(
                                          elevation: 2,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Container(
                                            width: swidth / 2.5,
                                            alignment: Alignment.bottomCenter,
                                            padding:
                                                const EdgeInsets.only(top: 10),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: themeProvider.isDark
                                                  ? const Color.fromARGB(
                                                      255, 34, 34, 34)
                                                  : const Color.fromARGB(
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
                                                      style: const TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    Text(
                                                      '3 room weekly',
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          color: themeProvider
                                                                  .isDark
                                                              ? const Color
                                                                      .fromARGB(
                                                                  255,
                                                                  105,
                                                                  105,
                                                                  105)
                                                              : const Color
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
                        padding: const EdgeInsets.only(
                            top: 30, bottom: 20, left: 13),
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
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                  width: swidth,
                                  child: Wrap(
                                    children: List.generate(
                                        data.topics.length,
                                        (index) => Container(
                                              margin: const EdgeInsets.only(
                                                  right: 13, top: 13),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 13,
                                                      vertical: 3),
                                              decoration: BoxDecoration(
                                                  color: themeProvider.isDark
                                                      ? const Color.fromARGB(
                                                          255, 34, 34, 34)
                                                      : const Color.fromARGB(
                                                          255, 244, 244, 244),
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              child: Text(
                                                data.topics[index],
                                                style: const TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ))
                                      ..add(Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 20),
                                            child: Row(
                                              children: const [
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
                                          data.userData!.profile_image!),
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
                        title: const Text(
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
                        title: const Text(
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
                        title: const Text(
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
      _bioController.text = context.read<Data>().userData!.bio ?? '';

      showDialog(
          context: context,
          builder: (builderContext) => StatefulBuilder(
                builder: (stfContext, stfSetState) => AlertDialog(
                  titlePadding:
                      const EdgeInsets.only(left: 25, top: 15, bottom: 20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 25),
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
                          contentPadding: const EdgeInsets.all(10),
                          hintText: 'Write your bio',
                          hintStyle: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  width: 0.3, color: Colors.grey)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  width: 0.5,
                                  color: Theme.of(context).iconTheme.color!))),
                    ),
                  ),
                  title: const Text('Bio', style: TextStyle(fontSize: 15)),
                  actions: [
                    TextButton(
                        onPressed: () async {
                          Navigator.pop(context);
                          _bioController.clear();
                        },
                        child: const Text('Cancel')),
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
                        child: const Text('Save'))
                  ],
                ),
              ));
    };
  }

  Widget socialLinks(Data data) {
    return Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 35),
        child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            direction: Axis.horizontal,
            children: List.generate(socialLinkes.length + 1, (index) {
              if (index < socialLinkes.length) {
                return InkWell(
                  onTap: () async {
                    if (socialLinkes.keys.elementAt(index) == 'twitter') {
                      String twitterWebsite = 'https://twitter.com/';
                      twitterWebsite += socialLinkes.values.elementAt(index);
                      final Uri url = Uri.parse(twitterWebsite);
                      await launchUrl(url);
                    } else if (socialLinkes.keys.elementAt(index) ==
                        'instagram') {
                      String instagramWebsite = 'https://www.instagram.com/';
                      instagramWebsite += socialLinkes.values.elementAt(index);
                      final Uri url = Uri.parse(instagramWebsite);
                      await launchUrl(url);
                    } else if (socialLinkes.keys.elementAt(index) ==
                        'snapchat') {
                      String snapchatWebsite = 'https://www.snapchat.com/add/';
                      snapchatWebsite += socialLinkes.values.elementAt(index);
                      final Uri url = Uri.parse(snapchatWebsite);
                      await launchUrl(url);
                    }
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 6, bottom: 6, right: 12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FaIcon(
                          socialLinkesIcons[socialLinkes.keys.elementAt(index)],
                          color: Colors.blue.shade600,
                          size: 15,
                        ),
                        const SizedBox(width: 7),
                        Text(
                          socialLinkes.values.elementAt(index),
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.blue.shade600,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
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
                      if (key == 'instagram') _instagramController.text = value;
                      if (key == 'twitter') _twitterController.text = value;
                      if (key == 'snapchat') _snapchatController.text = value;
                    });
                    showDialog(
                        context: context,
                        builder: (dialogContext) =>
                            onAddSocialLinkTapped(data));
                  },
                  child: socialLinkes.isNotEmpty
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
                            const SizedBox(width: 5),
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
            })));
  }

  Widget onAddSocialLinkTapped(Data data) {
    return StatefulBuilder(
        builder: (dialogContext, dialogSetState) => AlertDialog(
              titlePadding:
                  const EdgeInsets.only(left: 25, top: 15, bottom: 20),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              content: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                      itemCount: 3,
                      physics: const NeverScrollableScrollPhysics(),
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
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: SizedBox(
                                    width: 20,
                                    child: FaIcon(socialLinkesIcons.values
                                        .elementAt(index)),
                                  ),
                                ),
                                Expanded(
                                  child: TextField(
                                    controller: index == 0
                                        ? _twitterController
                                        : index == 1
                                            ? _instagramController
                                            : index == 2
                                                ? _snapchatController
                                                : null,
                                    focusNode: index == 0
                                        ? _twitterFocusNode
                                        : index == 1
                                            ? _instagramFocusNode
                                            : index == 2
                                                ? _snapchatFocusNode
                                                : null,
                                    textAlignVertical: TextAlignVertical.center,
                                    decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 0),
                                        focusedBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.transparent,
                                            width: 0,
                                          ),
                                        ),
                                        enabledBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.transparent,
                                            width: 0,
                                          ),
                                        ),
                                        border: InputBorder.none,
                                        hintText:
                                            '${socialLinkesIcons.keys.elementAt(index)} username',
                                        hintStyle:
                                            const TextStyle(fontSize: 14)),
                                  ),
                                )
                              ],
                            ),
                          ),
                          trailing: InkWell(
                            onTap: () {
                              deleteSocialLinks(data, twitter, instagram,
                                  snapchat, index, dialogSetState);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Icon(
                                twitter
                                    ? FontAwesomeIcons.trashCan
                                    : instagram
                                        ? FontAwesomeIcons.trashCan
                                        : snapchat
                                            ? FontAwesomeIcons.trashCan
                                            : FontAwesomeIcons.plus,
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
                            dialogSetState(() {
                              socialLinksIndex = index;
                            });
                          },
                        );
                      })),
              title: const Text('Social Links', style: TextStyle(fontSize: 15)),
              actions: [
                TextButton(
                    onPressed: () async {
                      Navigator.pop(context);
                      socialLinksIndex = -1;
                    },
                    child: const Text('cancel')),
                TextButton(
                    onPressed: () async {
                      Navigator.pop(context);
                      socialLinksIndex = -1;

                      if (_twitterController.text.isNotEmpty) {
                        socialLinkes['twitter'] = _twitterController.text;
                      } else {
                        socialLinkes.remove('twitter');
                      }
                      if (_instagramController.text.isNotEmpty) {
                        socialLinkes['instagram'] = _instagramController.text;
                      } else {
                        socialLinkes.remove('instagram');
                      }
                      if (_snapchatController.text.isNotEmpty) {
                        socialLinkes['snapchat'] = _snapchatController.text;
                      } else {
                        socialLinkes.remove('snapchat');
                      }

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
                    child: const Text('save')),
              ],
            ));
  }

  void updateProfilePicture(selectedPicture) async {
    if (selectedPicture == null) {
      showDialog(
          context: context,
          builder: (context) => const AlertDialog(
                title: Text('No image selected'),
              ));
      return;
    }
    Navigator.pop(context);
    final email = Provider.of<Data>(context, listen: false).email;
    await Provider.of<Helper>(context, listen: false)
        .createAndUploadFileWithOptions(File(selectedPicture.path), email)
        .then((value) {
      if (value == '') return;
      Data provider = Provider.of<Data>(context, listen: false);
      provider.setUserData(value!);
      provider.setProfileImage();
    });
    setState(() {});
  }

  VoidCallback onNameTapped(data) {
    return () {
      _nameController.text = context.read<Data>().userData!.userName!;
      showDialog(
          context: context,
          builder: (builderContext) => StatefulBuilder(
                builder: (stfContext, stfSetState) => AlertDialog(
                  titlePadding:
                      const EdgeInsets.only(left: 25, top: 15, bottom: 20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 25),
                  content: SizedBox(
                    width: MediaQuery.of(context).size.width - 120,
                    child: TextField(
                      controller: _nameController,
                      maxLength: 20,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10),
                          hintText: 'Enter your new name',
                          hintStyle: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  width: 0.3, color: Colors.grey)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  width: 0.5,
                                  color: Theme.of(context).iconTheme.color!))),
                    ),
                  ),
                  title: const Text('Change your name',
                      style: TextStyle(fontSize: 15)),
                  actions: [
                    TextButton(
                        onPressed: () async {
                          Navigator.pop(context);
                          _bioController.clear();
                        },
                        child: const Text('Cancel')),
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
                        child: const Text('Save'))
                  ],
                ),
              ));
    };
  }

  void deleteSocialLinks(Data data, bool twitter, bool instagram, bool snapchat,
      int index, Function dialogSetState) {
    deleteMessage() {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                content: const Text(
                    'Are you sure you want to delete this social link?'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('cancel')),
                  TextButton(
                      onPressed: () async {
                        if (twitter) {
                          _twitterController.clear();
                          socialLinkes.remove('twitter');
                        } else if (instagram) {
                          _instagramController.clear();
                          socialLinkes.remove('instagram');
                        } else if (snapchat) {
                          _snapchatController.clear();
                          socialLinkes.remove('snapchat');
                        }
                        dialogSetState(() {
                          socialLinksIndex = index;
                        });
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
                        Navigator.pop(context);
                      },
                      child: const Text('delete'))
                ],
              ));
    }

    if (twitter) {
      socialLinksIndex = index;
      deleteMessage();

      return;
    } else if (instagram) {
      socialLinksIndex = index;
      deleteMessage();

      return;
    } else if (snapchat) {
      socialLinksIndex = index;
      deleteMessage();
      return;
    }

    if (!twitter && index == 0) {
      _twitterFocusNode.requestFocus();
    } else if (!instagram && index == 1) {
      _instagramFocusNode.requestFocus();
    } else if (!snapchat && index == 2) {
      _snapchatFocusNode.requestFocus();
    }
  }
}
