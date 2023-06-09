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
  yandex_mobileads: ^1.2.0
```

### Mediation

##### You can also connect our libraries with all available mediations:

#### Android

`android/app/build.gradle`:

```groovy
dependencies {
    // ...
    implementation 'com.yandex.android:mobileads-mediation:5.8.0.0'
}
```

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

`ios/Podfile`:

```ruby
pod 'YandexMobileAdsMediation', '~> 5.7.0'
```

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
