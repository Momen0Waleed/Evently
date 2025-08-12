import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/database/events_data.dart';

abstract class FirebaseFirestoreUtils {
  static CollectionReference<EventsData> _getCollectionReference() {
    /// Need to get the collection reference to do CRUD operations
    return FirebaseFirestore.instance
        .collection(EventsData.collectionName)
        .withConverter(
          fromFirestore: (snapshot, _) => EventsData.fromJson(snapshot.data()!),
          toFirestore: (value, _) => value.toJson(),
        );
  }

  static Future<bool> createNewEvent(EventsData eventData) {
    try {
      var collectionReference = _getCollectionReference();
      var documentReference = collectionReference.doc();

      /// this is to make auto generated Id for the document
      eventData.eventID = documentReference.id;
      documentReference.set(eventData);
      return Future.value(true);
    } catch (e) {
      return Future.value(false);
    }
  }

  static Stream<QuerySnapshot<EventsData>> readEventData({
    required String catId,
  }) {
    Query<EventsData> collectionReference;
    if (catId == "All") {
      collectionReference = _getCollectionReference();
    } else {
      collectionReference = _getCollectionReference().where(
        "eventCategoryId",
        isEqualTo: catId,
      );
    }
    return collectionReference.snapshots();
  }

  static Stream<QuerySnapshot<EventsData>> readFavouriteEventData() {
    var collectionReference = _getCollectionReference().where(
      "isFavourite",
      isEqualTo: true,
    );
    return collectionReference.snapshots();
  }

  static Future<bool> updateEventData({required EventsData eventData}) {
    try {
      var collectionReference = _getCollectionReference();
      var documentReference = collectionReference.doc(eventData.eventID);

      documentReference.update(eventData.toJson());
      return Future.value(true);
    } catch (e) {
      return Future.value(false);
    }
  }

  static Future<void> deleteEventData({required EventsData eventData}) {
    var collectionReference = _getCollectionReference();
    var documentReference = collectionReference.doc(eventData.eventID);

    return documentReference.delete();
  }
}
