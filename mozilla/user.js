// Enable userChrome.css
user_pref('toolkit.legacyUserProfileCustomizations.stylesheets', true)

// Disable about:config warning
user_pref('browser.aboutConfig.showWarning', false);

// Show compact-mode as a density-option
user_pref('browser.compactmode.show', true);
user_pref('browser.uidensity', 1);

// Disabel detachable tabs
user_pref('browser.tabs.allowTabDetach', false);

// Disable tabmanager in the right corner
user_pref('browser.tabs.tabmanager.enabled', false);

// Disable thumbnails in search-results
user_pref('browser.urlbar.richSuggestions.featureGate', false);

// Disable pocket-extension
user_pref('extensions.pocket.enabled', false);

// Disable reader-mode
user_pref('reader.parse-on-load.enabled', false);

// Prevent right mouse-button from instantly clicking first option
user_pref('ui.context_menus.after_mouseup', true);

// Disable showing menubar after pressing alt-button
user_pref('ui.key.menuAccessKeyFocuses', false);

// Enable hardware-acceleration (check arch-wiki)
user_pref('gfx.webrender.all', true);
user_pref('media.ffmpeg.vaapi.enabled', true);

// Force hardware-video-decoding
user_pref('media.hardware-video-decoding.force-enabled', true);

// Remove full screen warning
user_pref('full-screen-api.warning.timeout', 0);

// Prevent the download panel from opening automatically
user_pref('browser.download.alwaysOpenPanel', false);
