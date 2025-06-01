#!/bin/bash
#
# sha256_hash_files.sh
#
# creates sha256 hashes for all files in the current working directory
# (and subdirectories), sorts files alphabetically
#
# (c) public domain / MIT
#

if [ "$#" -ne 1 ]; then
  echo ""
  echo "Usage: $0 [OUT_checksums.sha256]"
  exit 1
fi

checksums_file="$1"

cat <<EOF > "${checksums_file}"
$(find . -type f -exec sha256sum {} \; | sort -k 2)
EOF

# EOF
