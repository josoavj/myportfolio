import 'dart:async';

/// Service de cache simple pour stocker les données en mémoire
class CacheService {
  static final CacheService _instance = CacheService._internal();

  final Map<String, CacheEntry> _cache = {};
  final Duration defaultTTL = const Duration(hours: 6);

  // Éviter les requêtes simultanées pour la même clé
  final Map<String, Future<dynamic>> _pendingRequests = {};

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

  /// Récupère ou calcule une valeur avec deduplication des requêtes en vol
  Future<T> getOrCompute<T>(
    String key,
    Future<T> Function() compute, {
    Duration? ttl,
  }) async {
    // Vérifier le cache d'abord
    final cached = get<T>(key);
    if (cached != null) return cached;

    // Vérifier s'il existe une requête en cours pour cette clé
    if (_pendingRequests.containsKey(key)) {
      return await _pendingRequests[key] as Future<T>;
    }

    // Créer une nouvelle requête et la tracker
    final future = compute();
    _pendingRequests[key] = future;
    try {
      final value = await future;
      set(key, value, ttl: ttl);
      return value;
    } finally {
      _pendingRequests.remove(key);
    }
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
