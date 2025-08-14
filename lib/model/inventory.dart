import 'package:shared_preferences/shared_preferences.dart';

class InventoryItem {
  final String id;
  final String name;
  final String imagePath;
  final String description;
  final int quantity;

  InventoryItem({
    required this.id,
    required this.name,
    required this.imagePath,
    required this.description,
    this.quantity = 1,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imagePath': imagePath,
      'description': description,
      'quantity': quantity.toString(),
    };
  }

  factory InventoryItem.fromJson(Map<String, dynamic> json) {
    return InventoryItem(
      id: json['id'],
      name: json['name'],
      imagePath: json['imagePath'],
      description: json['description'],
      quantity: int.tryParse(json['quantity'] ?? '1') ?? 1,
    );
  }

  InventoryItem copyWith({int? quantity}) {
    return InventoryItem(
      id: id,
      name: name,
      imagePath: imagePath,
      description: description,
      quantity: quantity ?? this.quantity,
    );
  }
}

class InventoryService {
  static const String _inventoryKey = 'user_inventory';

  static InventoryItem get helperItem => InventoryItem(
        id: 'helper',
        name: 'Helper',
        imagePath: 'assets/images/items/helper.jpg',
        description: 'It can get rid of all your obstacles!',
      );

  static Future<List<InventoryItem>> getInventory() async {
    final prefs = await SharedPreferences.getInstance();
    final inventoryJson = prefs.getStringList(_inventoryKey) ?? [];

    return inventoryJson.map((itemJson) {
      final Map<String, dynamic> json =
          Map<String, dynamic>.from(Uri.splitQueryString(itemJson));
      return InventoryItem.fromJson(json);
    }).toList();
  }

  static Future<void> addItem(InventoryItem item) async {
    final prefs = await SharedPreferences.getInstance();
    final currentInventory = await getInventory();

    // Check if item already exists
    final existingItemIndex = currentInventory
        .indexWhere((existingItem) => existingItem.id == item.id);
    if (existingItemIndex != -1) {
      // Item exists, increase quantity
      currentInventory[existingItemIndex] = currentInventory[existingItemIndex]
          .copyWith(
              quantity:
                  currentInventory[existingItemIndex].quantity + item.quantity);
    } else {
      // New item, add to inventory
      currentInventory.add(item);
    }

    final inventoryJson = currentInventory.map((item) {
      final json = item.toJson();
      return json.entries.map((e) => '${e.key}=${e.value}').join('&');
    }).toList();

    await prefs.setStringList(_inventoryKey, inventoryJson);
  }

  static Future<void> removeItem(String itemId, {int quantity = 1}) async {
    final prefs = await SharedPreferences.getInstance();
    final currentInventory = await getInventory();

    final itemIndex = currentInventory.indexWhere((item) => item.id == itemId);
    if (itemIndex != -1) {
      final currentItem = currentInventory[itemIndex];
      if (currentItem.quantity <= quantity) {
        // Remove item completely if quantity becomes 0 or less
        currentInventory.removeAt(itemIndex);
      } else {
        // Decrease quantity
        currentInventory[itemIndex] =
            currentItem.copyWith(quantity: currentItem.quantity - quantity);
      }
    }

    final inventoryJson = currentInventory.map((item) {
      final json = item.toJson();
      return json.entries.map((e) => '${e.key}=${e.value}').join('&');
    }).toList();

    await prefs.setStringList(_inventoryKey, inventoryJson);
  }

  static Future<bool> hasItem(String itemId) async {
    final inventory = await getInventory();
    return inventory.any((item) => item.id == itemId);
  }
}
