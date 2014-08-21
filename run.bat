@echo OFF


:: change these variables to fit your system

:: path to dp2 command line interface
SET DP2=C:\Program\daisy-pipeline\cli\dp2
:: use this directory to store results
SET TARGET=C:\MY_DATA\EPUB\migrator-batch-convert
 :: read *.xml files in this directory and its subdirectories
SET SOURCE=C:\MY_DATA\Arkiv\arkiv-test
 :: I added this line for retrieving css content in the html report /TJ
SET BATCH_HOME=C:\MY_LOCAL_SCRIPTS\nordic-epub3-dtbook-migrator-batch

mkdir "%TARGET%\zip"
mkdir "%TARGET%\log"
mkdir "%TARGET%\epub"

SET current_date=%date%
SET startTime=%time%

SET /a sth=%startTime:~0,2%
SET /a stm=1%startTime:~3,2% - 100
SET /a sts=1%startTime:~6,2% - 100

SET SCRIPT_1=nordic-dtbook-validate
SET SCRIPT_2=nordic-dtbook-to-epub3
SET SCRIPT_3=nordic-epub3-validate
SET SCRIPT_4=nordic-epub3-to-dtbook
SET LOGFILE=%TARGET%\report-%current_date%-%sth%-%stm%-%sts%.html

SET /a SOURCE_DTBOOK_COUNT=0


DEL "%LOGFILE%"
echo "Writing output to LOGFILE"

PUSHD %SOURCE%
FOR /R %%A IN (*.xml) DO SET /a SOURCE_DTBOOK_COUNT+=1
SET /A PROGRESSBAR_INCREMENTS=100/(%SOURCE_DTBOOK_COUNT%*4)



CALL :log "<!DOCTYPE html>"
CALL :log "<html lang="en">"
CALL :log "<head>"
CALL :log "    <meta encoding="utf-8"/>"
CALL :log "    <title>Nordic EPUB3/DTBook batch conversion</title>"
CALL :log "    <meta name=""viewport"" content=""width=device-width, initial-scale=1.0"" />"
CALL :log "    <style type="text/css">"
TYPE %BATCH_HOME%\bootstrap.min.css >> %LOGFILE%
CALL :log "    </style>"
CALL :log "    <style>.nobr { white-space:nowrap; }</style>"
CALL :log "</head>"
CALL :log "<body class="content">"
CALL :log "    <div class="container">"
CALL :log "        <h1>Nordic EPUB3/DTBook batch conversion</h1>"
CALL :log "        <p>Start time: %current_date%-%sth%-%stm%-%sts%</p>"
CALL :log "        <p>DTBook files: %SOURCE_DTBOOK_COUNT%</p>"
CALL :log "<div class=""progress progress-striped active"">"
CALL :log "  <div id=""progress-done"" class=""progress-bar progress-bar-success"" role=""progressbar"" aria-valuenow=""0"" aria-valuemin=""0"" aria-valuemax=""100"" style=""width: 0%;"">"
CALL :log "    <span><span id="progress-done-count">0</span>__DONE</span>"
CALL :log "  </div>"
CALL :log "</div>"
CALL :log "<div class=""progress progress-striped active"">"
CALL :log "  <div id=""progress-failed"" class=""progress-bar progress-bar-danger"" role=""progressbar"" aria-valuenow=""0"" aria-valuemin=""0"" aria-valuemax=""100"" style=""width: 0%;"">"
CALL :log "    <span><span id="progress-failed-count">0</span>__FAILED</span>"
CALL :log "  </div>"
CALL :log "</div>"
CALL :log "<div class=""progress progress-striped active"">"
CALL :log "  <div id=""progress-skipped"" class=""progress-bar progress-bar-warning"" role=""progressbar"" aria-valuenow=""0"" aria-valuemin=""0"" aria-valuemax=""100"" style=""width: 0%;"">"
CALL :log "    <span><span id="progress-skipped-count">0</span>__SKIPPED</span>"
CALL :log "  </div>"
CALL :log "</div>"
CALL :log "        <table width=""100%"" class=""table table-bordered table-hover table-condensed"">"
CALL :log "<thead><tr>"
CALL :log "<th class="nobr">Book ID</th>"
CALL :log "<th class="nobr">%SCRIPT_1%</th>"
CALL :log "<th class="nobr">%SCRIPT_2%</th>"
CALL :log "<th class="nobr">%SCRIPT_3%</th>"
CALL :log "<th class="nobr">%SCRIPT_4%</th>"
CALL :log "</tr></thead><tbody>"


