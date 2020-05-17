class Item {
  final String id;
  final String name;
  final String description;
  final String requestor;
  final bool isComplete;
  final double price;

  Item(this.id, this.name, this.description, this.requestor,
      {this.isComplete = false, this.price = 0.00});

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'requestor': requestor,
        'isComplete': isComplete,
        'price': price,
      };
}
