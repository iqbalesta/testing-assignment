import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';

class MockHttpClient extends Mock implements http.Client {}
class MockDatabase extends Mock implements Database {}
