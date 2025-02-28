import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpl/dataprovider.dart';
import 'package:fpl/individualpage/participantview.dart';
import 'package:fpl/leaguepage/leagueview.dart';

import '../themes.dart';

void main() {
  runApp(const LoginView());
}

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        initialIndex: 1,
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromRGBO(80, 100, 80,
                0), // MaterialTheme.darkMediumContrastScheme().onSurface,
        ),
      ),
    ));
  }
}
