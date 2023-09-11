import 'package:objectbox/objectbox.dart';

@Entity()
class LocalImageUrlData {
  LocalImageUrlData({
    this.origin,
    this.sm,
    this.md,
    this.lg,
  });

  @Id()
  int? id;
  String? origin;
  String? sm;
  String? md;
  String? lg;

  @override
  int get hashCode {
    return id.hashCode ^ origin.hashCode ^ sm.hashCode ^ md.hashCode ^ lg.hashCode;
  }

  @override
  String toString() {
    return 'LocalImageUrlData(id: $id, origin: $origin, sm: $sm, md: $md, lg: $lg)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is LocalImageUrlData &&
        other.id == id &&
        other.origin == origin &&
        other.sm == sm &&
        other.md == md &&
        other.lg == lg;
  }
}
