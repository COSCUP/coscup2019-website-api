#!/usr/bin/env bash
DIR=$(dirname $(dirname $0))
DIST=$DIR/dist
TOOLS=$DIR/tools

LANGS=(
	zh_TW
	en
	jp
)

for lang in "${LANGS[@]}"; do
	PLACE="${DIST}/${lang}"
	mkdir -p "$PLACE"

	# Fetch staffs
	curl -Lo "${PLACE}/staffs.json" "https://script.google.com/macros/s/AKfycbzLwVwgGfl0GAjPXj_7OzSwVMeTSd4xr0fjsmkXGvGziLgzdahl/exec?lang=$lang"

	# Fetch sponsors
	curl -Lo "${PLACE}/sponsors.json" "https://script.google.com/macros/s/AKfycbz8ZgSZoLK_ylD87_mPJrjtJwIJ9XJqsGBcYSTPta5H5gQauik/exec?lang=$lang"
	$TOOLS/process-sponsors.sh "${PLACE}/sponsors.json"

	# Fetch cohosts
	# curl -Lo "${PLACE}/cohosts.json" "https://script.google.com/a/coscup.tw/macros/s/AKfycbyEYqMFjcP2I3NofpseX3s1gs1Fq7OAz6ryqUJ_Tg/exec?lang=$lang"
	# $TOOLS/process-cohosts.sh "${PLACE}/cohosts.json"
	echo '{ "levels":{}, "cohosts":[] }'> "${PLACE}/cohosts.json"

	# Fetch programs
	# curl -Lo "${PLACE}/programs.json" "https://script.google.com/macros/s/AKfycbwm9gZrW9H3tN_qk-sW2kIJ4i2BFJu4CJkguRIRekxBM6k1zcjN/exec?lang=$lang"
	# $TOOLS/process-programs.sh "${PLACE}/programs.json"
	echo '{ "talks":{}, "tracks":{}, "speakers":{}, "communities":{} }' > "${PLACE}/programs.json"

	# Generate talks
	node $TOOLS/generate-talks.js $lang
done

