mixin CurrencyHelper {
  static String convertCurrency({
    required num? price,
    String? icon,
    bool showIcon = true,
  }) {
    if (price == null) return '';
    return showIcon ? '$price ${icon ?? '\$'}' : '$price';
  }
}
