@ECHO OFF

:: Script Version 1.2MOD
:: Original by ElektroStudios
:: https://github.com/ElektroStudios/Dolphin_Emulator_RVZ_ISO_GameCube_Wii_Conversion_Scripts
::
:: Modified by dazzaXx
:: https://github.com/dazzaXx/RVZ_WBFS_Conv

SET "InputDirectoryPathRVZ=%~dp0RVZ"
SET "OutputDirectoryPathRVZ=%~dp0ISO"
SET "InputDirectoryPathWBFS=%~dp0ISO"
SET "OutputDirectoryPathWBFS=%~dp0WBFS"

ECHO: Script Settings:
ECHO: ----------------
ECHO:
ECHO: - Input Directory Path (RVZ2ISO)...: %InputDirectoryPathRVZ%
ECHO: - Output Directory Path (RVZ2ISO)..: %OutputDirectoryPathRVZ%
ECHO:
ECHO: - Input Directory Path (ISO2WBFS)...: %InputDirectoryPathWBFS%
ECHO: - Output Directory Path (ISO2WBFS)..: %OutputDirectoryPathWBFS%
ECHO+
timeout 5 /nobreak
CLS

MKDIR "%OutputDirectoryPathRVZ%" 1>NUL 2>&1 || (
	IF NOT EXIST "%OutputDirectoryPathRVZ%" (
		ECHO:Error trying to create ISO output directory.
		PAUSE
		EXIt /B 1
	)
)

MKDIR "%OutputDirectoryPathWBFS%" 1>NUL 2>&1 || (
	IF NOT EXIST "%OutputDirectoryPathWBFS%" (
		ECHO:Error trying to create WBFS output directory.
		PAUSE
		EXIt /B 1
	)
)

SET "RVZParam=%%# IN ("%InputDirectoryPathRVZ%\*.rvz")"
SET "ISOParam=%%# IN ("%InputDirectoryPathWBFS%\*.iso")"

	FOR %RVZParam% DO (
		ECHO:Converting "%%~fx#" to ISO...
		".\tools\DolphinTool.exe" convert --format=iso --input="%%~f#" --output="%OutputDirectoryPathRVZ%\%%~n#.iso"
	)

ECHO+
ECHO: All .RVZ files covnverted to .ISO... Converting to .WBFS now...
ECHO+
GOTO :convwbfs

:convwbfs 

	FOR %ISOParam% DO (
		ECHO:Converting "%%~fx#" to WBFS...
		".\tools\WIT\wit.exe" copy --wbfs "%%~f#" "%OutputDirectoryPathWBFS%\%%~n#.wbfs"
	)

cls
ECHO+
ECHO: All .ISO files covnverted to .WBFS, you will find them in the "WBFS" folder, Clearing .ISO files now...
del "%InputDirectoryPathWBFS%\"*.iso""
ECHO+
PAUSE
EXIT /B 0