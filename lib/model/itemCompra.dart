class ItemCompra {
  int? id;
  String? nomeproduto;
  String? descricao;
  double? preco;
  int? estacomprado;

  ItemCompra({
    this.id,
    this.nomeproduto,
    this.descricao,
    this.preco,
    this.estacomprado = 0,
  });

  Map<String, dynamic> toMap() => {
        "id": id,
        "nomeproduto": nomeproduto,
        "descricao": descricao,
        "preco": preco,
        "estacomprado": estacomprado,
      };

  factory ItemCompra.fromMap(Map<String, dynamic> json) {
    return ItemCompra(
      id: json["id"],
      nomeproduto: json["nomeproduto"],
      descricao: json["descricao"],
      preco: json["preco"],
      estacomprado: json["estacomprado"],
    );
  }
}
