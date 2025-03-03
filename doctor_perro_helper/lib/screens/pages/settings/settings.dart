import 'package:doctor_perro_helper/config/border_size.dart';
import 'package:doctor_perro_helper/screens/pages/settings/change_dolar_price_button.dart';
import 'package:doctor_perro_helper/screens/pages/settings/change_theme_mode_button.dart';
import 'package:doctor_perro_helper/screens/pages/settings/manage_account.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: EdgeInsets.symmetric(
          vertical: Sizes().xxl,
          horizontal: Sizes().large,
        ),
        children: [
          Text(
            "Cuenta",
            style: TextStyle(
              fontSize: Theme.of(context).textTheme.titleLarge?.fontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          const ManageAccountButton(),
          Text(
            "Ajustes",
            style: TextStyle(
              fontSize: Theme.of(context).textTheme.titleLarge?.fontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          const ChangeDolarPriceButton(),
          const ChangeThemeModeButton(),
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
