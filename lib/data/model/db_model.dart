class EventModel {
  final int? id;
  final String name;
  final String description;
  final String location;
  final String time;
  final String priorityColor;

  EventModel({
    this.id,
    required this.name,
    required this.description,
    required this.location,
    required this.time,
    required this.priorityColor,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'location': location,
      'time': time,
      'priorityColor': priorityColor
    };
  }

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'] as int?,
      name: json['name'] as String,
      description: json['description'] as String,
      location: json['location'] as String,
      time: json['time'] as String,
      priorityColor: json['priorityColor'] as String,
    );
  }

  EventModel copyWith({
    int? id,
    String? name,
    String? description,
    String? location,
    String? time,
    String? priorityColor,
  }) {
    return EventModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      location: location ?? this.location,
      time: time ?? this.time,
      priorityColor: priorityColor ?? this.priorityColor,
    );
  }
}

class EventModelFields{
  static const String id="id";
  static const String name="name";
  static const String description="description";
  static const String location="location";
  static const String time="time";
  static const String priorityColor="priorityColor";

  static const String eventTable = "event_table";
}
