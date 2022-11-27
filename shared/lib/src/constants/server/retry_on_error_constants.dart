class RetryOnErrorConstants {
  const RetryOnErrorConstants._();

  static int retries = 3;
  static Duration retryInterval = const Duration(seconds: 3);
}
