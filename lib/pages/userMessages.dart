import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/data.dart';
import '../provider/log.dart';
import '../submodels/appBars/messageAppBar.dart';

class UserMessages extends StatefulWidget {
  UserMessages({Key? key, required this.email}) : super(key: key);
  String email;

  @override
  State<UserMessages> createState() => _UserMessagesState();
}

class _UserMessagesState extends State<UserMessages> {
  final TextEditingController _messageController = TextEditingController();
  String _messageText = '';

  @override
  void initState() {
    super.initState();
    print(widget.email);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<Log, Data>(
      builder: (context, log, data, child) => Scaffold(
        appBar: PreferredSize(
            child: MessageAppBar(), preferredSize: Size(double.infinity, 47)),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ListView.builder(
                    itemCount: 20,
                    shrinkWrap: true,
                    itemBuilder: (context, index) => Row(
                          children: [
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Material(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(10),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'mess your self',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
              ),
              Container(
                padding: EdgeInsets.only(left: 10, right: 10, bottom: 20),
                height: 70,
                decoration: BoxDecoration(
                  color: log.isDark ? Colors.grey[900] : Colors.grey.shade300,
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                    controller: _messageController,
                    onChanged: (value) {
                      setState(() {
                        _messageText = value;
                      });
                    },
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                        hintText: 'Message',
                        suffixIcon: _messageText.isEmpty
                            ? Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                    IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.attach_file)),
                                    IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.image)),
                                  ])
                            : IconButton(
                                onPressed: () {
                                  _messageController.clear();
                                  setState(() => _messageText = '');
                                },
                                icon: Icon(Icons.send)),
                        contentPadding: EdgeInsets.only(left: 12),
                        suffixIconColor: Colors.blue.shade600,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none),
                  ),
                ),
              )
            ]),
      ),
    );
  }
}
