import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/database/events_data.dart';

abstract class FirebaseFirestoreUtils {
  static _getCollectionReference() {
    /// Need to get the collection reference to do CRUD operations
    return FirebaseFirestore.instance
        .collection(EventsData.collectionName)
        .withConverter(
          fromFirestore: (snapshot, _) => EventsData.fromJson(snapshot.data()!),
          toFirestore: (value, _) => value.toJson(),
        );
  }

  static createNewEvent(EventsData eventData) {
    var collectionReference = _getCollectionReference();
    var documentReference = collectionReference.doc();

    documentReference.set(eventData);
  }

  static Future<List<EventsData>> readEventData() async {
    var collectionReference = _getCollectionReference();
    var dataCollection = await collectionReference.get();
    return dataCollection.docs.map((e) {
      return e.data();
    }).toList();
  }
}
