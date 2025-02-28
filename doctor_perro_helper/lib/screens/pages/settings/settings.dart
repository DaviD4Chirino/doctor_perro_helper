import 'package:doctor_perro_helper/config/border_size.dart';
import 'package:doctor_perro_helper/models/providers/streams/dolar_price_stream.dart';
import 'package:doctor_perro_helper/models/providers/streams/user_data_provider_stream.dart';
import 'package:doctor_perro_helper/models/providers/user.dart';
import 'package:doctor_perro_helper/models/user_role.dart';
import 'package:doctor_perro_helper/screens/pages/settings/change_dolar_price.dart';
import 'package:doctor_perro_helper/screens/pages/settings/manage_account.dart';
import 'package:doctor_perro_helper/utils/extensions/double_extensions.dart';
import 'package:doctor_perro_helper/utils/extensions/user_role_extensions.dart';
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
    final userDataStream = ref.watch(userDataProvider);

    return ListTile(
      title: const Text("Precio del dolar"),
      leading: const Icon(Icons.attach_money),
      trailing: dolarPriceStream.when(
        data: (data) => Text(data.latestValue.removePaddingZero()),
        error: (error, stackTrace) => const Text("ERROR"),
        loading: () => null,
      ),
      subtitle: userDataStream.maybeWhen(
        data: (UserData data) => data.document?.role != UserRole.admin
            ? const Text("Solo el admin puede cambiar el valor del dolar")
            : null,
        error: (error, stackTrace) => const Text("Debes iniciar sesión"),
        orElse: () => null,
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
