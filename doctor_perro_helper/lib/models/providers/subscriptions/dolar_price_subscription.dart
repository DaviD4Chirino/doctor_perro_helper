import 'dart:async';

import 'package:doctor_perro_helper/models/dolar_price_in_bs.dart';
import 'package:doctor_perro_helper/models/providers/streams/dolar_price_stream.dart';

StreamSubscription<DolarPriceInBsDoc> dolarPriceSubscription =
    dolarPriceStream.listen((DolarPriceInBsDoc event) => event);
