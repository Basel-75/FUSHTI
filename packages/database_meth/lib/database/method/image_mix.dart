import 'dart:io';

import 'package:get_all_pkg/get_all_pkg.dart';

mixin ImageMix {
  Future<String> uploadImage(
      {required File imageFile, required bool isProductImage}) async {
    final String date = '${DateTime.now()}';
    final String packet = isProductImage ? 'product-images' : 'profile-images';
    final storageResponse = await Supabase.instance.client.storage
        .from(packet)
        .upload('public/${imageFile.path.split('/').last}$date', imageFile);

    final imageUrl = Supabase.instance.client.storage
        .from(packet)
        .getPublicUrl('public/${imageFile.path.split('/').last}');

    return '$imageUrl$date';
  }
}
