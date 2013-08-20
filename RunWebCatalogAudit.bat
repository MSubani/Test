@echo off
REM Type in the command using the following Syntax
REM WebCatalogReports [Requests|Dashboards] [BackupName]
REM Example: WebCatalogReports Requests "Backup on Sunday 23rd 2010"



set /P BackupName=Enter the Name of Backup: 

Call wca-init.cmd

set /P AnalysisCol="Do you want to Backup Analysis Columns as well [Yes/No]:"

IF "%AnalysisCol%" == "No" GOTO AnalysisColNo

%ORACLE_HOME%\bin\sqlplus %WCA_SCHEMA%/%WCA_SCHEMA_PWD%@%TNSCONNECTSTRING% @%EXPORT_PATH%\sql\InsertBackup.txt "%BackupName%" "%WEBCATALOG_PATH%"

Call WebCatalogReports Analysis "%BackupName%"

	set /p type="Press Enter after the file Analysis.txt has been created in EXPORT_PATH\output director.....

	Call wca-init.cmd

	%ORACLE_HOME%\bin\sqlldr %WCA_SCHEMA%/%WCA_SCHEMA_PWD%@%TNSCONNECTSTRING% parfile=%EXPORT_PATH%\parameter\parAnalysisFile.txt

	%ORACLE_HOME%\bin\sqlplus %WCA_SCHEMA%/%WCA_SCHEMA_PWD%@%TNSCONNECTSTRING% @%EXPORT_PATH%\sql\InsertAnalysis.txt "%BackupName%"

	Ren %EXPORT_PATH%\output\Analysis.txt Analysis_%BackupName%.txt
	
	GOTO Dashboards
	
:AnalysisColNo

%ORACLE_HOME%\bin\sqlplus %WCA_SCHEMA%/%WCA_SCHEMA_PWD%@%TNSCONNECTSTRING% @%EXPORT_PATH%\sql\InsertBackup.txt "%BackupName%" "%WEBCATALOG_PATH%"

Call WebCatalogReports AnalysisColNo "%BackupName%"

	set /p type="Press Enter after the file AnalysisColNo.txt has been created in EXPORT_PATH\output director.....

	Call wca-init.cmd

	%ORACLE_HOME%\bin\sqlldr %WCA_SCHEMA%/%WCA_SCHEMA_PWD%@%TNSCONNECTSTRING% parfile=%EXPORT_PATH%\parameter\parAnalysisColNoFile.txt

	%ORACLE_HOME%\bin\sqlplus %WCA_SCHEMA%/%WCA_SCHEMA_PWD%@%TNSCONNECTSTRING% @%EXPORT_PATH%\sql\InsertAnalysisColNo.txt "%BackupName%"

	Ren %EXPORT_PATH%\output\AnalysisColNo.txt AnalysisColNo_%BackupName%.txt

:Dashboards

Call WebCatalogReports Dashboards "%BackupName%"

	set /p type="Press Enter after the file Dashboard.txt has been created in EXPORT_PATH\output director....."

	Call wca-init.cmd

	%ORACLE_HOME%\bin\sqlldr %WCA_SCHEMA%/%WCA_SCHEMA_PWD%@%TNSCONNECTSTRING% parfile=%EXPORT_PATH%\parameter\parDashboardsFile.txt

	%ORACLE_HOME%\bin\sqlplus %WCA_SCHEMA%/%WCA_SCHEMA_PWD%@%TNSCONNECTSTRING% @%EXPORT_PATH%\sql\InsertDashboards.txt "%BackupName%"

	Ren %EXPORT_PATH%\output\Dashboard.txt Dashboard_%BackupName%.txt

Call WebCatalogReports DashboardPrompts "%BackupName%"

	set /p type="Press Enter after the file DashboardPrompts.txt has been created in EXPORT_PATH\output director....."

	Call wca-init.cmd

	%ORACLE_HOME%\bin\sqlldr %WCA_SCHEMA%/%WCA_SCHEMA_PWD%@%TNSCONNECTSTRING% parfile=%EXPORT_PATH%\parameter\parDashboardPromptsFile.txt

	%ORACLE_HOME%\bin\sqlplus %WCA_SCHEMA%/%WCA_SCHEMA_PWD%@%TNSCONNECTSTRING% @%EXPORT_PATH%\sql\InsertDashboardPrompts.txt "%BackupName%"

	Ren %EXPORT_PATH%\output\DashboardPrompts.txt DashboardPrompts_%BackupName%.txt

Call WebCatalogReports Filters "%BackupName%"

	set /p type="Press Enter after the file Filters.txt has been created in EXPORT_PATH\output director....."

	Call wca-init.cmd

	%ORACLE_HOME%\bin\sqlldr %WCA_SCHEMA%/%WCA_SCHEMA_PWD%@%TNSCONNECTSTRING% parfile=%EXPORT_PATH%\parameter\parFiltersFile.txt

	%ORACLE_HOME%\bin\sqlplus %WCA_SCHEMA%/%WCA_SCHEMA_PWD%@%TNSCONNECTSTRING% @%EXPORT_PATH%\sql\InsertFilters.txt "%BackupName%"

	Ren %EXPORT_PATH%\output\Filters.txt Filters_%BackupName%.txt
