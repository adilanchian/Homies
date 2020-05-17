// sillyonly: flutter sucks!
// PrivateOrange: There's no place like 127.0.0.1
// sillyonly: 127.0.0.1:flutter = 404
import 'user.dart';

class Home {
  final String id;
  final String name;
  // Members by ID
  final List<String> members;
  // Items by ID
  final List<String> items;

  Home(this.id, this.name, this.members, this.items);
}
