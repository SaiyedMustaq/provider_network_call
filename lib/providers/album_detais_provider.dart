import 'package:flutter/cupertino.dart';
import 'package:network_layer_provider/models/album_model.dart';
import 'package:network_layer_provider/network_module/api_response.dart';
import 'package:network_layer_provider/respository/album_repository.dart';

class AlbumProvider with ChangeNotifier {
  AlbumRepository? _albumRepository;
  ApiResponse<Album>? _album;
  ApiResponse<Album>? get album => _album;

  AlbumProvider() {
    _albumRepository = AlbumRepository();
    fetchAlbumDetailsData();
  }

  fetchAlbumDetailsData() async {
    _album = ApiResponse.loading('loading....');
    notifyListeners();
    try {
      Album album = await _albumRepository!.fetchAlbumDetails();
      _album = ApiResponse.complete(album);
      notifyListeners();
    } catch (e) {
      _album = ApiResponse.error(e.toString());
      notifyListeners();
    }
  }
}
