import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:read_head_chat/services/provider.dart';
import 'package:read_head_chat/services/storage.dart';

class SearchAppBar extends StatefulWidget {
  @override
  State<SearchAppBar> createState() => _SearchAppBarState();
}

class _SearchAppBarState extends State<SearchAppBar> {
  Storage _storage;
  TextEditingController searchController;

  @override
  void initState() {
    _storage = Storage();
    searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppProvider _provider = Provider.of<AppProvider>(context);
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: TextField(
        controller: searchController,
        style: TextStyle(color: Theme.of(context).accentColor),
        cursorColor: Colors.white,
        decoration: InputDecoration(
          hintText: 'Input ginger-name, pls',
          hintStyle: TextStyle(color: Colors.black54),
          border: InputBorder.none,
        ),
      ),
      actions: [
        Container(
          height: 40,
          width: 50,
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
              color: Theme.of(context).accentColor,
              borderRadius: BorderRadius.circular(40)),
          child: IconButton(
            icon: Icon(
              Icons.search,
            ),
            onPressed: () {
              _storage.getUserByUsername(searchController.text).then((user) {
                if (user != null && user.id != _provider.user.id)
                  _provider.setSearchResult(user);
              });
            },
            iconSize: 30,
            color: Theme.of(context).primaryColor,
          ),
        )
      ],
    );
  }
}
