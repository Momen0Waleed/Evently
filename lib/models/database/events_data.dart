class EventsData {
  static const String collectionName = "event_task";
  String userId;
  String? eventID;
  String eventTitle;
  String eventDescription;
  String eventCategoryImg;
  String? eventCategoryId;
  bool isFavourite;
  DateTime selectedDate;
  double? lat;
  double? long;

  EventsData({
    required this.userId,
    required this.eventID,
    required this.eventTitle,
    required this.eventDescription,
    required this.eventCategoryImg,
    required this.eventCategoryId,
    this.isFavourite = false,
    required this.selectedDate,
    required this.lat,
    required this.long,
  });

  Map<String, dynamic> toJson(){
    return {
      "userId": userId,
      "eventID": eventID,
      "eventTitle": eventTitle,
      "eventDescription": eventDescription,
      "eventCategoryImg": eventCategoryImg,
      "eventCategoryId": eventCategoryId,
      "isFavourite": isFavourite,
      "lat": lat,
      "long": long,
      "selectedDate": selectedDate.millisecondsSinceEpoch,
    };
  }

  factory EventsData.fromJson(Map<String,dynamic> json){
    return EventsData(
      userId: json["userId"],
      eventID: json["eventID"],
      eventTitle: json["eventTitle"],
      eventDescription: json["eventDescription"],
      eventCategoryImg: json["eventCategoryImg"],
      eventCategoryId: json["eventCategoryId"],
      isFavourite: json["isFavourite"],
      lat: json["lat"],
      long: json["long"],
            // .toLowerCase == 'true'
      // isFavourite: json["isFavourite"] ?? false,

      selectedDate:DateTime.fromMillisecondsSinceEpoch(json["selectedDate"]) ,
    );
  }

}
