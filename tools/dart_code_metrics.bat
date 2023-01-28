@echo off
call :Run_Metrics metrics_app "METRICS_APP"
call :Run_Metrics metrics_data "METRICS_DATA"
call :Run_Metrics metrics_domain "METRICS_DOMAIN"
call :Run_Metrics metrics_shared "METRICS_SHARED"
exit /b

:Run_Metrics
echo %~1 running...
set run_cmd= make %~1
set metrics_log_file= %~1_metrics.log

echo %run_cmd% > %metrics_log_file%
%run_cmd%  > %metrics_log_file%

> nul find /i "Warning" %metrics_log_file% && (
    echo *** %~2_ERROR contain Warning***: check file %metrics_log_file%
    exit 1
)

> nul find /i "Alarm" %metrics_log_file% && (
    echo *** %~2_ERROR contain Alarm***: check file %metrics_log_file%
    exit 1
)

del %metrics_log_file%

echo *** %~2_SUCCESS ***
exit /b 0
