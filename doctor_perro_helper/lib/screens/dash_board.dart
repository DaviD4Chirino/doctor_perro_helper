import 'package:doctor_perro_helper/config/border_size.dart';
import 'package:doctor_perro_helper/models/abstracts/plate_list.dart';
import 'package:doctor_perro_helper/widgets/current_date.dart';
import 'package:doctor_perro_helper/widgets/current_dolar_price.dart';
import 'package:doctor_perro_helper/widgets/menu_list_item.dart';
import 'package:doctor_perro_helper/widgets/todays_earnings.dart';
import 'package:flutter/material.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        physics: const BouncingScrollPhysics(),
        children: [
          CurrentDateText(),
          SizedBox(
            height: Sizes().xxl,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TodaysEarnings(),
              CurrentDolarPrice(),
            ],
          ),
          SizedBox(
            height: Sizes().xxxl * 2,
          ),
          const Text(
            "Menú",
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: Sizes().xl,
          ),
          ...PlateList.plates.map(
            (plate) => Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: MenuListItem(
                plate: plate,
              ),
            ),
          ),
          SizedBox(
            height: Sizes().xxl,
          ),
          Text(
            "Combos",
            style: TextStyle(
              fontSize: theme.textTheme.labelLarge?.fontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: Sizes().xl,
          ),
          ...PlateList.packs.map(
            (pack) => Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: MenuListItemPack(
                pack: pack,
              ),
            ),
          ),
          SizedBox(
            height: Sizes().xxl,
          ),
          Text(
            "Extras",
            style: TextStyle(
              fontSize: theme.textTheme.labelLarge?.fontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: Sizes().xl,
          ),
          ...PlateList.extras.map(
            (extra) => Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: MenuListItem(
                plate: extra,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
