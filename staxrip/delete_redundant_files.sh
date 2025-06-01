#!/bin/bash

# run script in the staxrip root directory
# removes unnecessary files from 2 lists

#   tested:
# * StaxRip v2.46.5
# * VisualCppRedist_AIO v0.90.0
# * Microsoft Windows [Version 10.0.19045.3803]

# (c) public domain / MIT

################################################################################
#
# how was the "first_list" created?
# 1. install a clean OFFLINE Windows system on a virtual machine, see:
#    https://www.tenforums.com/tutorials/9230-download-windows-10-iso-file.html
# 2. download and extract "VisualCppRedist_AIO_x86_x64.exe" via WinRar, see:
#    https://github.com/abbodi1406/vcredist
# 3. make a list of all *.dll files located in the "VisualCppRedist_AIO_x86_x64" directory,
#    you can use `search_from_file_list.sh` script, (-> "aio_dlls.txt"), see:
#    https://github.com/zablockil/windows_bash/blob/main/search_from_file_list.sh
# 4. show only the names of these files, not duplicated (-> "aio_dlls_ready.txt"):
#    awk -F '/' '{print $NF}' "aio_dlls.txt" | sort | uniq > "aio_dlls_ready.txt"
# 5. INSTALL "VisualCppRedist_AIO_x86_x64.exe" file:
#    VisualCppRedist_AIO_x86_x64.exe /y
# 6. reboot the system
# 7. go to "C:\Windows" directory and search for the names from the file: "aio_dlls_ready.txt"
#    you can use `search_from_file_list.sh` script, (-> "windows_dlls.txt")
# 8. show only the names of these files, not duplicated (-> "windows_dlls_ready.txt"):
#    awk -F '/' '{print $NF}' "windows_dlls.txt" | sort | uniq > "windows_dlls_ready.txt"
# 9. "windows_dlls_ready.txt" ==> $first_list
#
# This list contains .dll files that were actually installed on a clean system
# from the AIO package. In other words: we do not want these files in the distribution,
# because they are already installed on the clean system (from AIO package).
#
read -r -d '' first_list <<'EOF'
ATL80.dll
Microsoft.Office.Tools.Common.Implementation.dll
Microsoft.Office.Tools.Common.dll
Microsoft.Office.Tools.Excel.Implementation.dll
Microsoft.Office.Tools.Excel.dll
Microsoft.Office.Tools.Outlook.Implementation.dll
Microsoft.Office.Tools.Outlook.dll
Microsoft.Office.Tools.Word.Implementation.dll
Microsoft.Office.Tools.Word.dll
Microsoft.Office.Tools.dll
Microsoft.Office.Tools.v4.0.Framework.dll
Microsoft.VisualStudio.Tools.Applications.Hosting.dll
Microsoft.VisualStudio.Tools.Applications.Runtime.dll
Microsoft.VisualStudio.Tools.Applications.ServerDocument.dll
Microsoft.VisualStudio.Tools.Office.ContainerControl.dll
Microsoft.VisualStudio.Tools.Office.Runtime.Internal.dll
Microsoft.VisualStudio.Tools.Office.Runtime.dll
api-ms-win-core-file-l1-2-0.dll
api-ms-win-core-localization-l1-2-0.dll
api-ms-win-core-processthreads-l1-1-1.dll
api-ms-win-core-synch-l1-2-0.dll
api-ms-win-core-timezone-l1-1-0.dll
api-ms-win-crt-conio-l1-1-0.dll
api-ms-win-crt-convert-l1-1-0.dll
api-ms-win-crt-environment-l1-1-0.dll
api-ms-win-crt-filesystem-l1-1-0.dll
api-ms-win-crt-heap-l1-1-0.dll
api-ms-win-crt-locale-l1-1-0.dll
api-ms-win-crt-math-l1-1-0.dll
api-ms-win-crt-multibyte-l1-1-0.dll
api-ms-win-crt-private-l1-1-0.dll
api-ms-win-crt-process-l1-1-0.dll
api-ms-win-crt-runtime-l1-1-0.dll
api-ms-win-crt-stdio-l1-1-0.dll
api-ms-win-crt-string-l1-1-0.dll
api-ms-win-crt-time-l1-1-0.dll
api-ms-win-crt-utility-l1-1-0.dll
atl100.dll
atl110.dll
atl70.dll
atl71.dll
concrt140.dll
dbadapt.dll
mfc100.dll
mfc100chs.dll
mfc100cht.dll
mfc100deu.dll
mfc100enu.dll
mfc100esn.dll
mfc100fra.dll
mfc100ita.dll
mfc100jpn.dll
mfc100kor.dll
mfc100rus.dll
mfc100u.dll
mfc110.dll
mfc110chs.dll
mfc110cht.dll
mfc110deu.dll
mfc110enu.dll
mfc110esn.dll
mfc110fra.dll
mfc110ita.dll
mfc110jpn.dll
mfc110kor.dll
mfc110rus.dll
mfc110u.dll
mfc120.dll
mfc120chs.dll
mfc120cht.dll
mfc120deu.dll
mfc120enu.dll
mfc120esn.dll
mfc120fra.dll
mfc120ita.dll
mfc120jpn.dll
mfc120kor.dll
mfc120rus.dll
mfc120u.dll
mfc140.dll
mfc140chs.dll
mfc140cht.dll
mfc140deu.dll
mfc140enu.dll
mfc140esn.dll
mfc140fra.dll
mfc140ita.dll
mfc140jpn.dll
mfc140kor.dll
mfc140rus.dll
mfc140u.dll
mfc70.dll
mfc70chs.dll
mfc70cht.dll
mfc70deu.dll
mfc70enu.dll
mfc70esp.dll
mfc70fra.dll
mfc70ita.dll
mfc70jpn.dll
mfc70kor.dll
mfc70u.dll
mfc71.dll
mfc71chs.dll
mfc71cht.dll
mfc71deu.dll
mfc71enu.dll
mfc71esp.dll
mfc71fra.dll
mfc71ita.dll
mfc71jpn.dll
mfc71kor.dll
mfc71u.dll
mfc80.dll
mfc80CHS.dll
mfc80CHT.dll
mfc80DEU.dll
mfc80ENU.dll
mfc80ESP.dll
mfc80FRA.dll
mfc80ITA.dll
mfc80JPN.dll
mfc80KOR.dll
mfc80u.dll
mfc90.dll
mfc90u.dll
mfcm100.dll
mfcm100u.dll
mfcm110.dll
mfcm110u.dll
mfcm120.dll
mfcm120u.dll
mfcm140.dll
mfcm140u.dll
mfcm80.dll
mfcm80u.dll
mfcm90.dll
mfcm90u.dll
msbind.dll
msdbrptr.dll
msrdo20.dll
msstdfmt.dll
msstkprp.dll
msvbvm50.dll
msvci70.dll
msvcm80.dll
msvcm90.dll
msvcp100.dll
msvcp110.dll
msvcp120.dll
msvcp140.dll
msvcp140_1.dll
msvcp140_2.dll
msvcp140_atomic_wait.dll
msvcp140_codecvt_ids.dll
msvcp70.dll
msvcp71.dll
msvcp80.dll
msvcp90.dll
msvcr100.dll
msvcr110.dll
msvcr120.dll
msvcr70.dll
msvcr71.dll
msvcr80.dll
msvcr90.dll
msvcrt10.dll
ucrtbase.dll
vb40032.dll
vcamp110.dll
vcamp120.dll
vcamp140.dll
vccorlib110.dll
vccorlib120.dll
vccorlib140.dll
vcomp.dll
vcomp100.dll
vcomp110.dll
vcomp120.dll
vcomp140.dll
vcomp90.dll
vcruntime140.dll
vcruntime140_1.dll
vcruntime140_threads.dll
EOF

