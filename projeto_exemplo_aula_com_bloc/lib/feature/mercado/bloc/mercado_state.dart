part of 'mercado_bloc.dart';

@immutable
sealed class MercadoState {}

final class MercadoInitial extends MercadoState {}

// Estado de tela carregando - controla quando o loading deve ser exibido
final class PaginaCarregandoState extends MercadoState {}

// Estado de quando a tela foi carregada - fornece a lista atualizada sempre que a tela finaliza o carregamento
final class PaginaCarregadaState extends MercadoState {
  final List<Produto> listaAtualizada;

  PaginaCarregadaState(this.listaAtualizada);
}
