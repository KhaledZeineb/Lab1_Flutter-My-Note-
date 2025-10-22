// lib/config/appwrite_config.dart
import 'package:appwrite/appwrite.dart';

class AppwriteConfig {
  // Configuration Appwrite
  static final Client client = Client()
    ..setEndpoint('https://cloud.appwrite.io/v1')
    ..setProject('dfrthnvdjhjh2dkch54cjo-khsz58djdnk');

  // Database and Collection IDs
  static const String databaseId = 'notes_app_database_main_version_2025';
  static const String collectionId = 'notes_table_data_structure_v1_2025';
}