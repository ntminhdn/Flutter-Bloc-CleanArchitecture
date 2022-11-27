import 'package:dartx/dartx.dart';

extension NullableListExtensions<T> on List<T>? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;
}

extension ListExtensions<T> on List<T> {
  List<T> appendOrExceptElement(T item) {
    return contains(item)
        ? exceptElement(item).toList(growable: false)
        : appendElement(item).toList(growable: false);
  }

  List<T> plus(T element) {
    return appendElement(element).toList(growable: false);
  }

  List<T> minus(T element) {
    return exceptElement(element).toList(growable: false);
  }

  List<T> plusAll(List<T> elements) {
    return append(elements).toList(growable: false);
  }

  List<T> minusAll(List<T> elements) {
    return except(elements).toList(growable: false);
  }
}

extension SetExtensions<T> on Set<T> {
  Set<T> appendOrExceptElement(T item) {
    return contains(item) ? exceptElement(item).toSet() : appendElement(item).toSet();
  }

  Set<T> plus(T element) {
    return appendElement(element).toSet();
  }

  Set<T> minus(T element) {
    return exceptElement(element).toSet();
  }

  Set<T> plusAll(List<T> elements) {
    return append(elements).toSet();
  }

  Set<T> minusAll(List<T> elements) {
    return except(elements).toSet();
  }
}

extension MapExtensions<K, V> on Map<K, V> {
  Map<K, V> plus(K key, V value) {
    return <K, V>{key: value, ...this};
  }

  Map<K, V> minus(K key) {
    return <K, V>{...this..remove(key)};
  }

  Map<K, V> plusAll(Map<K, V> map) {
    return <K, V>{...this, ...map};
  }

  Map<K, V> minusAll(Map<K, V> map) {
    return filterKeys((key) => !map.containsKey(key));
  }
}
