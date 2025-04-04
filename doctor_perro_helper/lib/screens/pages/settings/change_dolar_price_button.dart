import 'package:doctor_perro_helper/models/consumers/dolar_price_text.dart';
import 'package:doctor_perro_helper/models/providers/streams/user_data_provider_stream.dart';
import 'package:doctor_perro_helper/models/providers/user.dart';
import 'package:doctor_perro_helper/models/user_role.dart';
import 'package:doctor_perro_helper/screens/pages/settings/change_dolar_price.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChangeDolarPriceButton extends ConsumerWidget {
  const ChangeDolarPriceButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<UserData> userDataStream = ref.watch(userDataProvider);
    final ThemeData theme = Theme.of(context);

    return ListTile(
      title: const Text("Precio del dolar"),
      leading: const Icon(Icons.attach_money),
      trailing: CurrentDolarPriceText(
        text: (String latestValue) => "${latestValue}bs",
        style: TextStyle(
          fontSize: theme.textTheme.labelLarge?.fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
      // if the user is admin, do not show a waring
      subtitle: userDataStream.maybeWhen(
        data: (UserData data) => data.document?.role != UserRole.admin
            ? const Text("Solo el admin puede cambiar el valor del dolar")
            : null,
        error: (error, stackTrace) => const Text("Debes iniciar sesión"),
        orElse: () => null,
      ),
      // if the user is admin, let them go to the dialog
      onTap: userDataStream.maybeWhen(
        data: (data) => data.document?.role == UserRole.admin
            ? () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => const ChangeDolarPrice(),
                );
              }
            : null,
        orElse: () => null,
      ),
    );
  }
}
