/// Callback signature for comparing elements.
typedef ElementEqualityChecker<E extends Object?> = bool Function(E a, E b);

/// Callback signature for comparing lists of elements.
typedef ElementsListEqualityChecker<E extends Object?> =
    bool Function(List<E> a, List<E> b);
