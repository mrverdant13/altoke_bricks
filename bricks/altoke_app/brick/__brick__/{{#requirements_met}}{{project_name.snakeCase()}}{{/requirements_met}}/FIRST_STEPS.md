 <!-- cspell:ignore xcassets -->
# 👣 First Steps

## 1. Update the app icon.

### 1.1. Android

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

### 1.2. iOS

#### Resources:

- [App icons](https://developer.apple.com/design/human-interface-guidelines/app-icons)\
  Design guidance on iOS app icons.
- [Configuring your app icon](https://developer.apple.com/documentation/xcode/configuring-your-app-icon)\
  Developer guidance on how to setup your app icon.

#### Opinionated guide

For each flavor, you should create an app icon by following these steps:

1. Right click on the `ios` folder in the `app` package.
2. Select the **Open in Xcode** action.
3. In Xcode, pick the **Project navigator** view.
4. Select the `Runner/Runner/Assets` (`Assets.xcassets`) folder.
5.  Select the asset corresponding to the app icon for the desired flavor.
6. In the attributes of the set, make sure to use **Single Size** for **iOS**.
7. In the attributes of the set, select the desired **Appearance**.
8.  Double click on the desired asset variant placeholder and pick the desired image (it should be a 1024x1024 PNG file).
