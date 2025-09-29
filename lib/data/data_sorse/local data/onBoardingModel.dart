import 'package:car_rent/core/constant/imageassets.dart';
import 'package:car_rent/data/model/on_boarding_model.dart';
import 'package:car_rent/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

List<OnBoardingModel> onBoardingList(BuildContext context) {
  final t = AppLocalizations.of(context);
  if (t == null) return [];

  return [
    OnBoardingModel(
      title: t.chooseProduct,
      image: Imageassets.onBoardingImageOne,
      description: t.chooseProductDesc,
    ),
    OnBoardingModel(
      title: t.easyPayment,
      image: Imageassets.onBoardingImageTwo,
      description: t.easyPaymentDesc,
    ),
    OnBoardingModel(
      title: t.fastDelivery,
      image: Imageassets.onBoardingImageThree,
      description: t.fastDeliveryDesc,
    ),
  ];
}
