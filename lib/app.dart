import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'widgets/homiesHomPage.dart';

class HomiesCupertinoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Constrain orientation
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return CupertinoApp(
      home: HomiesSignIn(),
    );
  }
}
