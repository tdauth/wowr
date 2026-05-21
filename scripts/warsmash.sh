#!/bin/bash
DIR=$(pwd)
INI_FILE="$DIR/warsmash.ini"
MAP_DIR="$HOME/Dokumente/Projekte/wowr/wowr.w3x" # Directories require absolute file paths: https://github.com/Retera/WarsmashModEngine/issues/97
#MAP_DIR="$HOME/Dokumente/Projekte/wowr/systems/baradeslog.w3x"
#MAP_DIR="$HOME/Dokumente/Projekte/wowr/systems/baradescrafting.w3x"
#MAP_DIR="$HOME/Dokumente/Projekte/wowr/systems/baradesblackarrow.w3x"
#MAP_DIR="$HOME/Dokumente/Projekte/wowr/systems/baradesray.w3x"
#MAP_DIR="$HOME/Dokumente/Projekte/wowr/systems/pocketfactory.w3x"
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

#    jvmArgs = ["-Xmx4g"]
#}
# For IDEA you need to set the maximum heap memory for IDEA in the UI: Help -> Change Memory Settings
# clean and --rerun-tasks only for clean builds which take much longer
systemd-run --user --scope -p MemoryMax=5G -p CPUQuota=30% ./gradlew clean :desktop:runGame -Dorg.gradle.jvmargs="-Xmx4g -Xms512m" --rerun-tasks --max-workers=2 -Pargs="-loadfile $MAP_DIR -ini $INI_FILE -window" --console=plain --stacktrace --info
