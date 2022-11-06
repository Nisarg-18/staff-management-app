import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:staff_app/constants/mongoConstants.dart';

var db, collection;

class MongoDb {
  // to establish connection with mongo database
  static connect() async {
    try {
      db = await Db.create(mongoUrl);
      await db.open();
      collection = db.collection(collectionName);
    } catch (e) {
      debugPrint('error connecting to database');
    }
  }

  // to insert data
  static insert(data) async {
    try {
      await collection.insertOne(data);
    } catch (e) {
      debugPrint('error inserting data');
    }
  }

  // get all data
  static getData() async {
    try {
      return jsonEncode(await collection.find().toList());
    } catch (e) {
      debugPrint('error getting data');
    }
  }
}
