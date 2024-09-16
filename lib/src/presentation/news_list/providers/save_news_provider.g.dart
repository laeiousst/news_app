// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_news_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$saveNewsHash() => r'5b2ef6ca06ac1b210e56c20d07e1547f02e9dd51';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [saveNews].
@ProviderFor(saveNews)
const saveNewsProvider = SaveNewsFamily();

/// See also [saveNews].
class SaveNewsFamily extends Family<AsyncValue<void>> {
  /// See also [saveNews].
  const SaveNewsFamily();

  /// See also [saveNews].
  SaveNewsProvider call(
    News news,
  ) {
    return SaveNewsProvider(
      news,
    );
  }

  @override
  SaveNewsProvider getProviderOverride(
    covariant SaveNewsProvider provider,
  ) {
    return call(
      provider.news,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'saveNewsProvider';
}

/// See also [saveNews].
class SaveNewsProvider extends AutoDisposeFutureProvider<void> {
  /// See also [saveNews].
  SaveNewsProvider(
    News news,
  ) : this._internal(
          (ref) => saveNews(
            ref as SaveNewsRef,
            news,
          ),
          from: saveNewsProvider,
          name: r'saveNewsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$saveNewsHash,
          dependencies: SaveNewsFamily._dependencies,
          allTransitiveDependencies: SaveNewsFamily._allTransitiveDependencies,
          news: news,
        );

  SaveNewsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.news,
  }) : super.internal();

  final News news;

  @override
  Override overrideWith(
    FutureOr<void> Function(SaveNewsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SaveNewsProvider._internal(
        (ref) => create(ref as SaveNewsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        news: news,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<void> createElement() {
    return _SaveNewsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SaveNewsProvider && other.news == news;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, news.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SaveNewsRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `news` of this provider.
  News get news;
}

class _SaveNewsProviderElement extends AutoDisposeFutureProviderElement<void>
    with SaveNewsRef {
  _SaveNewsProviderElement(super.provider);

  @override
  News get news => (origin as SaveNewsProvider).news;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
