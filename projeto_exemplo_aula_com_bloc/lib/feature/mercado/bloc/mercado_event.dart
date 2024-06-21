part of 'mercado_bloc.dart';

@immutable
sealed class MercadoEvent {}

class InicializacaoDaPaginaEvent extends MercadoEvent {}

// Evento de adicionar produto
class AdicionarProdutoEvent extends MercadoEvent {
  final Produto produtoParaAdicionar;
  final List<Produto> listaDeProdutosAtual;

  AdicionarProdutoEvent(
    this.produtoParaAdicionar,
    this.listaDeProdutosAtual,
  );
}

// Evento de remover produto
class RemoverProdutoEvent extends MercadoEvent {
  final Produto produtoParaRemover;
  final List<Produto> listaDeProdutosAtual;

  RemoverProdutoEvent(this.produtoParaRemover, this.listaDeProdutosAtual);
}
