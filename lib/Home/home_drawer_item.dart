import 'package:flutter/material.dart';

import '../Model/menu_model.dart';
import '../Utils/rech_theme.dart';

class HomeDrawerItem extends StatelessWidget {
  final MenuItem item;
  final bool selecionado;
  final GestureTapCallback onTap;
  final AnimationController animacaoItemController;

  HomeDrawerItem({this.item, this.selecionado, this.onTap, this.animacaoItemController});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.grey.withOpacity(0.1),
        highlightColor: Colors.transparent,
        onTap: onTap,
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Row(
                children: <Widget>[
                  itemSelecionadoBarra(),
                  SizedBox(width: 12),
                  itemSelecionadoIcone(),
                  SizedBox(width: 12),
                  itemSelecionadoLegenda()
                ],
              ),
            ),
            itemSelecionadoEfeito()
          ],
        ),
      ),
    );
  }

  Widget itemSelecionadoBarra() {
    return Container(
      width: 6.0,
      height: 46.0,
      decoration: BoxDecoration(
        color: selecionado ? Colors.blue : Colors.transparent,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(0),
          topRight: Radius.circular(0),
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(0),
        ),
      ),
    );
  }

  Widget itemSelecionadoIcone() {
    return item.isIconeImagem
        ? Container(
            width: 24,
            height: 24,
            child: Image.asset(item.nomeImage, color: selecionado ? Colors.blue : RechTheme.nearlyBlack),
          )
        : Icon(item.icon, color: selecionado ? Colors.blue : RechTheme.nearlyBlack);
  }

  Widget itemSelecionadoLegenda() {
    return Text(
      item.legenda,
      style: TextStyle(
        fontWeight: FontWeight.w300,
        fontSize: 14,
        color: selecionado ? Colors.blue : RechTheme.nearlyBlack,
      ),
      textAlign: TextAlign.left,
    );
  }

  /*
  * Responsável por fazer o efeito azul deslizante do item.
  *
  *   OBSERVAÇÃO:
  *
  *   Após o 'AnimationController' ser iniciado (forward()), ele irá rodar dentro de um intervalo de tempo indicado
  *   na criação do controller. Toda vez que o valor do 'AnimationController' mudar (Flutter trabalha a 60 fps, logo
  *   irá atualizar 60 vezes por segundo), o AnimatedBuilder irá refazer este widget.
  *
  *   Caso atribuíssemos um intervalo ao 'AnimationController', ao iniciarmos ele (forward()), poderíamos criar um
  *   CurvedAnimation para posteriormente usarmos uma interpolação para gerar valores. Exemplo
  *
  *     animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 350),);
  *     animacao = CurvedAnimation(parent: animationController, curve: Curves.linear);
  *     animationController.forward();
  *     final opacityTween = Tween<double>(begin: 1, end: 0);
  *     usar para gerar valores de interpolação: opacityTween.evaluate(animacao)
  *
  *   No entanto o 'animacaoItemController' foi criado sem informar um intervalo de tempo, pois o responsável por
  *   controlar o tempo é o 'drawerScrollController'. Quando o 'drawerScrollController' é iniciado, dentro do seu
  *   listner é setado o valor do 'animacaoItemController' na mão (animateTo). Por este motivo não precisamos aqui do
  *   Tween (que transforma basicamente tempo em qualquer interpolação de valor) e trabalhamos diretamente com o
  *   animacaoItemController.value
  *
  * */

  Widget itemSelecionadoEfeito() {
    return selecionado
        ? AnimatedBuilder(
            animation: animacaoItemController,
            builder: (BuildContext context, Widget child) {
              return Transform(
                transform: Matrix4.translationValues(
                    (MediaQuery.of(context).size.width * 0.75 - 64) * (1.0 - animacaoItemController.value - 1.0),
                    0.0,
                    0.0),
                child: Padding(
                  padding: EdgeInsets.only(top: 8, bottom: 8),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.75 - 64,
                    height: 46,
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.2),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(28),
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(28),
                      ),
                    ),
                  ),
                ),
              );
            },
          )
        : SizedBox();
  }
}
