T run<T>(T Function() block) {
  return block();
}

extension ScopeFunctionsForObject<T extends Object> on T {
  R let<R>(R Function(T it) block) => block(this);

  T also(void Function(T it) block) {
    block(this);

    return this;
  }
}
