abstract class BaseDataMapper<R, E> {
  const BaseDataMapper();

  E mapToEntity(R? data);

  List<E> mapToListEntity(List<R>? listData) {
    return listData?.map(mapToEntity).toList() ?? List.empty();
  }
}

/// Optional: if need map from entity to  data
mixin DataMapperMixin<R, E> on BaseDataMapper<R, E> {
  R mapToData(E entity);

  R? mapToNullableData(E? entity) {
    if (entity == null) {
      return null;
    }

    return mapToData(entity);
  }

  List<R>? mapToNullableListData(List<E>? listEntity) {
    return listEntity?.map(mapToData).toList();
  }

  List<R> mapToListData(List<E>? listEntity) {
    return mapToNullableListData(listEntity) ?? List.empty();
  }
}
