typedef Continuable = Map<String, dynamic>;
typedef Handler = Future<Continuable> Function(Continuable arg);

Future<Continuable> continueRequest({
  required Handler handler,
  required Continuable arg,
}) async {
  Continuable? responseSum;
  String? continuationToken;

  Continuable objectSum(Continuable base, Continuable add) {
    for (final entry in add.entries) {
      final key = entry.key;
      final value = entry.value;

      if (value is Map<String, dynamic>) {
        if (base[key] == null) {
          base[key] = value;
        } else if (base[key] is Map<String, dynamic>) {
          base[key] = objectSum(base[key], value);
        }
      } else if (value is List) {
        if (base[key] is List) {
          base[key] = [...value, ...base[key]];
        } else {
          base[key] = value;
        }
      } else {
        base[key] = value;
      }
    }
    return base;
  }

  while (true) {
    arg['continuationToken'] = continuationToken;
    final response = await handler(arg);

    if (responseSum == null) {
      responseSum = Map<String, dynamic>.from(response);
    } else {
      objectSum(responseSum, response);
    }

    if (response['continuationToken'] == null) {
      return responseSum;
    }

    continuationToken = response['continuationToken'];
  }
}
