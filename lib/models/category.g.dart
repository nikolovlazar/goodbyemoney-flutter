// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class Category extends $Category
    with RealmEntity, RealmObjectBase, RealmObject {
  Category(
    String name,
    int colorValue,
  ) {
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'colorValue', colorValue);
  }

  Category._();

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => throw RealmUnsupportedSetError();

  @override
  int get colorValue => RealmObjectBase.get<int>(this, 'colorValue') as int;
  @override
  set colorValue(int value) => throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<Category>> get changes =>
      RealmObjectBase.getChanges<Category>(this);

  @override
  Category freeze() => RealmObjectBase.freezeObject<Category>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Category._);
    return const SchemaObject(ObjectType.realmObject, Category, 'Category', [
      SchemaProperty('name', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('colorValue', RealmPropertyType.int),
    ]);
  }
}
