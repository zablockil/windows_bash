## `check_dll_dependency.sh`

script searches current working directory (and subdirectories) for \*.exe and \*.dll files and creates a DLL dependency report

apps needed:

* [msys2](https://www.msys2.org/)
* [Sigcheck](https://learn.microsoft.com/en-us/sysinternals/downloads/sigcheck)
* [dumpbin.exe](https://github.com/Delphier/dumpbin/releases)
* [Dependencies](https://github.com/lucasg/Dependencies/releases)

<img src="img/check_dll_dependency.png?raw=true" alt="dll" width="400" height="300"/>

more info:

* [How to check for DLL dependency?](https://stackoverflow.com/a/7378991)
* [Dynamic-link library search order](https://learn.microsoft.com/en-gb/windows/win32/dlls/dynamic-link-library-search-order)

## `Open_ucrt64_Bash_here.reg`

adds MSYS2 "Open Here" registry settings

```
REG IMPORT Open_ucrt64_Bash_here.reg
```

<img src="img/ucrt64.png?raw=true" alt="ucrt64" width="400" height="250"/>

## `sha256_hash_files.sh`

creates sha256 hashes for all files in the current working directory (and subdirectories), sorts files alphabetically

<img src="img/sha256_hash_files.png?raw=true" alt="sha256" width="400" height="300"/>

## `search_from_file_list.sh`

searches for files by name from a list in the current working directory (and subdirectories)

<img src="img/search_from_file_list.png?raw=true" alt="sha256" width="400" height="300"/>

# (c) public domain / MIT
