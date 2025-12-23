import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_sec6_backend/model/priority.dart';

class PriorityServices{
  String priorityCollection = "PriorityCollection";
  ///Create Priority
  Future createPriority(PriorityModel model) async {
    DocumentReference documentReference =
    await FirebaseFirestore.instance
        .collection(priorityCollection)
        .doc();
    return await FirebaseFirestore.instance
        .collection(priorityCollection)
        .doc(documentReference.id)
        .set(model.toJson(documentReference.id));
  }

  ///Update Priority
  Future updatePriority(PriorityModel model) async {
    return await FirebaseFirestore.instance
        .collection(priorityCollection)
        .doc(model.docId)
        .update({"name": model.name,});
  }

  ///Delete Priority
  Future deletePriority(String priorityID) async {
    return await FirebaseFirestore.instance
        .collection(priorityCollection)
        .doc(priorityID)
        .delete();
  }
  ///Get All Priority
  Stream<List<PriorityModel>> getAllPriority() {
    return FirebaseFirestore.instance
        .collection(priorityCollection)
        .snapshots()
        .map((taskList) => taskList.docs
        .map((taskJson)=> PriorityModel.fromJson(taskJson.data()))
        .toList()
    );
  }
  ///Get  Priority
  Future<List<PriorityModel>> getPriority() {
    return FirebaseFirestore.instance
        .collection(priorityCollection)
        .get()
        .then((taskList) => taskList.docs
        .map((taskJson)=> PriorityModel.fromJson(taskJson.data()))
        .toList()
    );
  }
}