#!/usr/bin/env bash

export ICU_ROOT=~/third_party/github_others/icu
export APP_ROOT=app

# pushd $ICU_ROOT/icu4j
# ant tests
# popd

# =======================================================

function getMain() {
  echo "Copy main code $1"
#  mkdir -p $APP_ROOT/src/main/java/com/ibm/icu/impl/data/
  pushd $ICU_ROOT/icu4j
  ant copy-data -file main/classes/$1/
  popd
  cp -R \
    $ICU_ROOT/icu4j/main/classes/$1/src/com \
    $APP_ROOT/src/main/java/
  cp -R \
    $ICU_ROOT/icu4j/main/classes/$1/out/bin/com/ibm/icu/impl/data/icudt72b/ \
    $APP_ROOT/src/main/java/com/ibm/icu/impl/data/
}

function getTest() {
  echo "Copy test code $1"
#  mkdir -p $APP_ROOT/src/androidTest/java/
  cp -R \
    $ICU_ROOT/icu4j/main/tests/$1/src/com/ \
    $APP_ROOT/src/androidTest/java/
}

# =======================================================

./cleanicu.sh

# mkdir -p $APP_ROOT/src/main/java/
mkdir -p $APP_ROOT/src/main/java/com/ibm/icu/impl/data/
mkdir -p $APP_ROOT/src/androidTest/java/

# =======================================================

getMain collate
getTest collate

getMain core
getTest core

# getMain localespi
# getTest localespi

getMain translit
getTest translit

getMain charset
getTest charset

# =======================================================

getMain regiondata
getMain currdata
getMain langdata

getTest framework
# getTest packaging

# =======================================================

mkdir -p $APP_ROOT/src/androidTest/java/com/ibm/icu/dev/tool/
cp -R \
  $ICU_ROOT/icu4j/tools/misc/src/com/ibm/icu/dev/tool/locale/ \
  $APP_ROOT/src/androidTest/java/com/ibm/icu/dev/tool/

# =======================================================

mkdir -p $APP_ROOT/libs/
cp \
  $ICU_ROOT/icu4j/main/shared/data/*.jar \
  $APP_ROOT/libs/

# =======================================================

echo Dealing with fullLocaleNames.lst
# Remove all files except for fullLocaleNames.lst
# We already copied all the files in icudt72b
# But we only want to keep the fullLocaleNames.lst
# The rest of the data files are in the jar(s) in the libs folder.
find \
  $APP_ROOT/src/main/java/com/ibm/icu/impl/data/icudt72b/ \
  -type f \
  -not -name fullLocaleNames.lst \
  -exec rm {} \;

# ====== Tests to fix in ICU:
#
# com.ibm.icu.dev.test.serializable.CompatibilityTest
#   java.lang.ClassNotFoundException: sun.util.calendar.ZoneInfo
#   Object[] oldObjects = SerializableTestUtility.getSerializedObjects(holder.b);
#
# main/classes/core/src/com/ibm/icu/impl/units/UnitsConverter.java
#   jgrep "assert .*offset == BigDecimal.ZERO" .
#   3 instances
# main/classes/core/src/com/ibm/icu/impl/units/ConversionRates.java
#   jgrep "return BigDecimal.valueOf(0)" .
#   2 instances
