import 'package:flutter/material.dart';

import '../Model/menu_model.dart';
import 'home_drawer_cabecalho.dart';
import 'home_drawer_item.dart';
import 'home_drawer_rodape.dart';

class HomeDrawer extends StatelessWidget {
  final MenuIndex menuIndex;
  final AnimationController animacaoItemController;
  final Function(MenuIndex) functionCallBack;

  HomeDrawer({this.menuIndex, this.animacaoItemController, this.functionCallBack});

  List<MenuItem> listaMenu = <MenuItem>[
    MenuItem(
      index: MenuIndex.Home,
      legenda: 'Home',
      icon: Icons.home,
    ),
    MenuItem(
      index: MenuIndex.Ajuda,
      legenda: 'Ajuda',
      isIconeImagem: true,
      nomeImage: 'assets/imagens/supportIcon.png',
    ),
    MenuItem(
      index: MenuIndex.Sincronizar,
      legenda: 'Sincronizar',
      icon: Icons.refresh,
    ),
    MenuItem(
      index: MenuIndex.Configuracoes,
      legenda: 'Configurações',
      icon: Icons.help,
    ),
    MenuItem(
      index: MenuIndex.Informacoes,
      legenda: 'Informações',
      icon: Icons.group,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          HomeDrawerCabecalho(),
          Expanded(
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.all(0.0),
              itemCount: listaMenu.length,
              itemBuilder: (BuildContext context, int index) {
                return HomeDrawerItem(
                  item: listaMenu[index],
                  selecionado: menuIndex == listaMenu[index].index,
                  onTap: () {
                    functionCallBack(listaMenu[index].index); //call to parent
                  },
                  animacaoItemController: animacaoItemController,
                );
              },
            ),
          ),
          Divider(),
          HomeDrawerRodape()
        ],
      ),
    );
  }
}
