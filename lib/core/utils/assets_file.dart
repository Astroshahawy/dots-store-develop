class AssetsFile {
  static const assetsPath = 'assets';
  //* lottie paths
  static const lottiesPath = 'assets/lotties';

  static const phoneVerifyLottie =
      '$lottiesPath/phone-number-verification.json';
  static const callCenterLottie = '$lottiesPath/call-center.json';
  static const String emptyDataLottie = '$lottiesPath/empty-data.json';

  //*
  static const imagePath = '$assetsPath/images';

  //*
  static const l10n = '$assetsPath/l10n';
  static const assets = 'assets';

  static String images(String image) => '$assets/images/$image';
  static String onBoarding(String image) => '$assets/images/on_boarding/$image';
  static String svg(String svg) => '$assets/svg/$svg';
  static String lottie(String lottie) => '$assets/lotties/$lottie';
  static String icon(String icon) => '$assets/icons/$icon';

  // static const imagePath = '$assets/images';
  // static const svgPath = '$assets/svg';
  // static const l10n = '$assets/l10n';
}
