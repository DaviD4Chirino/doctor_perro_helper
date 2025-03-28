import 'dart:async';

import 'package:doctor_perro_helper/models/order/menu_order.dart';
import 'package:doctor_perro_helper/models/providers/streams/menu_order_stream.dart';

StreamSubscription<List<MenuOrder>> menuOrderSubscription =
    menuOrderStream.listen((List<MenuOrder> event) => event);
