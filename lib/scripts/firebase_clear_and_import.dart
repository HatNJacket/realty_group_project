import 'dart:io';
import 'package:firedart/firedart.dart';
import 'package:csv/csv.dart';

Future<void> clearAndImportHouses(String csvFilePath) async {
  // Configure Firedart
  const String projectId = "realty-group-project"; // Replace with your Firebase project ID
  Firestore.initialize(projectId);

  try {
    // Reference to the `houses` collection
    CollectionReference housesCollection = Firestore.instance.collection('houses');

    // Clear the collection
    var documents = await housesCollection.get();
    for (var doc in documents) {
      await doc.reference.delete();
    }
    print("Houses collection cleared.");

    // Read and parse CSV file
    String csvData = await File(csvFilePath).readAsString();
    List<List<dynamic>> rows = const CsvToListConverter().convert(csvData);

    // Ensure CSV format is correct
    if (rows.isEmpty || rows[0].length < 5) {
      throw Exception("Invalid CSV format.");
    }

    // Add rows to Firebase
    for (int i = 1; i < rows.length; i++) {
      List<dynamic> row = rows[i];
      await housesCollection.add({
        'address': row[0],
        'highestBid': row[1],
        'imageURL': row[2],
        'numBaths': row[3],
        'numBeds': row[4],
        'price': row[5],
        'showMore': row[6] == "true" ? true : false,
        'squareFeet': row[7],
      });
    }
    print("Houses collection populated with data from CSV.");
    return;
  } catch (e) {
    print("Error: $e");
    return;
  }
}

Future<void> main() async {
  // Path to your CSV file
  const String csvFilePath = 'lib/scripts/houses_data.csv';

  await clearAndImportHouses(csvFilePath);

  exit(0);

}
