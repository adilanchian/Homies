import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:homies/models/item.dart';

import '../styles.dart';

// TheYagich01: "Man I love Flutter! - Alec"
class HomiesListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Styles.baseBGColor,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: CupertinoColors.darkBackgroundGray,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
            child: Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Text(
                'Sign Out',
                style: Styles.subtitleTextStyle,
              ),
            ),
            onTap: () {
              print('Signing out...');
              FirebaseAuth.instance.signOut();
            }),
        middle: Text(
          'Homies Home Items',
          style: Styles.detailTextStyle,
        ),
        trailing: GestureDetector(
            child: Icon(
              CupertinoIcons.add,
              color: Color(0xFFFFFFFF),
            ),
            onTap: () {
              print('ADD');
            }),
      ),
      child: SafeArea(
          child: ListView(
        padding: const EdgeInsets.all(15.0),
        children: _mapDataToItems(),
      )),
    );
  }
}

class ListItem extends StatelessWidget {
  final Item item;

  ListItem({this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 128,
        decoration: BoxDecoration(
            color: Styles.listItemBGColor,
            borderRadius: BorderRadius.circular(16.0)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 0.0, right: 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(item.name, style: Styles.itemNameTextStyle),
                    Text('\$${item.price}', style: Styles.itemNameTextStyle),
                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(item.description,
                      style: Styles.itemDetailTextStyle)),
              Padding(
                  padding: const EdgeInsets.only(top: 55),
                  child: Text('Requested By: ' + item.requestor,
                      style: Styles.itemRequestedByTextStyle))
            ],
          ),
        ));
  }
}

// Helpers
List<Widget> _mapDataToItems() {
  List<Widget> itemWidgets = <Widget>[];

  // TODO - Get list of items from collection
  final items = [
    new Item('1234', 'Apples', 'Wow. Apples.', 'YaBoiAlec', price: 14.50),
    new Item('1234', 'Apples', 'Wow. Apples.', 'YaBoiAlec', price: 14.50),
    new Item('1234', 'Apples', 'Wow. Apples.', 'YaBoiAlec', price: 14.50),
    new Item('1234', 'Apples', 'Wow. Apples.', 'YaBoiAlec', price: 14.50)
  ];

  // Create items
  items.forEach((item) {
    itemWidgets.add(Padding(
        padding: const EdgeInsets.only(top: 15), child: ListItem(item: item)));
  });

  return itemWidgets;
}
