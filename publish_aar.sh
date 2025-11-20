#!/bin/bash

set -euo pipefail

# Script to publish bundled AARs to a local Maven repository that Gradle can resolve
cd "$(dirname "$0")"
PLUGIN_DIR=$(pwd)
LIBS_DIR="$PLUGIN_DIR/android/libs"
MAVEN_LOCAL="$PLUGIN_DIR/android/libs-maven-local"

# groupId|artifactId|version|aarFileName
DEPENDENCIES=(
  "com.vnpt.flutter_plugin_ic_nfc|vnpt-nfc-sdk|1.8.0|vnpt_nfc_sdk-v1.8.0.aar"
  "com.vnpt.flutter_plugin_ic_nfc|scanqr-ic-sdk|1.0.6|scanqr_ic_sdk-v1.0.6.aar"
)

timestamp=$(date +%Y%m%d%H%M%S)
echo "Publishing AARs to local Maven repo: $MAVEN_LOCAL"

for dependency in "${DEPENDENCIES[@]}"; do
  IFS="|" read -r GROUP_ID ARTIFACT_ID VERSION FILE_NAME <<< "$dependency"
  SOURCE_FILE="$LIBS_DIR/$FILE_NAME"
  if [[ ! -f "$SOURCE_FILE" ]]; then
    echo "❌ Missing AAR: $SOURCE_FILE"
    exit 1
  fi

  TARGET_DIR="$MAVEN_LOCAL/${GROUP_ID//.//}/$ARTIFACT_ID/$VERSION"
  mkdir -p "$TARGET_DIR"

  echo "→ Publishing $FILE_NAME as $GROUP_ID:$ARTIFACT_ID:$VERSION"
  cp "$SOURCE_FILE" "$TARGET_DIR/$ARTIFACT_ID-$VERSION.aar"

  cat > "$TARGET_DIR/$ARTIFACT_ID-$VERSION.pom" <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 https://maven.apache.org/xsd/maven-4.0.0.xsd">
  <modelVersion>4.0.0</modelVersion>
  <groupId>$GROUP_ID</groupId>
  <artifactId>$ARTIFACT_ID</artifactId>
  <version>$VERSION</version>
  <packaging>aar</packaging>
</project>
EOF

  cat > "$MAVEN_LOCAL/${GROUP_ID//./\/}/$ARTIFACT_ID/maven-metadata.xml" <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<metadata>
  <groupId>$GROUP_ID</groupId>
  <artifactId>$ARTIFACT_ID</artifactId>
  <versioning>
    <latest>$VERSION</latest>
    <release>$VERSION</release>
    <versions>
      <version>$VERSION</version>
    </versions>
    <lastUpdated>$timestamp</lastUpdated>
  </versioning>
</metadata>
EOF
done

echo "✅ Finished publishing AARs to $MAVEN_LOCAL"