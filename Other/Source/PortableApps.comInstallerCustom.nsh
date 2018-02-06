!include "GoogleEarthPro_x32.nsh"
!include "GoogleEarthPro_x64.nsh"

!macro CustomCodePostInstall

	!insertmacro "GoogleEarthPro_x32"
	!insertmacro "GoogleEarthPro_x64"

!macroend
