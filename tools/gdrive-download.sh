#!/usr/bin/env bash

function gdrive_download {
	local FILE_ID="$1"
	local FILENAME="$2"

	curl -L -o "${FILENAME}" "https://drive.google.com/uc?export=view&id=${FILE_ID}"
}

gdrive_download "$1" "$2"
