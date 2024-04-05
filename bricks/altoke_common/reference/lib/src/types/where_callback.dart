/// Callback signature for identifying elements.
typedef WhereCallback<T> = bool Function(T element);

/// Callback signature for identifying indexed elements.
typedef WhereIndexedCallback<T> = bool Function(int index, T element);

/// A [WhereCallback] that always returns `true` and, therefore, does not filter
/// elements.
bool noFilter(_) => true;

/// A [WhereIndexedCallback] that always returns `true` and, therefore, does not
/// filter elements.
bool noIndexedFilter(_, __) => true;
