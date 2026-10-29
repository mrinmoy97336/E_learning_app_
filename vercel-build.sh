
#!/usr/bin/env bash
set -e

# Install the stable Flutter SDK in the build environment
git clone --depth 1 --branch stable \
  https://github.com/flutter/flutter.git \
  /tmp/flutter

export PATH="/tmp/flutter/bin:$PATH"

# Check Flutter and build the web application
flutter --version
flutter pub get
flutter build web --release
