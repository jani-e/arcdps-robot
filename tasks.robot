*** Settings ***
Documentation       Install latest Arcdps for Guild Wars 2

Library             OperatingSystem
Library             RPA.HTTP
Library             RPA.FileSystem
Library             RPA.Browser.Selenium

*** Variables ***
${GW2_FOLDER_PATH}=    C:\\Program Files\\Guild Wars 2
${ARCDPS_WEBSITE_URL}=    https://www.deltaconnected.com/arcdps/x64/
${ARCDPS_DLL}=    d3d11.dll

*** Tasks ***
Install latest Arcdps for Guild Wars 2
    Check Guild Wars 2 folder exists
    Check if Arcdps installed
    Check latest version is installed
    Download and Install latest Arcdps


*** Keywords ***

Check Guild Wars 2 folder exists
    Directory Should Exist    path=${GW2_FOLDER_PATH}

Check if Arcdps installed
    ${file_exists}=    Does File Exist    path=${GW2_FOLDER_PATH}\\${ARCDPS_DLL}
    IF    ${file_exists} is False    Download and Install latest Arcdps

Check latest version is installed
    ${local_version}=    Get File Modified Date    path=${GW2_FOLDER_PATH}\\${ARCDPS_DLL}
    ${latest_version}=    Retrieve last modified Date

Download and Install latest Arcdps
    Download    ${ARCDPS_WEBSITE_URL}/${ARCDPS_DLL}
    OperatingSystem.Move File    ${ARCDPS_DLL}    ${GW2_FOLDER_PATH}

Retrieve last modified Date
    Open Headless Chrome Browser    ${ARCDPS_WEBSITE_URL}
    Get Table Cell    xpath://table[@id="indexlist"]    2    2
