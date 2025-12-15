// Test environment configuration for comprehensive testing
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

// Setup in-memory SQLite for testing
dynamic setupTestDb() {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
}

// Mock HTTP Client
class MockHttpClient extends Mock implements http.Client {}

// Example: Mock external service
class MockExternalService extends Mock {}

// Example: Test data fixture
dynamic getDummyTask() => {
  'id': 1,
  'title': 'Test Task',
  'completed': false,
};

// Example: Environment variable for test
const String testApiBaseUrl = 'https://mock.api/test';
