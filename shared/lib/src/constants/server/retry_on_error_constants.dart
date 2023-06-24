class RetryOnErrorConstants {
  const RetryOnErrorConstants._();

  static int maxRetries = 3;
  static Duration retryInterval = const Duration(seconds: 3);
}
