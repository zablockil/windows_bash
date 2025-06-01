#!/bin/bash
#
# check_dll_dependency.sh
#
# script searches current working directory (and subdirectories) for *.exe and
# *.dll files and creates a DLL dependency report
#
# (c) public domain / MIT
#
# tested on Windows 10 and msys2
#

if [ "$#" -ne 1 ]; then
  echo ""
  echo "Usage: $0 [REPORT_OUT_TXT]"
  exit 1
fi

report_file="$1"

# displays Windows version, combines bash command line with cmd
# CRLF -> LF
cat <<EOF | awk -v RS='\r?\n' -v ORS='\n' 1 > "${report_file}"
$(cmd //c ver)

Here's the full list of files that will be checked:
---------------------------------------------------
$(find . '(' -name "*.exe" -o -name "*.dll" ')' -type f)
---------------------------------------------------

EOF

# * Sigcheck v2.90 :
#   https://learn.microsoft.com/en-us/sysinternals/downloads/sigcheck
# * dumpbin.exe :
#   https://github.com/Delphier/dumpbin/releases
# * Dependencies.exe :
#   https://github.com/lucasg/Dependencies/releases
#
# NOTE
#   dumpbin.exe (from github) requires the following .dll files to run
#   (you may not have them on a clean system) :
# MSVCP140_ATOMIC_WAIT.dll
# VCRUNTIME140.dll
# VCRUNTIME140_1.dll
# mscoree.dll
# MSVCP140.dll
#
# displays the results of these programs and removes spaces at the end of each line
multiple_cmd() {
cat <<EOF | awk -v RS='\r?\n' -v ORS='\n' '{sub(/[ \t]+$/,"");print}'
================================================================================
$(echo "$1" --***--)
-=-=-=-=-=-=-=-=-=-=-=-=-
  sigcheck64.exe COMMAND:
-=-=-=-=-=-=-=-=-=-=-=-=-
$('/c/Program Files/Sigcheck/sigcheck64.exe' -accepteula -nobanner -r "$1" | expand)
-=-=-=-=-=-=-=-=-=-=-=
  dumpbin.exe COMMAND:
-=-=-=-=-=-=-=-=-=-=-=
$('/c/Program Files/dumpbin/dumpbin.exe' //DEPENDENTS //NOLOGO "$1" | awk '/^$/ {next} /Image has the following dependencies:/{flag = 1};/^[ \t]+Summary/{flag = 0};flag {print}')
-=-=-=-=-=-=-=-=-=-=-=-=-=-
  Dependencies.exe COMMAND:
-=-=-=-=-=-=-=-=-=-=-=-=-=-
$('/c/Program Files/Dependencies_x64_Release/Dependencies.exe' -chain -depth 1 "$1")
-=-=-=-=-=-=-=-=-=-=-=-
  ldd (cygwin) COMMAND:
-=-=-=-=-=-=-=-=-=-=-=-
$(ldd "$1")
================================================================================
EOF
}
# other useful tool:
# * PESnoop 2.0 :
#   https://web.archive.org/web/20190425033901/http://www.prestosoft.com/download/plugins/PESnoop.zip
#   * example command:
#     $('/c/Program Files/PESnoop/PESnoop.exe' "$1" //NOLOGO //PE_IT | awk '$0 ~ /Name:/ {print $3}')

# https://stackoverflow.com/a/46020381
export -f multiple_cmd

# if "ldd" hangs, simply "End task" in the task manager (timeout doesn't work!)

# https://stackoverflow.com/a/34236958
# displays the results in the console and overwrites the report file
find . '(' -name "*.exe" -o -name "*.dll" ')' -type f -exec bash -c 'multiple_cmd "$0"' {} \; 2>&1 | tee -a "${report_file}"

# EOF
