<!-- cspell:ignore xcassets -->
# 👣 First Steps

## Update the app icon
<!--{{#include_android_platform}}-->
### Android

#### Resources:

- [Google Play icon design specifications](https://developer.android.com/distribute/google-play/resources/icon-design-specifications)
  > Describes the guidelines you should follow when creating assets for your app's listing on Google Play.
- [Product Icons](https://m2.material.io/design/iconography/product-icons.html)
  > These guidelines are a starting point to ensure that your product icon colors and key elements reflect your brand identity.
- [Adaptive icons](https://developer.android.com/develop/ui/views/launch/icon_design_adaptive)
  > An adaptive icon can display differently depending on individual device capabilities and user theming.
- [Create app icons](https://developer.android.com/studio/write/create-app-icons)
  > To create custom icons or icons for your app with Views, Android Studio offers Image Asset Studio.

#### Opinionated guide

For each flavor, you should create an adaptive icon by following these steps:

1. Right click on the `android` folder in the `app` package.
2. Select the **Open in Android Studio** action.
3. In Android Studio, pick the **Android** view.
4. Right click on the `app` module folder.
5. In the context menu, select the **New** > **Image Asset**.
6. Use **Launcher Icons (Adaptive ane Legacy)** as **Icon type**.
7. Keep `ic_launcher` as the **Name**.
8. Set the **Foreground Layer** details.
   1. Keep `ic_launcher_foreground` as the **Layer name**.
   2. Use an **Image** as the **Asset type**.
   3. Pick the desired image (SVG is recommended).
   4. Set the desired **Scaling** configuration.
9.  Set the **Background Layer** details.
10. Set the **Options**.
    1. Generate all variants.
    2. Use WebP format when possible.
 11. Click on the **Next** button.
 12. Select the desired flavor as the **Source set**.
 13. Review the outputs.
 14. Click on the **Finish** button.
<!--{{/include_android_platform}}x-->
<!--x{{#include_ios_platform}}-->
### iOS

#### Resources:

- [App icons](https://developer.apple.com/design/human-interface-guidelines/app-icons)\
  Design guidance on iOS app icons.
- [Configuring your app icon](https://developer.apple.com/documentation/xcode/configuring-your-app-icon)\
  Developer guidance on how to setup your app icon.
- [App Icon Generator](https://www.appicon.co/)\
  Tool to generate all required iOS app icons from a single source image.

#### Opinionated guide

For each flavor, you should create an app icon by following these steps:

1. Right click on the `ios` folder in the `app` package.
2. Select the **Open in Xcode** action.
3. In Xcode, pick the **Project navigator** view.
4. Select the `Runner/Runner/Resources/Assets` (`Assets.xcassets`) folder.
5.  Select the asset corresponding to the app icon for the desired flavor.
6. In the attributes of the set, make sure to use **Single Size** for **iOS**.
7. In the attributes of the set, select the desired **Appearance**.
8.  Double click on the desired asset variant placeholder and pick the desired image (it should be a 1024x1024 PNG file).

As long as you pick the **Single Size** option, you will be required to pick a single 1024x1024 PNG file, which you can generate using the [App Icon Generator](https://www.appicon.co/) tool.
<!--{{/include_ios_platform}}x-->
<!--x{{#include_macos_platform}}-->
### macOS

#### Resources:

- [App icons](https://developer.apple.com/design/human-interface-guidelines/app-icons)\
  Design guidance on macOS app icons.
- [Configuring your app icon](https://developer.apple.com/documentation/xcode/configuring-your-app-icon)\
  Developer guidance on how to setup your app icon.
- [App Icon Generator](https://www.appicon.co/)\
  Tool to generate all required macOS app icons from a single source image.

#### Opinionated guide

For each flavor, you should create an app icon by following these steps:

1. Right click on the `macos` folder in the `app` package.
2. Select the **Open in Xcode** action.
3. In Xcode, pick the **Project navigator** view.
4. Select the `Runner/Runner/Resources/Assets` (`Assets.xcassets`) folder.
5.  Select the asset corresponding to the app icon for the desired flavor.
6. In the attributes of the set, make sure to use **All Sizes** for **macOS**.
7.  Double click on the desired asset variant placeholder and pick the desired image.

Since **All Sizes** option is selected, you will be required to provide PNG files for the following sizes: 16x16, 32x32, 128x128, 256x256, 512x512 and 1024x1024. You can generate these files using the [App Icon Generator](https://www.appicon.co/) tool.
<!--{{/include_macos_platform}}x-->
<!--x{{#include_web_platform}}-->
### Web

#### Resources:

- [Web app manifests](https://developer.mozilla.org/en-US/docs/Web/Manifest)\
  Documentation on web app manifests and PWA configuration.
- [PWA Asset Generator](https://github.com/onderceylan/pwa-asset-generator)\
  Tool to generate all required PWA assets from a single source image.

#### Opinionated guide

For the web platform, you should update the following assets:

1. Update the `web/favicon.png` file with your app's icon (16x16 pixels PNG).
2. Update the PNG files under the `web/icons/` directory with your app's icon (192x192 and 512x512 pixels PNG).
3. Adjust the `theme_color` and `background_color` fields in the `web/manifest.json` file to match your app's branding.
<!--{{/include_web_platform}}-->
<!--x{{#include_macos_platform}}-->
## Update other platform-specific information

### macOS

#### `PRODUCT_OWNER` configuration key

The `PRODUCT_OWNER` configuration variable is used to resolve the copyright displayed in the app's information.

1. Open the `packages/app/macos/Runner/Configs/BaseAppInfo.xcconfig` file.
2. Set the `PRODUCT_OWNER` variable to your company or organization name.
<!--{{/include_macos_platform}}-->
