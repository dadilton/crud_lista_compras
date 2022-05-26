import "package:flutter/material.dart";
import "package:crud_lista_compras/model/itemCompra.dart";

class ItemCompraDialog extends StatefulWidget {
  //o campo itemCompra pode ser nulo, pq a gente
  //pode querer abrir um dialog sem dados
  ItemCompra? itemCompra;

  //no construtor desta classe, queremos
  //que seja informado o item de compra que será
  //manipulado
  ItemCompraDialog({this.itemCompra});

  @override
  State<StatefulWidget> createState() {
    return _ItemCompraDialogState();
  }
}

class _ItemCompraDialogState extends State<ItemCompraDialog> {
  final _nomeProdutoController = TextEditingController();
  final _descricaoController = TextEditingController();
  ItemCompra _itemAtual = ItemCompra();

  @override
  void initState() {
    super.initState();

    if (widget.itemCompra != null) {
      Map<String, dynamic> map =
          widget.itemCompra?.toMap() ?? Map<String, dynamic>();

      _itemAtual = ItemCompra.fromMap(map);
    }

    _nomeProdutoController.text = _itemAtual.nomeproduto ?? "";
    _descricaoController.text = _itemAtual.descricao ?? "";
  }

  @override
  void dispose() {
    super.dispose();
    _nomeProdutoController.clear();
    _descricaoController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.itemCompra == null ? "Novo item" : "Editar item"),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          TextField(
            controller: _nomeProdutoController,
            decoration: InputDecoration(labelText: "Nome do produto"),
            autofocus: true,
          ),
          TextField(
            controller: _descricaoController,
            decoration: InputDecoration(labelText: "Descrição"),
            autofocus: true,
          ),
        ],
      ),
      actions: <Widget>[
        FlatButton(
          child: Text("Salvar"),
          onPressed: () {
            _itemAtual.nomeproduto = _nomeProdutoController.value.text;
            _itemAtual.descricao = _descricaoController.value.text;
            Navigator.of(context).pop(_itemAtual);
          },
        )
      ],
    );
  }
}
