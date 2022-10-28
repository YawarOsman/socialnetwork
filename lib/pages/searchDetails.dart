import 'package:flutter/material.dart';

class SearchDetails extends StatefulWidget {
  const SearchDetails({Key? key}) : super(key: key);

  @override
  State<SearchDetails> createState() => _SearchDetailState();
}

class _SearchDetailState extends State<SearchDetails> {
  bool _searchType = true;
  final TextEditingController _searchController = TextEditingController();
  late FocusNode _searchFocusNode;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _searchFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _searchFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _searchFocusNode.requestFocus();
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
            iconTheme: Theme.of(context).iconTheme,
            leadingWidth: 0,
            leading: SizedBox(width: 0),
            elevation: _searchType ? 0 : 0.5,
            titleSpacing: 0,
            toolbarHeight: _searchType ? 38 : 43,
            bottom: _searchType
                ? null
                : PreferredSize(
                    preferredSize: Size(MediaQuery.of(context).size.width, 30),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.only(top: 5),
                      margin: EdgeInsets.only(top: 5),
                      height: 30,
                      child: TabBar(
                          labelColor: Theme.of(context).iconTheme.color,
                          padding: EdgeInsets.zero,
                          splashBorderRadius: BorderRadius.circular(8),
                          indicatorColor: Colors.green.shade600,
                          indicatorSize: TabBarIndicatorSize.label,
                          labelStyle: TextStyle(fontSize: 12),
                          tabs: [
                            Tab(
                              child: Text('All'),
                            ),
                            Tab(
                              child: Text('Rooms'),
                            ),
                            Tab(
                              child: Text('People'),
                            ),
                          ]),
                    ),
                  ),
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
                      controller: _searchController,
                      focusNode: _searchFocusNode,
                      onChanged: (value) {
                        if (value.isEmpty) {
                          _searchType = true;
                          setState(() {});
                        } else {
                          _searchType = false;
                          setState(() {});
                        }
                      },
                      cursorColor: Colors.green.shade600,
                      decoration: InputDecoration(
                          suffixIcon: Icon(
                            Icons.search,
                            color: Colors.green.shade600,
                          ),
                          hintText: 'Search',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(left: 13)),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.close),
                  )
                ],
              ),
            )),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 15),
          child: _searchType
              ? Column(children: [
                  Text('Recent Searches',
                      style: TextStyle(color: Theme.of(context).primaryColor)),
                ])
              : Container(
                  width: MediaQuery.of(context).size.width,
                  child: TabBarView(children: [
                    Center(child: Text('All')),
                    Center(child: Text('Video')),
                    Center(child: Text('Audio'))
                  ])),
        ),
      ),
    );
  }
}
