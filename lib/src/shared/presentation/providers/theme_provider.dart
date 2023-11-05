import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pedidosvz/src/shared/config/shared_preferences.dart';

final isDarkModeProvider = StateProvider<bool>((ref) {
  final asyncValue = ref.watch(isDarkModeAsyncProvider);
  return asyncValue.when(
    data: (value) => value,
    loading: () =>
        false, // Puedes establecer un valor por defecto mientras carga
    error: (_, __) => false, // Manejar errores si ocurren
  );
});

final isDarkModeAsyncProvider = FutureProvider<bool>((ref) async {
  final darkThemePreference = DarkThemePreference();
  final isDarkMode = await darkThemePreference.getTheme();
  return isDarkMode;
});
