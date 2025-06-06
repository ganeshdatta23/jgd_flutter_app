import 'package:sri_guru_dig_vandanam/models/location_model.dart';
import 'package:sri_guru_dig_vandanam/utils/constants.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final SupabaseClient _client = Supabase.instance.client;

  Future<LocationModel?> getAppajiLocation() async {
    try {
      final response = await _client
          .from('locations')
          .select()
          .eq('id', appajiLocationId)
          .single();

      return LocationModel.fromJson(response);
    } catch (e) {
      // Handle error, e.g., location not found
      print('Error fetching Appaji location: $e');
      return null;
    }
  }

  Future<void> updateAppajiLocation(LocationModel location) async {
    try {
      await _client.from('locations').upsert(location.toJson());
    } catch (e) {
      print('Error updating Appaji location: $e');
      // Optionally re-throw or handle the error as needed
    }
  }
} 