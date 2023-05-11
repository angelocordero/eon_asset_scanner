class Item {
  String assetID;
  String department;
  String? personAccountable;
  String name;
  String? description;
  String unit;
  double? price;
  DateTime? datePurchased;
  DateTime dateReceived;
  String status;
  String category;
  String? remarks;

  Item({
    required this.assetID,
    required this.department,
    this.personAccountable,
    required this.name,
    this.description,
    required this.unit,
    this.price,
    this.datePurchased,
    required this.dateReceived,
    required this.status,
    required this.category,
    this.remarks,
  });

  Item copyWith({
    String? assetID,
    String? department,
    String? personAccountable,
    String? name,
    String? description,
    String? unit,
    double? price,
    DateTime? datePurchased,
    DateTime? dateReceived,
    String? status,
    String? category,
    String? remarks,
  }) {
    return Item(
      assetID: assetID ?? this.assetID,
      department: department ?? this.department,
      personAccountable: personAccountable ?? this.personAccountable,
      name: name ?? this.name,
      description: description ?? this.description,
      unit: unit ?? this.unit,
      price: price,
      datePurchased: datePurchased,
      dateReceived: dateReceived ?? this.dateReceived,
      status: status ?? this.status,
      category: category ?? this.category,
      remarks: remarks ?? this.remarks,
    );
  }

  @override
  bool operator ==(covariant Item other) {
    if (identical(this, other)) return true;

    return other.assetID == assetID &&
        other.department == department &&
        other.personAccountable == personAccountable &&
        other.name == name &&
        other.description == description &&
        other.unit == unit &&
        other.price == price &&
        other.datePurchased == datePurchased &&
        other.dateReceived == dateReceived &&
        other.status == status &&
        other.category == category &&
        other.remarks == remarks;
  }

  @override
  int get hashCode {
    return assetID.hashCode ^
        department.hashCode ^
        personAccountable.hashCode ^
        name.hashCode ^
        description.hashCode ^
        unit.hashCode ^
        price.hashCode ^
        datePurchased.hashCode ^
        dateReceived.hashCode ^
        category.hashCode ^
        status.hashCode ^
        remarks.hashCode;
  }

  @override
  String toString() {
    return 'Item(assetID: $assetID, department: $department, personAccountable: $personAccountable, name: $name, description: $description, unit: $unit, price: $price, datePurchased: $datePurchased, dateReceived: $dateReceived, status: $status, category: $category, remarks: $remarks)';
  }
}
