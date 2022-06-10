class Resource<T> {
  bool isLoading;
  String? errorMessage;
  T? data;
  Status status;

  Resource(
      {required this.isLoading,
      required this.errorMessage,
      required this.data,
      required this.status});

  factory Resource.success(T data) {
    return Resource(
      isLoading: false,
      errorMessage: null,
      data: data,
      status: Status.success,
    );
  }

  factory Resource.loading() {
    return Resource(
      isLoading: true,
      errorMessage: null,
      data: null,
      status: Status.loading,
    );
  }

  factory Resource.error(String errorMessage) {
    return Resource(
      isLoading: false,
      errorMessage: errorMessage,
      data: null,
      status: Status.error,
    );
  }

  bool get isSuccess => status == Status.success;
}

enum Status {
  success,
  loading,
  error,
}
