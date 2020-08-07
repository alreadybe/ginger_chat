import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:read_head_chat/services/provider.dart';

class CategorySelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppProvider provider = Provider.of<AppProvider>(context);
    return Container(
        color: Theme.of(context).primaryColor,
        height: 80.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                provider.changeTabIndex(0);
              },
              child: _categoryItem(provider.tabIndex, 0, 'Chats'),
            ),
            GestureDetector(
              onTap: () {
                provider.changeTabIndex(1);
              },
              child: _categoryItem(provider.tabIndex, 1, 'Users'),
            ),
          ],
        ));
  }
}

Widget _categoryItem(_currentIndex, index, text) {
  return Container(
    child: Padding(
      padding: EdgeInsets.symmetric(vertical: 20.0),
      child: Text(
        text,
        style: TextStyle(
            color: _currentIndex == index ? Colors.white : Colors.white60,
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.8),
      ),
    ),
  );
}
