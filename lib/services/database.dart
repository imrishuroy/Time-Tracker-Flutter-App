import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:time_tracker/jobs/job.dart';
import 'package:time_tracker/services/api_path.dart';

abstract class DataBase {
  Future<void> createJob(Job job);
  //void readJobs();
  //Stream<List<Job>> jobStream();
  Stream jobStream();
  Stream<List<Job>> jobStreamList();
  Future<void> deleteData();
}

class FirestoreDataBase implements DataBase {
  final String uid;

  FirestoreDataBase({@required this.uid}) : assert(uid != null);
/*

  Future<void> createJob(Job job) async {
    //final path = '/users/$uid/jobs/job_abc';
    final path = APIPath.job(uid: uid, jobId: 'job_abc');
    final documentReference = FirebaseFirestore.instance.doc(path);
    await documentReference.set(job.toMap());
  }
} */

// This method define single entry point for all writes to Firestore
  Future<void> _setData({String path, Map<String, dynamic> data}) async {
    final reference = FirebaseFirestore.instance.doc(path);
    print('Path: $path, Data: $data');
    await reference.set(data);
  }

  String documentIdFromCurrentData() => DateTime.now().toIso8601String();

  Future<void> createJob(Job job) async {
    await _setData(
      path: APIPath.job(uid: uid, jobId: documentIdFromCurrentData()),
      // path: APIPath.job(uid: uid, jobId: 'job-id'),
      data: job.toMap(),
    );
  }

  // void readJobs() {
  //   final path = APIPath.jobs(uid);
  //   final reference = FirebaseFirestore.instance.collection(path);
  //   final snapshot = reference.snapshots();
  //   snapshot.listen((eventSnapshot) {
  //     eventSnapshot.docs.forEach((element) {
  //       print(element.data());
  //     });
  //   });
  // }

  // Stream<List<Job>> jobStream() {
  //   final path = APIPath.jobs(uid);
  //   final reference = FirebaseFirestore.instance.collection(path);
  //   final snapshots = reference.snapshots();
  //   return snapshots.map(
  //     (event) => event.docs.map(
  //       (e) => Job(
  //         name: e['name'],
  //         ratePerHour: e['ratePerHour'],
  //       ),
  //     ),
  //   );
  // }
  @override
  Stream jobStream() {
    final path = APIPath.jobs(uid);
    final reference = FirebaseFirestore.instance.collection(path);
    final snapshots = reference.snapshots();
    return snapshots.map((snapshotData) => snapshotData.docs);
  }

  @override
  Stream<List<Job>> jobStreamList() {
    final path = APIPath.jobs(uid);
    final reference = FirebaseFirestore.instance.collection(path);
    final snapshots = reference.snapshots();
    return snapshots.map(
      (snapshotData) => snapshotData.docs.map(
        (e) => Job(
          name: e.data()['name'],
          ratePerHour: e.data()['ratePerHour'],
        ),
      ),
    );
  }

  @override
  // used to delete data from firebase
  Future<void> deleteData() async {
    final path = APIPath.job(uid: uid);
    final reference = FirebaseFirestore.instance.doc(path);
    print('Path : $path');
    await reference.delete();
  }
}
