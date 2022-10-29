import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';

import '../../models/Users.dart';

class SearchForUsersAppBar extends StatefulWidget {
  Future Function(String searchValue)? onSearch;
  SearchForUsersAppBar({Key? key, required this.onSearch}) : super(key: key);

  @override
  State<SearchForUsersAppBar> createState() => _SearchForUsersAppBarState();
}

class _SearchForUsersAppBarState extends State<SearchForUsersAppBar> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AppBar(
        iconTheme: Theme.of(context).iconTheme,
        leadingWidth: 0,
        leading: SizedBox(width: 0),
        elevation: 0,
        titleSpacing: 0,
        toolbarHeight: 38,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(top: 3),
                width: MediaQuery.of(context).size.width * 0.85,
                height: 38,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Theme.of(context).cardColor),
                child: TextField(
                  onChanged: (value) async {
                    await widget.onSearch!(value);
                  },
                  controller: _searchController,
                  cursorColor: Colors.green.shade600,
                  decoration: InputDecoration(
                      suffixIcon: InkWell(
                        onTap: () async {
                          await widget.onSearch!(_searchController.text);
                        },
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                        child: Icon(
                          Icons.search,
                          color: Colors.green.shade600,
                        ),
                      ),
                      hintText: 'Search',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 13)),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Icon(Icons.more_vert),
              )
            ],
          ),
        ));
  }
}
