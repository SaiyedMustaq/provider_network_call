import 'package:network_layer_provider/models/album_model.dart';
import 'package:network_layer_provider/network_module/api_path.dart';
import 'package:network_layer_provider/network_module/http_client.dart';

class AlbumRepository {
  Future<Album> fetchAlbumDetails() async {
    final response = await HttpClient.instance
        .fetchData(url: APIPathHelper.getValue(APIPath.fetch_album));
    return Album.fromJson(response);
  }
}
