class EventsData {
  static const String collectionName = "event_task";
  final String eventID;
  final String eventTitle;
  final String eventDescription;
  final String eventCategory;
  final bool isFavourite;

  EventsData({
    required this.eventID,
    required this.eventTitle,
    required this.eventCategory,
    required this.eventDescription,
    required this.isFavourite,
  });

  Map<String, dynamic> toJson(){
    return {
      "eventID": eventID,
      "eventTitle": eventTitle,
      "eventDescription": eventDescription,
      "eventCategory": eventCategory,
      "isFavourite": isFavourite,
    };
  }

  factory EventsData.fromJson(Map<String,dynamic> json){
    return EventsData(
      eventID: json["eventID"],
      eventTitle: json["eventTitle"],
      eventCategory: json["eventCategory"],
      eventDescription: json["eventDescription"],
      isFavourite: json["isFavourite"].toLowerCase == 'true',
    );
  }

}
