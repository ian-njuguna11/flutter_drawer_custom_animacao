import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';

import '../Model/configuracao_model.dart';

enum ValidaListaState { LOADING, SUCCESSO, ERRO }

class ConfiguracaoBloc extends BlocBase {
  final BehaviorSubject<Map<String, ConfiguracaoModel>> _configuracoesController =
      BehaviorSubject<Map<String, ConfiguracaoModel>>.seeded({});
  final _validaListaStateController = BehaviorSubject<ValidaListaState>.seeded(ValidaListaState.SUCCESSO);

  // É utilizado o Map pois é mais facil adicionar e remover já que no List eu preciso da ocorrência e no Map eu já tenho a key do Map
  Map<String, ConfiguracaoModel> _configuracoes = {};

  ConfiguracaoBloc() {}

  /*
  ----------------------
  Saída do controlador
  ----------------------
  */

  Stream<Map<String, ConfiguracaoModel>> get outConfiguracoes => _configuracoesController.stream;

  Stream<ValidaListaState> get outValidaListaState => _validaListaStateController.stream;

  /*
  ----------------------
  Entrada do controlador
  ----------------------
  */

  @override
  void dispose() {
    _configuracoesController.close();
    _validaListaStateController.close();
  }
}