SET /a PROGRESS_DONE_COUNT=0
SET /a PROGRESS_SKIPPED_COUNT=0
SET /a PROGRESS_FAILED_COUNT=0

FOR /R %%I IN (*.xml) DO CALL :nordic_test %%~nI %%~dpI
POPD


:: finishing the log file
CALL :log "</tbody></table>"
CALL :log "<p>Finish time: %current_date%-%sth%-%stm%-%sts%</p>"
CALL :log "</div>"
CALL :log "</body></html>"


echo "Report file: %LOGFILE%"

:: ------------------------------------------------------------------------------------------
:: FUNCTION SECTION
:: ------------------------------------------------------------------------------------------

:log 

SET var=%1
SET var=%var:>=^>%
SET var=%var:<=^<%
SET var=%var:""="%
echo %var:~1,-1% >> "%LOGFILE%"
goto :eof


:html_h1 
    CALL :log "<h1>%1</h1>"
goto :eof


:html_h2 
    CALL :log "<h2>%1</h2>"
goto :eof


:html_h3 
    CALL :log "<h3>%1</h3>"
goto :eof


:html_tr 
    CALL :log "<tr>"
goto :eof


:html_tr_end 
    CALL :log "</tr>"
goto :eof


:html_td 
    if "%1" == "DONE" (
        CALL :log "<td class=""success""><ul>"
    ) else (
        if "%1" == "VALIDATION_FAIL" (
        CALL :log "<td class=""danger""><ul>"
        ) else (
        CALL :log "<td class=""%1""><ul>"
		)
	)
 goto :eof



:html_td_end 
    CALL :log "</ul></td>"
goto :eof


:html_li 
    if "%2" == "" (
        CALL :log "<li>%~1</li>"
    ) else (
        CALL :log "<li><a href=""%2"">%~1</a></li>"
    )
goto :eof




:update_progress 
    SET STATUS=%1
    SET /a COUNT=0
    if %STATUS% == DONE (
        SET STATUS=done
        SET /a PROGRESS_DONE_COUNT=%PROGRESS_DONE_COUNT% + 1
        SET /a COUNT=%PROGRESS_DONE_COUNT%
	) else (
        if %STATUS% == SKIPPED (
            SET STATUS=skipped
            SET /a PROGRESS_SKIPPED_COUNT=%PROGRESS_SKIPPED_COUNT% + 1
            SET /a COUNT=%PROGRESS_SKIPPED_COUNT%
    ) else (
            SET STATUS=failed
            SET /a PROGRESS_FAILED_COUNT=%PROGRESS_FAILED_COUNT% + 1
            SET /a COUNT=%PROGRESS_FAILED_COUNT%
        )
	)
    SET /A PROGRESS=%PROGRESSBAR_INCREMENTS% * %COUNT%
	
    CALL :log "<script type="text/javascript">"
    CALL :log "document.getElementById('progress-%STATUS%').setAttribute('aria-valuenow','%PROGRESS%');"
    CALL :log "document.getElementById('progress-%STATUS%').setAttribute('style','width: %PROGRESS%;');</script>"
    CALL :log "<script type="text/javascript">document.getElementById('progress-%STATUS%-count').innerHTML = '%COUNT%';"
    CALL :log "</script>"
goto :eof


:nordic_test 
    :: takes two parameters; first the id, then the full file path
    CALL :html_tr
    CALL :log "<td><strong>%1</strong></td>"
    
    SET STATUS_1=""
    SET STATUS_2=""
    SET STATUS_3=""
    SET STATUS_4=""
	
	SET CURRENT_FILE=%1
	SET CURRENT_PATH=%2

    
	IF EXIST "%CURRENT_PATH%%CURRENT_FILE%.xml" (
	CALL :runNordicDtbVal %%CURRENT_FILE%% %%CURRENT_PATH%%
        ) else (
        CALL :html_td "danger"
        CALL :html_li "Status: SKIPPED"
        CALL :html_li "DTBook not found: %%2"
        CALL :update_progress SKIPPED
        CALL :html_td_end
		
		    CALL :html_td
            CALL :html_li "Status: SKIPPED"
            CALL :update_progress SKIPPED
            CALL :html_td_end
			
			CALL :html_td
            CALL :html_li "Status: SKIPPED"
            CALL :update_progress SKIPPED
            CALL :html_td_end
			
			CALL :html_td
            CALL :html_li "Status: SKIPPED"
            CALL :update_progress SKIPPED
            CALL :html_td_end
		
    CALL :html_tr_end
	)
	goto :eof

