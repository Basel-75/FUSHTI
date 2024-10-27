import 'dart:io';

import 'package:get_all_pkg/get_all_pkg.dart';

mixin ImageMix {
  Future<String> uploadImage({required File imageFile}) async {
    final storageResponse = await Supabase.instance.client.storage
        .from('product-images')
        .upload('public/${imageFile.path.split('/').last}${DateTime.now()}', imageFile);

    final imageUrl = Supabase.instance.client.storage
        .from('product-images')
        .getPublicUrl('public/${imageFile.path.split('/').last}');

    return imageUrl;
  }
}
