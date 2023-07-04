# Mobile Ads Flutter Plugin

Flutter plugin for Yandex Mobile Ads SDK. Plugin allows Flutter developers to integrate Yandex Mobile Ads SDK into
Android and iOS apps.

## Documentation

Documentation could be found at the [official website] [DOCUMENTATION]

## License

EULA is available at [EULA website] [LICENSE]

## Quick start in Android Studio / Visual Studio Code

#### 1. Import this project

#### 2. Build and run.

## Integration

### Configuring pubspec

##### Add YandexMobileAds SDK:

```yaml
dependencies:
  yandex_mobileads: ^1.3.0
```

### Mediation

##### You can also connect our libraries with all available mediations:

#### Android

`android/app/build.gradle`:

You can use common mediation dependency including all adapters (recommended):

```groovy
dependencies {
    // ...
    implementation 'com.yandex.android:mobileads-mediation:5.9.0.0'
}
```

Or you can choose adapters manually and include only their dependencies:

```groovy
dependencies {
    // ...
    implementation 'com.yandex.android:mobileads:5.9.0'
    implementation 'com.yandex.ads.mediation:mobileads-admob:21.5.0.1'
    implementation 'com.yandex.ads.mediation:mobileads-mytarget:5.16.5.0'
    implementation 'com.yandex.ads.mediation:mobileads-startapp:4.11.0.0'
    implementation 'com.yandex.ads.mediation:mobileads-unityads:4.7.1.1'
    implementation 'com.yandex.ads.mediation:mobileads-applovin:11.10.1.0'
    implementation 'com.yandex.ads.mediation:mobileads-ironsource:7.3.1.0'
    implementation 'com.yandex.ads.mediation:mobileads-adcolony:4.8.0.4'
    implementation 'com.yandex.ads.mediation:mobileads-chartboost:9.3.0.1'
    implementation 'com.yandex.ads.mediation:mobileads-pangle:4.9.1.5.0'
    implementation 'com.yandex.ads.mediation:mobileads-tapjoy:12.11.1.1'
    implementation 'com.yandex.ads.mediation:mobileads-vungle:6.12.1.1'
    implementation 'com.yandex.ads.mediation:mobileads-mintegral:16.4.61.0'
}
```

Anyway, if you plan to use Admob, you need to add your AdMob ID to the AndroidManifest.xml file
using a `<meta-data>` tag named `com.google.android.gms.ads.APPLICATION_ID`:

```xml
<manifest>
    <application>
        <meta-data
            android:name="com.google.android.gms.ads.APPLICATION_ID"
            android:value="ca-app-pub-xxxxxxxxxxxxxxxx~yyyyyyyyyy"/>
    </application>
</manifest>
```

Some adapters also require adding specific maven urls:

`android/build.gradle`:

```groovy
allprojects {
    repositories {
        // ...
        // IronSource
        maven { url 'https://android-sdk.is.com/' }
        // Pangle
        maven { url 'https://artifact.bytedance.com/repository/pangle' }
        // Tapjoy
        maven { url "https://sdk.tapjoy.com/" }
        // Mintegral
        maven { url "https://dl-maven-android.mintegral.com/repository/mbridge_android_sdk_oversea" }
    }
}
```

#### iOS

You can use common mediation dependency including all adapters (recommended):

`ios/Podfile`:

```ruby
pod 'YandexMobileAdsMediation', '~> 5.8.0'
```

Or you can choose adapters manually and include only their dependencies:

```ruby
pod 'YandexMobileAds', '~> 5.8.0'
pod 'AdMobYandexMobileAdsAdapters', '10.6.0.0'
pod 'MyTargetYandexMobileAdsAdapters', '5.17.5.0'
pod 'StartAppYandexMobileAdsAdapters', '4.7.3.0'
pod 'UnityAdsYandexMobileAdsAdapters', '4.7.1.1'
pod 'AppLovinYandexMobileAdsAdapters', '11.10.1.0'
pod 'IronSourceYandexMobileAdsAdapters', '7.3.0.2'
pod 'MintegralYandexMobileAdsAdapters', '7.3.8.0'
pod 'AdColonyYandexMobileAdsAdapters', '4.9.0.3'
pod 'ChartboostYandexMobileAdsAdapters', '9.3.0.1'
```

Anyway, if you plan to use Admob, add the GADApplicationIdentifier key with your AdMob ID
to your app's Info.plist file

`ios/Info.plist`:
```xml
<key>GADApplicationIdentifier</key>
<string>ca-app-pub-xxxxxxxxxxxxxxxx~yyyyyyyyyy</string>
```

Networks also require adding specific SKAdNetworkIdentifiers to SKAdNetworkItems:

`ios/Info.plist`:

```xml
<key>SKAdNetworkItems</key>
<array>
<!-- Yandex Ads -->
<dict>
    <key>SKAdNetworkIdentifier</key>
    <string>zq492l623r.skadnetwork</string>
</dict>
<dict>
    <!-- AdMob -->
    <key>SKAdNetworkIdentifier</key>
    <string>cstr6suwn9.skadnetwork</string>
</dict>
<dict>
    <!-- MyTarget -->
    <key>SKAdNetworkIdentifier</key>
    <string>n9x2a789qt.skadnetwork</string>
</dict>
<dict>
    <!-- MyTarget -->
    <key>SKAdNetworkIdentifier</key>
    <string>r26jy69rpl.skadnetwork</string>
</dict>
<dict>
    <!-- Start.io -->
    <key>SKAdNetworkIdentifier</key>
    <string>5l3tpt7t6e.skadnetwork</string>
</dict>
<dict>
    <!-- UnityAds -->
    <key>SKAdNetworkIdentifier</key>
    <string>4dzt52r2t5.skadnetwork</string>
</dict>
<dict>
    <!-- IronSource -->
    <key>SKAdNetworkIdentifier</key>
    <string>su67r6k2v3.skadnetwork</string>
</dict>
<dict>
    <!-- Applovin -->
    <key>SKAdNetworkIdentifier</key>
    <string>ludvb6z3bs.skadnetwork</string>
</dict>
<dict>
    <!-- Mintegral -->
    <key>SKAdNetworkIdentifier</key>
    <string>KBD757YWX3.skadnetwork</string>
</dict>
</array>
```

[DOCUMENTATION]: https://yandex.com/dev/mobile-ads/doc/intro/about.html

[LICENSE]: https://yandex.com/legal/mobileads_sdk_agreement/