echo ""
echo "The following files have been deleted (pass no1):"
echo "-------------------------------------------------"
echo "${first_list}" | while read -r line; do
  find . -name "${line}" -type f -delete -print
done
# here you can find the report from the above list
# (files that are installed in the "C:\Windows" directory) :
# https://github.com/zablockil/windows_bash/blob/main/staxrip/pass1_c_windows.txt

################################################################################
#
# how was the "second_list" created?
# 1. remove files from the distribution from the $first_list
# 2. generate dll dependency report (distribution files) from "check_dll_dependency.sh" script, see:
#    https://github.com/zablockil/windows_bash/blob/main/check_dll_dependency.sh
# 3. search the report for the following keywords:
#    grep -C4 "Company:        Microsoft" "report.txt" > "keywords.txt"
# 4. now you need to manually create a list of .dll file names that you suspect
#    that may be in the "C:\Windows" directory (keywords.txt). My types are as follows (40):
# Microsoft.Win32.Registry.dll
# System.Net.Http.Extensions.dll
# System.Net.Http.Primitives.dll
# api-ms-win-core-console-l1-1-0.dll
# api-ms-win-core-console-l1-2-0.dll
# api-ms-win-core-datetime-l1-1-0.dll
# api-ms-win-core-debug-l1-1-0.dll
# api-ms-win-core-errorhandling-l1-1-0.dll
# api-ms-win-core-fibers-l1-1-0.dll
# api-ms-win-core-file-l1-1-0.dll
# api-ms-win-core-file-l2-1-0.dll
# api-ms-win-core-handle-l1-1-0.dll
# api-ms-win-core-heap-l1-1-0.dll
# api-ms-win-core-interlocked-l1-1-0.dll
# api-ms-win-core-libraryloader-l1-1-0.dll
# api-ms-win-core-memory-l1-1-0.dll
# api-ms-win-core-namedpipe-l1-1-0.dll
# api-ms-win-core-processenvironment-l1-1-0.dll
# api-ms-win-core-processthreads-l1-1-0.dll
# api-ms-win-core-profile-l1-1-0.dll
# api-ms-win-core-rtlsupport-l1-1-0.dll
# api-ms-win-core-string-l1-1-0.dll
# api-ms-win-core-synch-l1-1-0.dll
# api-ms-win-core-sysinfo-l1-1-0.dll
# api-ms-win-core-util-l1-1-0.dll
# msvcdis140.dll
# msvcp140_1d.dll
# msvcp140_2d.dll
# msvcp140_clr0400.dll
# msvcp140d.dll
# msvcp140d_atomic_wait.dll
# msvcp140d_codecvt_ids.dll
# ucrtbased.dll
# vcamp140d.dll
# vccorlib140d.dll
# vcomp140d.dll
# vcruntime140_1d.dll
# vcruntime140_clr0400.dll
# vcruntime140_threadsd.dll
# vcruntime140d.dll
#
# 5. go to "C:\Windows" directory and search for the names from above list
#    you can use `search_from_file_list.sh` script
# 6. show only the names of these files, not duplicated (-> "pass2_ready.txt"):
#    awk -F '/' '{print $NF}' "my_list.txt" | sort | uniq > "pass2_ready.txt"
# 7. "pass2_ready.txt" ==> $second_list
#
# This list contains .dll files that were actually installed on a clean system.
# In other words: we do not want these files in the distribution, because
# they are already installed on the clean Windows 10 system.
#
read -r -d '' second_list <<'EOF'
api-ms-win-core-console-l1-1-0.dll
api-ms-win-core-datetime-l1-1-0.dll
api-ms-win-core-debug-l1-1-0.dll
api-ms-win-core-errorhandling-l1-1-0.dll
api-ms-win-core-fibers-l1-1-0.dll
api-ms-win-core-file-l1-1-0.dll
api-ms-win-core-handle-l1-1-0.dll
api-ms-win-core-heap-l1-1-0.dll
api-ms-win-core-interlocked-l1-1-0.dll
api-ms-win-core-libraryloader-l1-1-0.dll
api-ms-win-core-memory-l1-1-0.dll
api-ms-win-core-namedpipe-l1-1-0.dll
api-ms-win-core-processenvironment-l1-1-0.dll
api-ms-win-core-processthreads-l1-1-0.dll
api-ms-win-core-profile-l1-1-0.dll
api-ms-win-core-rtlsupport-l1-1-0.dll
api-ms-win-core-string-l1-1-0.dll
api-ms-win-core-synch-l1-1-0.dll
api-ms-win-core-sysinfo-l1-1-0.dll
api-ms-win-core-util-l1-1-0.dll
msvcp140_clr0400.dll
vcruntime140_clr0400.dll
EOF

echo ""
echo "The following files have been deleted (pass no2):"
echo "-------------------------------------------------"
echo "${second_list}" | while read -r line; do
  find . -name "${line}" -type f -delete -print
done
# here you can find the report from the above list
# (files that are installed in the "C:\Windows" directory) :
# https://github.com/zablockil/windows_bash/blob/main/staxrip/pass2_c_windows.txt

# EOF
