enum APIPath {
  fetch_album,
}

class APIPathHelper {
  static String getValue(APIPath url) {
    switch (url) {
      case APIPath.fetch_album:
        return "https://jsonplaceholder.typicode.com/posts/1";
      default:
        return "";
    }
  }
}
