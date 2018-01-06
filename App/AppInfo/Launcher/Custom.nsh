!define REG1 "HKEY_CURRENT_USER\Software"
!define REG2 "HKEY_CURRENT_USER\Software\Classes"

${SegmentFile}

;; Set Cache folder
!include "${PACKAGE}\Other\Source\ReadINIStrWithDefault.nsh"

${SegmentPreExec}

${ReadINIStrWithDefault} "$0" "$EXEDIR\GoogleEarthProPortable.ini" "GoogleEarthProPortable" "EnableCache" "false"

${If} $0 == false
		${registry::Write} "${REG1}\Google\Google Earth Pro" "CachePath" "$TEMP\GoogleEarthProPortableTemp" "REG_SZ" $0
	${Else}
		CreateDirectory $EXEDIR\Data\Cache
		${registry::Write} "${REG1}\Google\Google Earth Pro" "CachePath" "$EXEDIR\Data\Cache" "REG_SZ" $0
${EndIf}

;; Set KML folder
	CreateDirectory $EXEDIR\Data\KML
	${registry::Write} "${REG1}\Google\Google Earth Pro" "KMLPath" "$EXEDIR\Data\KML" "REG_SZ" $0

;; Write reg keys on launch
	;; associate kml files
	${registry::Write} "${REG2}\.kml" "" "GoogleEarth.kml" "REG_SZ" $0
	${registry::Write} "${REG2}\GoogleEarth.kml\DefaultIcon" "" "$EXEDIR\App\Google Earth Pro\kml_file.ico" "REG_SZ" $0
	${registry::Write} "${REG2}\GoogleEarth.kml\shell\open\command" "" '$EXEDIR\GoogleEarthProPortable.exe "%1"' "REG_SZ" $0
	;; associate kmz files
	${registry::Write} "${REG2}\.kmz" "" "GoogleEarth.kmz" "REG_SZ" $0
	${registry::Write} "${REG2}\GoogleEarth.kmz\DefaultIcon" "" "$EXEDIR\App\Google Earth Pro\kmz_file.ico" "REG_SZ" $0
	${registry::Write} "${REG2}\GoogleEarth.kmz\shell\open\command" "" '$EXEDIR\GoogleEarthProPortable.exe "%1"' "REG_SZ" $0
!macroend

;; CleanUp reg keys on exit
${SegmentPost}
	${registry::DeleteKey} "${REG2}\.kml" $0
	${registry::DeleteKey} "${REG2}\GoogleEarth.kml" $0
	${registry::DeleteKey} "${REG2}\.kmz" $0
	${registry::DeleteKey} "${REG2}\GoogleEarth.kmz" $0
!macroend