:runNordicDtbVal

	START /WAIT %DP2% %SCRIPT_1% --x-no-legacy="true" --x-dtbook="%2%1.xml" --output="%TARGET%\zip\%1.%SCRIPT_1%.zip" -p
    START /B /W %DP2% log --lastid --file="%TARGET%\log\%1.%SCRIPT_1%.log"
        MKDIR "%TARGET%\zip\%1.%SCRIPT_1%"
        7z x %TARGET%\zip\%1.%SCRIPT_1%.zip -o%TARGET%\zip\%1.%SCRIPT_1%

		START /B /W %DP2% status -l>>"%TARGET%\zip\%1.%SCRIPT_1%\status.txt"
		FINDSTR "Status" "%TARGET%\zip\%1.%SCRIPT_1%\status.txt">>"%TARGET%\zip\%1.%SCRIPT_1%\validation-status.txt"
		        
		FOR /F "tokens=1,2,3 delims=: " %%M IN ('FINDSTR "Status" "%TARGET%\zip\%1.%SCRIPT_1%\validation-status.txt"') DO SET STATUS_1=%%O
        CALL :update_progress %%STATUS_1%%
        SET HTML_1=%TARGET%\zip\%1.%SCRIPT_1%\html-report\html-report.xml
        SET LOG_1=%TARGET%\log\%1.%SCRIPT_1%.log
		CALL :html_td %%STATUS_1%%
        CALL :html_li "Status: %%STATUS_1%%"
        CALL :html_li "HTML report" %%HTML_1%%
        CALL :html_li "detailed log" %%LOG_1%%
        CALL :html_li "basename %2" %2
        CALL :html_td_end
		START /B /W %DP2% delete --lastid
		
		
		CALL :runDtbToEpub %CURRENT_FILE% %CURRENT_PATH%

	goto :eof
	
:runDtbToEpub
IF "%STATUS_1%" == "DONE" (
START /WAIT %DP2% %SCRIPT_2% --x-no-legacy="false" --x-strict="false" --x-dtbook="%2%1.xml" --output="%TARGET%\zip\%1.%SCRIPT_2%.zip" -p
            START /B /W %DP2% log --lastid --file="%TARGET%\log\%1.%SCRIPT_2%.log"

            MKDIR "%TARGET%\zip\%1.%SCRIPT_2%"
            7z x %TARGET%\zip\%1.%SCRIPT_2%.zip -o%TARGET%\zip\%1.%SCRIPT_2%
			START /B /W %DP2% status -l>>"%TARGET%\zip\%1.%SCRIPT_2%\status.txt"
            FINDSTR "Status" "%TARGET%\zip\%1.%SCRIPT_2%\status.txt">>"%TARGET%\zip\%1.%SCRIPT_2%\validation-status.txt"
				
			FOR /F "tokens=1,2,3 delims=: " %%M IN ('FINDSTR "Status" "%TARGET%\zip\%1.%SCRIPT_2%\validation-status.txt"') DO SET STATUS_2=%%O
            CALL :update_progress %%STATUS_2%%
            SET LOG_2=%TARGET%\log\%1.%SCRIPT_2%.log
            SET HTML_2=%TARGET%\zip\%1.%SCRIPT_2%\html-report\html-report.xml
			CALL :html_td %%STATUS_2%%
			CALL :html_li "Status: %%STATUS_2%%"
			CALL :html_li "HTML report" %%HTML_2%%
			CALL :html_li "detailed log" %%LOG_2%%
			CALL :html_li "basename %%2" %%2
			CALL :html_td_end
			START /W %DP2% delete --lastid
			
			SET EPUB=%TARGET%\zip\%1.%SCRIPT_2%\output-dir\%1.epub
			SET EPUB_PTH=%TARGET%\zip\%1.%SCRIPT_2%\output-dir\
	        
			CALL :runNordicEpubVal %CURRENT_FILE%
			) else (
            CALL :html_td
            CALL :html_li "Status: SKIPPED"
            CALL :update_progress SKIPPED
            CALL :html_td_end
			
			CALL :html_td
            CALL :html_li "Status: SKIPPED"
            CALL :update_progress SKIPPED
            CALL :html_td_end
			
			CALL :html_td
            CALL :html_li "Status: SKIPPED"
            CALL :update_progress SKIPPED
            CALL :html_td_end
			
			CALL :html_tr_end
        )
	goto :eof
	
