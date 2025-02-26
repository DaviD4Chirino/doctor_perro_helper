import 'package:doctor_perro_helper/config/border_size.dart';
import 'package:doctor_perro_helper/models/providers/streams/dolar_price_stream.dart';
import 'package:doctor_perro_helper/screens/pages/settings/change_dolar_price.dart';
import 'package:doctor_perro_helper/screens/pages/settings/manage_account.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
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
          const ManageAccount(),
          Text(
            "Ajustes",
            style: TextStyle(
              fontSize: Theme.of(context).textTheme.titleLarge?.fontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          const ChangeDolarPriceButton(),
        ],
      ),
    );
  }
}

class ChangeDolarPriceButton extends ConsumerWidget {
  const ChangeDolarPriceButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dolarPriceStream = ref.watch(dolarPriceProvider);

    return SettingButton(
      child: ListTile(
        title: const Text("Precio del dolar"),
        leading: const Icon(Icons.attach_money),
        trailing: dolarPriceStream.when(
          data: (data) => Text("${data.latestValue}"),
          error: (error, stackTrace) => const Text("ERROR"),
          loading: () => null,
        ),
      ),
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) => const ChangeDolarPrice(),
        );
      },
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
