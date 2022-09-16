#!/usr/bin/bash -e

(( EUID == 0 )) && { echo >&2 "This script should not be run as root!"; exit 1; }

# -------------------------------------------------------------------------------------------------------------------- #
# CONFIGURATION.
# -------------------------------------------------------------------------------------------------------------------- #

tar="$( command -v tar )"
date="$( command -v date )"

# Help.
read -r -d '' help <<- EOF
Options:
  -d 'DIR_1;DIR_2;DIR_3'                  Directories.
EOF

# -------------------------------------------------------------------------------------------------------------------- #
# OPTIONS.
# -------------------------------------------------------------------------------------------------------------------- #

OPTIND=1

while getopts "d:h" opt; do
  case ${opt} in
    d)
      dirs="${OPTARG}"; IFS=';' read -ra dirs <<< "${dirs}"
      ;;
    h|*)
      echo "${help}"
      exit 2
      ;;
  esac
done

shift $(( OPTIND - 1 ))

(( ! ${#dirs[@]} )) && exit 1

# -------------------------------------------------------------------------------------------------------------------- #
# INITIALIZATION.
# -------------------------------------------------------------------------------------------------------------------- #

init() {
  # Functions.
  ts_date="$( _ts_date )"

  # Run.
  backup
}

# -------------------------------------------------------------------------------------------------------------------- #
# BACKUP: FILES.
# -------------------------------------------------------------------------------------------------------------------- #

backup() {
  for dir in "${dirs[@]}"; do
    name="${dir}.${ts_date}"

    echo "" && echo "--- OPEN: '${dir}'"
    ${tar} -cJf "${name}.tar.xz" "${dir}"
    echo "" && echo "--- DONE: '${dir}'" && echo ""
  done
}

# -------------------------------------------------------------------------------------------------------------------- #
# ------------------------------------------------< COMMON FUNCTIONS >------------------------------------------------ #
# -------------------------------------------------------------------------------------------------------------------- #

# Timestamp: Date.
_ts_date() {
  ${date} -u '+%Y-%m-%d.%H-%M-%S'
}

# -------------------------------------------------------------------------------------------------------------------- #
# -------------------------------------------------< INIT FUNCTIONS >------------------------------------------------- #
# -------------------------------------------------------------------------------------------------------------------- #

init "$@"; exit 0
