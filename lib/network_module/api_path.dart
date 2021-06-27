enum APIPath {
  fetch_album,
}

class APIPathHelper {
  static String getValue(APIPath url) {
    switch (url) {
      case APIPath.fetch_album:
        return "/posts/1";
      default:
        return "";
    }
  }
}