:runNordicEpubVal
IF "%STATUS_2%" == "DONE" (
            START /W %DP2% %SCRIPT_3% --x-strict="false" --x-epub="%EPUB%" --output="%TARGET%\zip\%1.%SCRIPT_3%.zip" -p
            START /B /W %DP2% log --lastid --file="%TARGET%\log\%1.%SCRIPT_3%.log"
            MKDIR "%TARGET%\zip\%1.%SCRIPT_3%"
            7z x %TARGET%\zip\%1.%SCRIPT_3%.zip -o%TARGET%\zip\%1.%SCRIPT_3%
            START /B /W %DP2% status -l>>"%TARGET%\zip\%1.%SCRIPT_3%\status.txt"
            FINDSTR "Status" "%TARGET%\zip\%1.%SCRIPT_3%\status.txt">>"%TARGET%\zip\%1.%SCRIPT_3%\validation-status.txt"
			FOR /F "tokens=1,2,3 delims=: " %%M IN ('FINDSTR "Status" "%TARGET%\zip\%1.%SCRIPT_3%\validation-status.txt"') DO SET STATUS_3=%%O
            CALL :update_progress %%STATUS_3%%
			SET LOG_3=%TARGET%\log\%1.%SCRIPT_3%.log
            SET HTML_3=%TARGET%\zip\%1.%SCRIPT_3%\html-report\html-report.xml
			CALL :html_td %%STATUS_3%%
			CALL :html_li "Status: %%STATUS_3%%"
			CALL :html_li "HTML report" %%HTML_3%%
			CALL :html_li "detailed log" %%LOG_3%%
            CALL :html_li "basename %%EPUB%%" %%EPUB_PTH%%
            CALL :html_td_end
            START /W %DP2% delete --lastid
			
			
	   CALL :runNordicEpubToDtb %CURRENT_FILE%
			) else (
            CALL :html_td
            CALL :html_li "Status: SKIPPED"
            CALL :update_progress SKIPPED
            CALL :html_td_end
			
			CALL :html_td
            CALL :html_li "Status: SKIPPED"
            CALL :update_progress SKIPPED
            CALL :html_td_end
			
			CALL :html_tr_end
			)
	goto :eof
	
:runNordicEpubToDtb
IF "%STATUS_3%" == "DONE" (
            START /W %DP2% %SCRIPT_4% --x-strict="false" --x-epub="%EPUB%" --output="%TARGET%\zip\%1.%SCRIPT_4%.zip" -p
            START /B /W %DP2% log --lastid --file="%TARGET%\log\%1.%SCRIPT_4%.log"
            MKDIR "%TARGET%\zip\%1.%SCRIPT_4%"
            7z x %TARGET%\zip\%1.%SCRIPT_4%.zip -o%TARGET%\zip\%1.%SCRIPT_4%
            START /B /W %DP2% status -l>>"%TARGET%\zip\%1.%SCRIPT_4%\status.txt"
            FINDSTR "Status" "%TARGET%\zip\%1.%SCRIPT_4%\status.txt">>"%TARGET%\zip\%1.%SCRIPT_4%\validation-status.txt"
			FOR /F "tokens=1,2,3 delims=: " %%M IN ('FINDSTR "Status" "%TARGET%\zip\%1.%SCRIPT_4%\validation-status.txt"') DO SET STATUS_4=%%O
            CALL :update_progress %%STATUS_4%%
			SET LOG_4=%TARGET%\log\%1.%SCRIPT_4%.log
            SET HTML_4=%TARGET%\zip\%1.%SCRIPT_4%\html-report\html-report.xml
			CALL :html_td %%STATUS_4%%
			CALL :html_li "Status: %%STATUS_4%%"
			CALL :html_li "HTML report" %%HTML_4%%
			CALL :html_li "detailed log" %%LOG_4%%
            CALL :html_li "basename %%EPUB%%" %%EPUB_PTH%%
            CALL :html_td_end
			CALL :html_tr_end
            START /W %DP2% delete --lastid
			
						) else (
            CALL :html_td
            CALL :html_li "Status: SKIPPED"
            CALL :update_progress SKIPPED
            CALL :html_td_end
			CALL :html_tr_end
			)
	goto :eof
