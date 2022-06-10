class NetworkConnectivityException implements Exception {
  var exceptionMessage = "No internet connectivity";
  NetworkConnectivityException({required this.exceptionMessage});

  @override
  String toString() => '{exception: $exceptionMessage}';
}
