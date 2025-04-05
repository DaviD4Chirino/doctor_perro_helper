import 'package:doctor_perro_helper/config/border_size.dart';
import 'package:doctor_perro_helper/screens/pages/settings/change_dolar_price_button.dart';
import 'package:doctor_perro_helper/screens/pages/settings/change_theme_mode_button.dart';
import 'package:doctor_perro_helper/screens/pages/settings/check_for_updates_tile_button.dart';
import 'package:doctor_perro_helper/screens/pages/settings/manage_account.dart';
import 'package:doctor_perro_helper/widgets/reusables/section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return SafeArea(
      child: LayoutGrid(
        columnSizes: [1.fr],
        rowSizes: [1.fr, 0.04.fr],
        children: [
          ListView(
            padding: EdgeInsets.symmetric(
              vertical: Sizes().xxl,
              horizontal: Sizes().large,
            ),
            children: [
              Section(
                title: Text(
                  "Cuenta",
                  style: TextStyle(
                    fontSize: theme.textTheme.titleMedium?.fontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: const Column(
                  children: [ManageAccountButton()],
                ),
              ),
              Section(
                title: Text(
                  "Ajustes",
                  style: TextStyle(
                    fontSize: theme.textTheme.titleMedium?.fontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: const Column(
                  children: [
                    ChangeDolarPriceButton(),
                    ChangeThemeModeButton(),
                  ],
                ),
              ),
              Section(
                title: Text(
                  "Misceláneo",
                  style: TextStyle(
                    fontSize: theme.textTheme.titleMedium?.fontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: CheckForUpdatesTileButton(),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                Text("David Space - 2025"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SettingButton extends StatelessWidget {
  const SettingButton({super.key, required this.child, required this.onTap});

  final Widget child;

  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Theme.of(context).colorScheme.onSurfaceVariant.withAlpha(70),
      child: Column(
        children: [
          child,
          Container(
            height: 1.0,
            color:
                Theme.of(context).colorScheme.onSurfaceVariant.withAlpha(100),
          )
        ],
      ),
    );
  }
}
