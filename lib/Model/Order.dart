class Order {
  int? id;
  String? nameDocu;
  String? catDocu;
  int? status;
  int? typeOrder;

    Order({
    this.id,
    this.nameDocu,
    this.catDocu,
    this.status,
    this.typeOrder
  });

// map json to post model

factory Order.fromJson(Map<String, dynamic> json) {
  return Order(
    id: json['id'],
    nameDocu: json['name_docus'],
    catDocu: json['category_docus'],
    status: json['status'],
    typeOrder: json['type_order'],
  );
}
}
