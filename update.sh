# FIXME: Read these from parameters?

download() {
	if [ $# -lt 3 ]; then
		echo "Invalid parameters to download."
		return 1
	fi

	local NAME=$1
	shift

	echo "$NAME..."

	while [ $# -gt 1 ]; do
		local URL=$1
		local FILE=$2
		shift
		shift

		if ! [ -f $FILE ]; then
			printf "  Downloading $FILE... "

			if [ -z $VERBOSE ]; then
				curl --silent --retry 10 -kLy 5 -o $FILE $URL
				local RET=$?
			else
				curl --retry 10 -kLy 5 -o $FILE $URL
				local RET=$?
			fi

			if [ $RET -ne 0 ]; then
				echo "Failed!"
			else
				echo "Done."
			fi
		else
			echo "  $FILE exists, skipping."
		fi
	done

	if [ $# -ne 0 ]; then
		echo "Missing parameter."
	fi
}

real_pwd() {
	pwd | sed "s,/\(.\),\1:,"
}

update_packages() {

	# Validate config
	if [ "$CONFIG" != "Release" ] && [ "$CONFIG" != "Debug" ]; then
		echo "Unknown config."
	fi

	# Validate runtime
	if [ "$RUNTIME" == "MT" ]; then
		USE_MSVC_RUNTIME_LIBRARY_DLL=off
	elif [ "$RUNTIME" == "MD" ]; then
		USE_MSVC_RUNTIME_LIBRARY_DLL=on
	else
		echo "Unknown config."
	fi

	# Validate MSVC version
	if [ "$MSVC" == "14" ]; then
		GENERATOR="Visual Studio 14 2015"
	fi

	# Get number of bits for current arch
	if [ "$ARCH" == "X86" ]; then
		BITS=32
	elif [ "$ARCH" == "X64" ]; then
		BITS=64
		# NOTE: This must be done AFTER setting the generator!
		GENERATOR="$GENERATOR Win64"
	else
		echo "Unknown architecture."
	fi

	#source ./update-openal.sh
	#source ./update-bullet.sh # Works!
	#source ./update-sdl2.sh
	#source ./update-boost.sh
	#source ./update-glm.sh # Works!
}

update_config() {
	CONFIG="$1" # Debug or Release
	update_packages
}

update_runtime() {
	RUNTIME="$1" # MT or MD
	update_config "Release"
	update_config "Debug"
}

update_arch() {
	ARCH="$1" # X86 or X64
	update_runtime "MT"
	update_runtime "MD"
}

update_msvc() {
	MSVC="$1" # 12, 14 etc.
	update_arch "X86"
	update_arch "X64"
}

update_msvc 14

#FIXME: Package
