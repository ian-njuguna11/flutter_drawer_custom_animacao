import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Model/menu_model.dart';
import '../Utils/rech_theme.dart';
import 'home_drawer.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  MenuIndex menuIndex;
  double menuLargura = 300;
  bool menuAberto = false;

  ScrollController drawerScrollController;
  AnimationController animacaoItemController;

  @override
  void initState() {
    menuIndex = MenuIndex.Home;
    inicializaDrawer();
    super.initState();
  }

  void inicializaDrawer() async {
    animacaoItemController = AnimationController(vsync: this, duration: Duration(milliseconds: 0));
    animacaoItemController.animateTo(1.0, duration: Duration(milliseconds: 0), curve: Curves.fastOutSlowIn);

    drawerScrollController = ScrollController(initialScrollOffset: menuLargura);
    drawerScrollController
      ..addListener(() {
        if (drawerScrollController.offset <= 0) {
          if (!menuAberto) {
            setState(() {
              menuAberto = true;

              // MENU ESTÁ ABERTO
            });
          }

          animacaoItemController.animateTo(0.0, duration: Duration(milliseconds: 0), curve: Curves.linear);
        } else if (drawerScrollController.offset > 0 && drawerScrollController.offset < menuLargura) {
          animacaoItemController.animateTo((drawerScrollController.offset * 100 / (menuLargura)) / 100,
              duration: Duration(milliseconds: 0), curve: Curves.linear);
        } else if (drawerScrollController.offset <= menuLargura) {
          if (menuAberto) {
            setState(() {
              menuAberto = false;

              // MENU ESTÁ FECHADO
            });
          }
          animacaoItemController.animateTo(1.0, duration: Duration(milliseconds: 0), curve: Curves.linear);
        }
      });

    await Future<dynamic>.delayed(Duration(milliseconds: 400));
    // Fecha o drawer posicionando o scroll no início da área da home
    drawerScrollController.jumpTo(menuLargura);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _sairApp(context),
      child: body(),
    );
  }

  Widget body() {
    return Scaffold(
      backgroundColor: RechTheme.white,
      body: SingleChildScrollView(
        controller: drawerScrollController,
        scrollDirection: Axis.horizontal,
        // Desabilita o 'bouncing' do Scroll
        physics: ClampingScrollPhysics(),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width + menuLargura,
          child: Row(
            children: <Widget>[
              homeMenuLateral(),
              homeBody(),
            ],
          ),
        ),
      ),
    );
  }

  Widget homeMenuLateral() {
    return AnimatedBuilder(
      animation: animacaoItemController,
      builder: (BuildContext context, Widget child) {
        return Transform(
          transform: Matrix4.translationValues(drawerScrollController.offset, 0.0, 0.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: menuLargura,
            child: HomeDrawer(
              menuIndex: menuIndex,
              animacaoItemController: animacaoItemController,
              functionCallBack: (MenuIndex menuIndex) {
                drawerAnimacaoClick();
                functionCallBack(menuIndex);
              },
            ),
          ),
        );
      },
    );
  }

  Widget homeBody() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Container(
        color: RechTheme.white,
        child: Stack(
          children: <Widget>[
            fechaDrawerClick(),
            iconeHomeAnimacao(),
          ],
        ),
      ),
    );
  }

  void drawerAnimacaoClick() {
    if (drawerScrollController.offset != 0.0) {
      drawerScrollController.animateTo(
        0.0,
        duration: Duration(milliseconds: 400),
        curve: Curves.fastOutSlowIn,
      );
    } else {
      drawerScrollController.animateTo(
        menuLargura,
        duration: Duration(milliseconds: 400),
        curve: Curves.fastOutSlowIn,
      );
    }
  }

  functionCallBack(MenuIndex menuIndexSelecionado) async {
    // Se trocou de opção do menu
    if (menuIndex != menuIndexSelecionado) {
      setState(() {
        menuIndex = menuIndexSelecionado;
        switch (menuIndexSelecionado) {
          case MenuIndex.Home:
            print(MenuIndex.Home);
            break;
          case MenuIndex.Ajuda:
            print(MenuIndex.Ajuda);
            break;
          case MenuIndex.Sincronizar:
            print(MenuIndex.Sincronizar);
            break;
          case MenuIndex.Configuracoes:
            print(MenuIndex.Configuracoes);
            break;
          case MenuIndex.Informacoes:
            print(MenuIndex.Informacoes);
            break;
        }
      });
    }
  }

  /*
  * Função responsável por fechar o drawer ao se clicar no body
  *
  * */
  Widget fechaDrawerClick() {
    return menuAberto
        ? InkWell(
            onTap: () {
              drawerAnimacaoClick();
            },
          )
        : SizedBox();
  }

  Widget iconeHomeAnimacao() {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 8, left: 8),
      child: SizedBox(
        width: AppBar().preferredSize.height - 8,
        height: AppBar().preferredSize.height - 8,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(AppBar().preferredSize.height),
            child: Center(
              child: AnimatedIcon(icon: AnimatedIcons.arrow_menu, progress: animacaoItemController),
            ),
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
              drawerAnimacaoClick();
            },
          ),
        ),
      ),
    );
  }

  Future<bool> _sairApp(BuildContext context) {
    return showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Sair desta aplicação?'),
              // content: Text('Nós não gostamos de ver você sair ...'),
              actions: <Widget>[
                FlatButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text('Não'),
                ),
                FlatButton(
                  onPressed: () {
                    // Remove a janela de diálogo
                    Navigator.of(context).pop(true);
                    // Fecha o aplicativo
                    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                  },
                  child: Text('Sim'),
                ),
              ],
            );
          },
        ) ??
        false;
  }
}
