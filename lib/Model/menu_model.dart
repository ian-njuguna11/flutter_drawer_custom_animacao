import 'package:flutter/material.dart';

class MenuItem {
  MenuItem({
    this.isIconeImagem = false,
    this.legenda = '',
    this.icon,
    this.index,
    this.nomeImage = '',
  });

  String legenda;
  IconData icon;
  bool isIconeImagem;
  String nomeImage;
  MenuIndex index;
}

enum MenuIndex {
  Home,
  Ajuda,
  Sincronizar,
  Configuracoes,
  Informacoes,
}
