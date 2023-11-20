import 'package:flutter/material.dart';
import 'package:network_layer_provider/models/album_model.dart';
import 'package:network_layer_provider/network_module/api_path.dart';
import 'package:network_layer_provider/network_module/http_client.dart';

class AlbumRepository {
  Future<Album> fetchAlbumDetails(BuildContext context) async {
    final response = await HttpClient.instance.request(
        context: context,
        methodType: REQUESTMETHOD.GET,
        endPoint: APIPathHelper.getValue(APIPath.fetch_album),
        requestData: {});
    return Album.fromJson(response);
  }
}
