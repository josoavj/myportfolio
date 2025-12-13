import 'dart:async';

/// Service de cache simple pour stocker les données en mémoire
class CacheService {
  static final CacheService _instance = CacheService._internal();

  final Map<String, CacheEntry> _cache = {};
  final Duration defaultTTL = const Duration(minutes: 30);

  CacheService._internal();

  factory CacheService() {
    return _instance;
  }

  /// Ajoute une valeur au cache avec TTL optionnel
  void set<T>(String key, T value, {Duration? ttl}) {
    _cache[key] = CacheEntry(
      value: value,
      expiresAt: DateTime.now().add(ttl ?? defaultTTL),
    );
  }

  /// Récupère une valeur du cache
  T? get<T>(String key) {
    final entry = _cache[key];

    if (entry == null) return null;

    // Vérifier si l'entrée a expiré
    if (DateTime.now().isAfter(entry.expiresAt)) {
      _cache.remove(key);
      return null;
    }

    return entry.value as T?;
  }

  /// Récupère ou calcule une valeur
  Future<T> getOrCompute<T>(
    String key,
    Future<T> Function() compute, {
    Duration? ttl,
  }) async {
    final cached = get<T>(key);
    if (cached != null) return cached;

    final value = await compute();
    set(key, value, ttl: ttl);
    return value;
  }

  /// Vide une clé du cache
  void remove(String key) {
    _cache.remove(key);
  }

  /// Vide tout le cache
  void clear() {
    _cache.clear();
  }

  /// Obtient la taille du cache
  int get size => _cache.length;
}

/// Classe pour stocker les entrées du cache
class CacheEntry {
  final dynamic value;
  final DateTime expiresAt;

  CacheEntry({
    required this.value,
    required this.expiresAt,
  });
}
