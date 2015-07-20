#!/bin/sh
set -e

echo "mkdir -p ${CONFIGURATION_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
mkdir -p "${CONFIGURATION_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"

SWIFT_STDLIB_PATH="${DT_TOOLCHAIN_DIR}/usr/lib/swift/${PLATFORM_NAME}"

install_framework()
{
  if [ -r "${BUILT_PRODUCTS_DIR}/$1" ]; then
    local source="${BUILT_PRODUCTS_DIR}/$1"
  else
    local source="${BUILT_PRODUCTS_DIR}/$(basename "$1")"
  fi

  local destination="${CONFIGURATION_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"

  if [ -L "${source}" ]; then
      echo "Symlinked..."
      source="$(readlink "${source}")"
  fi

  # use filter instead of exclude so missing patterns dont' throw errors
  echo "rsync -av --filter \"- CVS/\" --filter \"- .svn/\" --filter \"- .git/\" --filter \"- .hg/\" --filter \"- Headers\" --filter \"- PrivateHeaders\" --filter \"- Modules\" \"${source}\" \"${destination}\""
  rsync -av --filter "- CVS/" --filter "- .svn/" --filter "- .git/" --filter "- .hg/" --filter "- Headers" --filter "- PrivateHeaders" --filter "- Modules" "${source}" "${destination}"

  # Resign the code if required by the build settings to avoid unstable apps
  code_sign_if_enabled "${destination}/$(basename "$1")"

  # Embed linked Swift runtime libraries
  local basename
  basename="$(basename "$1" | sed -E s/\\..+// && exit ${PIPESTATUS[0]})"
  local swift_runtime_libs
  swift_runtime_libs=$(xcrun otool -LX "${CONFIGURATION_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}/${basename}.framework/${basename}" | grep --color=never @rpath/libswift | sed -E s/@rpath\\/\(.+dylib\).*/\\1/g | uniq -u  && exit ${PIPESTATUS[0]})
  for lib in $swift_runtime_libs; do
    echo "rsync -auv \"${SWIFT_STDLIB_PATH}/${lib}\" \"${destination}\""
    rsync -auv "${SWIFT_STDLIB_PATH}/${lib}" "${destination}"
    code_sign_if_enabled "${destination}/${lib}"
  done
}

# Signs a framework with the provided identity
code_sign_if_enabled() {
  if [ -n "${EXPANDED_CODE_SIGN_IDENTITY}" -a "${CODE_SIGNING_REQUIRED}" != "NO" -a "${CODE_SIGNING_ALLOWED}" != "NO" ]; then
    # Use the current code_sign_identitiy
    echo "Code Signing $1 with Identity ${EXPANDED_CODE_SIGN_IDENTITY_NAME}"
    echo "/usr/bin/codesign --force --sign ${EXPANDED_CODE_SIGN_IDENTITY} --preserve-metadata=identifier,entitlements \"$1\""
    /usr/bin/codesign --force --sign ${EXPANDED_CODE_SIGN_IDENTITY} --preserve-metadata=identifier,entitlements "$1"
  fi
}


if [[ "$CONFIGURATION" == "Debug" ]]; then
  install_framework 'Pods-HG Network/AFNetworking.framework'
  install_framework 'Pods-HG Network/ALThreeCircleSpinner.framework'
  install_framework 'Pods-HG Network/ASProgressPopUpView.framework'
  install_framework 'Pods-HG Network/ActionSheetPicker.framework'
  install_framework 'Pods-HG Network/BlockRSSParser.framework'
  install_framework 'Pods-HG Network/CocoaSecurity.framework'
  install_framework 'Pods-HG Network/FRDLivelyButton.framework'
  install_framework 'Pods-HG Network/FXBlurView.framework'
  install_framework 'Pods-HG Network/FlatUIKit.framework'
  install_framework 'Pods-HG Network/HexColors.framework'
  install_framework 'Pods-HG Network/MBProgressHUD.framework'
  install_framework 'Pods-HG Network/MGSwipeTableCell.framework'
  install_framework 'Pods-HG Network/NSUserDefaults_AESEncryptor.framework'
  install_framework 'Pods-HG Network/OHActionSheet.framework'
  install_framework 'Pods-HG Network/ObjectiveSugar.framework'
  install_framework 'Pods-HG Network/ParallaxBlur.framework'
  install_framework 'Pods-HG Network/QRCodeReaderViewController.framework'
  install_framework 'Pods-HG Network/REComposeViewController.framework'
  install_framework 'Pods-HG Network/RMMapper.framework'
  install_framework 'Pods-HG Network/SKSplashView.framework'
  install_framework 'Pods-HG Network/TPKeyboardAvoiding.framework'
  install_framework 'Pods-HG Network/TextFieldEffects.framework'
  install_framework 'Pods-HG Network/UITableView_FDTemplateLayoutCell.framework'
  install_framework 'Pods-HG Network/YLProgressBar.framework'
  install_framework 'Pods-HG Network/ZFRippleButton.framework'
  install_framework 'Pods-HG Network/iOS_Slide_Menu.framework'
fi
if [[ "$CONFIGURATION" == "Release" ]]; then
  install_framework 'Pods-HG Network/AFNetworking.framework'
  install_framework 'Pods-HG Network/ALThreeCircleSpinner.framework'
  install_framework 'Pods-HG Network/ASProgressPopUpView.framework'
  install_framework 'Pods-HG Network/ActionSheetPicker.framework'
  install_framework 'Pods-HG Network/BlockRSSParser.framework'
  install_framework 'Pods-HG Network/CocoaSecurity.framework'
  install_framework 'Pods-HG Network/FRDLivelyButton.framework'
  install_framework 'Pods-HG Network/FXBlurView.framework'
  install_framework 'Pods-HG Network/FlatUIKit.framework'
  install_framework 'Pods-HG Network/HexColors.framework'
  install_framework 'Pods-HG Network/MBProgressHUD.framework'
  install_framework 'Pods-HG Network/MGSwipeTableCell.framework'
  install_framework 'Pods-HG Network/NSUserDefaults_AESEncryptor.framework'
  install_framework 'Pods-HG Network/OHActionSheet.framework'
  install_framework 'Pods-HG Network/ObjectiveSugar.framework'
  install_framework 'Pods-HG Network/ParallaxBlur.framework'
  install_framework 'Pods-HG Network/QRCodeReaderViewController.framework'
  install_framework 'Pods-HG Network/REComposeViewController.framework'
  install_framework 'Pods-HG Network/RMMapper.framework'
  install_framework 'Pods-HG Network/SKSplashView.framework'
  install_framework 'Pods-HG Network/TPKeyboardAvoiding.framework'
  install_framework 'Pods-HG Network/TextFieldEffects.framework'
  install_framework 'Pods-HG Network/UITableView_FDTemplateLayoutCell.framework'
  install_framework 'Pods-HG Network/YLProgressBar.framework'
  install_framework 'Pods-HG Network/ZFRippleButton.framework'
  install_framework 'Pods-HG Network/iOS_Slide_Menu.framework'
fi
