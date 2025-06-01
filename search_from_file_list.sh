#!/bin/bash
#
# search_from_file_list.sh
#
# searches for files by name from a list in the current working directory
# (and subdirectories)
#
# (c) public domain / MIT
#

read -r -d '' file_list <<'EOF'
*.exe
*.dll
EOF

echo "${file_list}" | while read -r line; do
  find . -name "${line}" -type f
done
# also: save to file.txt :
#done 2>&1 | tee -a "file.txt"

# EOF
