class ItemCompra {
  int? id;
  String? nomeproduto;
  String? descricao;
  double? preco;
  bool? estacomprado;

  ItemCompra({
    this.id,
    this.nomeproduto,
    this.descricao,
    this.preco,
    this.estacomprado = false,
  });

  Map<String, dynamic> toMap() => {
        "id": id,
        "nomeproduto": nomeproduto,
        "descricao": descricao,
        "preco": preco,
        "estacomprado": estacomprado,
      };

  factory ItemCompra.fromMap(Map<String, dynamic> json) {
    print(json);
    return ItemCompra(
      id: json["id"],
      nomeproduto: json["nomeproduto"],
      descricao: json["descricao"],
      preco: json["preco"],
      estacomprado: json[
          "estacomprado"], //tem um bug aqui, às vezes ele detecta inteiro, outras vezes booleano
    );
  }
}
