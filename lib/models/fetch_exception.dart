class FetchException implements Exception {
  FetchException(this.message);
  final String message;

  String toString(){
    return this.message;
  }
}