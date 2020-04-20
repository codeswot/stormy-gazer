import 'package:firebase_admob/firebase_admob.dart';

const String testDevice = '6F421817C7DCB6C6CF3BFAA4344BC165';
const String appId = 'ca-app-pub-8194628159434954~4352650425';

class AdsServices {
  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
      testDevices: testDevice != null ? <String>[testDevice] : null,
      nonPersonalizedAds: true,
      keywords: ['Game']);

  BannerAd _bannerAd;
  InterstitialAd _interstitialAd;

  final NativeAd nativeAd = NativeAd(
    adUnitId: 'ca-app-pub-8194628159434954/3896343091',
    factoryId: 'adFactoryExample',
    targetingInfo: targetingInfo,
    listener: (MobileAdEvent event) {
      print("$NativeAd event $event");
    },
  );
  BannerAd createBannerAd() {
    return BannerAd(
        targetingInfo: targetingInfo,
        adUnitId: 'ca-app-pub-8194628159434954/1134200966',
        size: AdSize.banner,
        listener: (MobileAdEvent event) {
          print('BannerAd$event');
        });
  }

  InterstitialAd createInterstitialAd() {
    return InterstitialAd(
        targetingInfo: targetingInfo,
        adUnitId: 'ca-app-pub-8194628159434954/7097221505',
        listener: (MobileAdEvent event) {
          print('InterstitialAd$event');
        });
  }

  runAds() {
    FirebaseAdMob.instance.initialize(appId: appId);
    _bannerAd = createBannerAd()
      ..load()
      ..show();
  }

  disposeAds() {
    _bannerAd.dispose();
    _interstitialAd.dispose();
  }
}
