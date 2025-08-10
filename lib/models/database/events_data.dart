class EventsData {
  static const String collectionName = "event_task";
  String? eventID;
  final String eventTitle;
  final String eventDescription;
  final String eventCategoryImg;
  final String? eventCategoryId;
  bool isFavourite;
  final String selectedDate;

  EventsData({
    this.eventID,
    required this.eventTitle,
    required this.eventDescription,
    required this.eventCategoryImg,
    required this.eventCategoryId,
    this.isFavourite = false,
    required this.selectedDate,
  });

  Map<String, dynamic> toJson(){
    return {
      "eventID": eventID,
      "eventTitle": eventTitle,
      "eventDescription": eventDescription,
      "eventCategoryImg": eventCategoryImg,
      "eventCategoryId": eventCategoryId,
      "isFavourite": isFavourite,
      "selectedDate": selectedDate,
    };
  }

  factory EventsData.fromJson(Map<String,dynamic> json){
    return EventsData(
      eventID: json["eventID"],
      eventTitle: json["eventTitle"],
      eventDescription: json["eventDescription"],
      eventCategoryImg: json["eventCategoryImg"],
      eventCategoryId: json["eventCategoryId"],
      isFavourite: json["isFavourite'"].toLowerCase == 'true',
      selectedDate: json["selectedDate"],
    );
  }

}
