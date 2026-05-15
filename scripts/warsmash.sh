#!/bin/bash
DIR=$(pwd)
INI_FILE="$DIR/warsmash.ini"
MAP_DIR="$HOME/Dokumente/Projekte/wowr/wowr.w3x" # Directories require absolute file paths: https://github.com/Retera/WarsmashModEngine/issues/97
#MAP_DIR="$DIR/../releases/wowr4.6.w3x"
WARSMASH_DIR="$HOME/Dokumente/Projekte/WarsmashModEngine"
cd "$WARSMASH_DIR"
git pull
git checkout tdauth
echo "See Warsmash logs in file://$(pwd)/core/assets/Logs"
xdg-open "$(pwd)/core/assets/Logs"
#./gradlew clean
# Increase Gradle heap memory:
# ~/.gradle/gradle.properties
# org.gradle.jvmargs=-Xmx4g
#
#task runGame(dependsOn: classes, type: JavaExec) {
#    mainClass = project.mainClassName
#    classpath = sourceSets.main.runtimeClasspath
#    standardInput = System.in
#    workingDir = project.assetsDir
#    ignoreExitValue = true
#    args cmdargs.split()

#    jvmArgs = ["-Xmx8g"]
#}
# For IDEA you need to set the maximum heap memory for IDEA in the UI: Help -> Change Memory Settings
JAVA_TOOL_OPTIONS="-Xmx8g -Xms1g" ./gradlew :desktop:runGame -Pargs="-loadfile $MAP_DIR -ini $INI_FILE -window"
