const String highPriorityName = "High";
const String mediumPriorityName = "Medium";
const String lowPriorityName = "Low";

const int highPriorityVal = 10;
const int mediumPriorityVal = 5;
const int lowPriorityVal = 1;

class Priority {
  final int val;
  final String name;

//<editor-fold desc="Data Methods">
  const Priority({
    required this.val,
    required this.name,
  });


  @override
  String toString() {
    return 'Priority{ val: $val, name: $name,}';
  }

  Priority copyWith({
    int? val,
    String? name,
  }) {
    return Priority(
      val: val ?? this.val,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'val': val,
      'name': name,
    };
  }

  factory Priority.fromMap(Map<String, dynamic> map) {
    return Priority(
      val: map['val'] as int,
      name: map['name'] as String,
    );
  }

//</editor-fold>
}

const List priorityList = [
  Priority(name: highPriorityName, val: highPriorityVal),
  Priority(name: mediumPriorityName, val: mediumPriorityVal),
  Priority(name: lowPriorityName, val: lowPriorityVal),
];
