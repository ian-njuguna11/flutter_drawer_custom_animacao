import 'package:flutter/material.dart';

import '../Utils/rech_theme.dart';

class HomeDrawerRodape extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(
            'Sair',
            style: TextStyle(
              fontFamily: RechTheme.fontName,
              fontWeight: FontWeight.w300,
              fontSize: 14,
              color: RechTheme.darkText,
            ),
            textAlign: TextAlign.left,
          ),
          trailing: Icon(
            Icons.power_settings_new,
            color: Colors.red,
          ),
          onTap: () {},
        ),
        SizedBox(
          height: MediaQuery.of(context).padding.bottom,
        )
      ],
    );
  }
}
