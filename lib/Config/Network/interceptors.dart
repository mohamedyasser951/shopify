import 'package:dio/dio.dart';

class RetryInterceptor extends Interceptor {
  final int maxRetries;
  final Duration retryInterval;

  RetryInterceptor({
    this.maxRetries = 3,
    this.retryInterval = const Duration(seconds: 1),
  });

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response == null || err.type != DioExceptionType.badResponse) {
      // If there's no response or the error is not network-related, skip retries
      super.onError(err, handler);
      return;
    }

    final requestOptions = err.requestOptions;

    for (var i = 0; i < maxRetries; i++) {
      try {
        // Wait before retrying
        await Future.delayed(retryInterval);

        // Retry the request
        final response = await Dio().fetch(requestOptions);
        return handler.resolve(response);
      } catch (e) {
        // If it's the last retry, propagate the error
        if (i == maxRetries - 1) {
          super.onError(err, handler);
        }
      }
    }
  }
}
