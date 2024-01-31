

import 'package:flutter_riverpod/flutter_riverpod.dart';

final counterProvider = StateProvider((ref) => 0);

/// Types of Providers in Riverpod
/// Riverpod offers various types of providers for different use cases:
/// Provider: Basic provider for values that don't change over time.
/// StateProvider: For simple mutable state.
/// FutureProvider: For asynchronous operations like API calls.
/// StreamProvider: For streaming data.
/// StateNotifierProvider: For more complex state logic.
