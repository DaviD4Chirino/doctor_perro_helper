import 'package:doctor_perro_helper/models/providers/theme_mode_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChangeThemeModeButton extends ConsumerWidget {
  const ChangeThemeModeButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool lightMode = ref.watch(themeModeNotifierProvider) == ThemeMode.light;
    switchTheme() {
      if (lightMode) {
        ref.read(themeModeNotifierProvider.notifier).toggleDark();
      } else {
        ref.read(themeModeNotifierProvider.notifier).toggleLight();
      }
    }

    return ListTile(
      title: Text("Cambiar a ${lightMode ? "Modo Oscuro" : "Modo Claro"}"),
      leading: const Icon(Icons.color_lens_outlined),
      onTap: switchTheme,
      trailing: Switch(
        value: lightMode,
        onChanged: (_) => switchTheme(),
        padding: const EdgeInsets.all(0.0),
      ),
    );
  }
}
