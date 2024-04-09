REM
REM This script automates the building and testing of top-level flows.
REM
REM Copyright (c) 2024 Open Technologies for Integration
REM Licensed under the MIT license (see LICENSE for details)
REM 

REM Create the work directory
rmdir /q /s %TEMP%\ace-non-application-flows-work-dir
call mqsicreateworkdir %TEMP%\ace-non-application-flows-work-dir

REM Build flows
mqsicreatebar -data . -b %TEMP%\non-application-flows.bar -cleanBuild -p TopLevelFlows Subflows -o TopLevelFlows/TestFlow.msgflow  -l SubflowStaticLib
mqsibar -c -w %TEMP%\ace-non-application-flows-work-dir -a %TEMP%\non-application-flows.bar

REM Build tests - ibmint new for v12
ibmint deploy --input-path . --output-work-directory %TEMP%\ace-non-application-flows-work-dir --project TopLevelFlows_Test

REM Run the server to run the tests
REM Note these tests require a default application name that must match the one used in the test code
IntegrationServer -w %TEMP%\ace-non-application-flows-work-dir --default-application-name DefaultApplication --start-msgflows false --no-nodejs --admin-rest-api -1 --test-project TopLevelFlows_Test
