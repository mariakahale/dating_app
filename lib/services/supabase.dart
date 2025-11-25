import 'dart:typed_data';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';

String supabaseUrl = 'https://ddqljvemutrptrirrsjm.supabase.co';
String supabaseKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImRkcWxqdmVtdXRycHRyaXJyc2ptIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTM3NzU2NTcsImV4cCI6MjA2OTM1MTY1N30.QjwJql0rNFhv9DgC-Dt4XMn8QfP6zJdbLzNdx4Z4q7A';

class SupabaseClass {
  // late final SupabaseClient client;
  static final SupabaseClass _instance = SupabaseClass._internal();
  factory SupabaseClass() => _instance;

  SupabaseClass._internal();

  late final SupabaseClient client;

  /// Call this once in main AFTER Supabase.initialize()
  void setsupabaseclient() {
    client = Supabase.instance.client;
  }

  Future<Uint8List> getImgFile_fromSupabase(imgurl) async {
    final Uint8List imageFile_dwnldedFromSupabase = await getClient().storage
        .from('images')
        .download(imgurl);
    return imageFile_dwnldedFromSupabase;
  }

  Future<void> initSupabase() async {
    try {
      await Supabase.initialize(
        url: supabaseUrl,
        anonKey: supabaseKey,
        debug: false,
        accessToken: () async {
          final token = await FirebaseAuth.instance.currentUser?.getIdToken();
          return token;
        },
      );

      // final client = Supabase.instance.client;
    } catch (e) {
      print("supabase already initialized");
    }
  }

  getClient() {
    print("client not null");
    return client;
  }
}
