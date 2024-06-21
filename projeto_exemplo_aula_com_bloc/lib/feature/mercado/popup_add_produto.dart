import 'package:flutter/material.dart';
import 'package:projeto_exemplo_aula_com_bloc/core/model/produto.dart';

class PopupAddProduto extends StatelessWidget {
  PopupAddProduto({super.key, required this.quandoAdicionarForPressionado});

  // Controladores para capturar os inputs do usuário
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController precoController = TextEditingController();

  // Callback - devolve informação para a página anterior
  final Function(Produto) quandoAdicionarForPressionado;

  @override
  Widget build(BuildContext context) {
    // Widget de PopUp
    return AlertDialog(
      // Titulo do PopUp - nesse caso uma linha contendo um texto e um icone para fechar o PopUp
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Adicionar um produto'),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      // Conteudo do PopUp - Nesse caso, os campos de input "Nome do produto" e "Preço"
      content: SizedBox(
        width: 400, // Isso fara com que o PopUp tenha um tamanho mais agradável
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nomeController,
              decoration: const InputDecoration(labelText: 'Nome do produto'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: precoController,
              decoration: const InputDecoration(labelText: 'Preço'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
      ),
      // Botões do PopUp - Aqui estão definidos os botões de ações inferiores
      actions: [
        // Define a altura do botão como 45
        SizedBox(
          height: 45,
          child: ElevatedButton(
            // Ações que são executadas quando o botão é clicado
            onPressed: () {
              quandoAdicionarForPressionado(Produto(
                nome: nomeController.text,
                preco: double.parse(precoController.text),
              ));
              Navigator.of(context).pop();
            },
            // Estilo visual do botão
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[200],
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            // Conteudo apresentado dentro do botão, no nosso caso, um texto.
            child: const Text(
              'Adicionar',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }
}
