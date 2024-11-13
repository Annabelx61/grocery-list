class Grocery {
  Grocery ({required this.name, required this.price, required this.count});

  final String name;
  final double price;
  int count;

  int increase() {
    count++;
    print(count);
    return count;
    
  }
}
