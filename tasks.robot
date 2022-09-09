*** Settings ***
Documentation       Install latest Arcdps for Guild Wars 2

Library             OperatingSystem
Library             RPA.HTTP
Library             RPA.FileSystem
Library             RPA.Browser.Selenium
Library             TimeConverter


*** Variables ***
${GW2_FOLDER_PATH}=         C:\\Program Files\\Guild Wars 2
${ARCDPS_WEBSITE_URL}=      https://www.deltaconnected.com/arcdps/x64/
${ARCDPS_DLL}=              d3d11.dll


*** Tasks ***
Install latest Arcdps for Guild Wars 2
    Check Guild Wars 2 folder exists
    Check is Arcdps installed


*** Keywords ***
Check Guild Wars 2 folder exists
    Directory Should Exist    path=${GW2_FOLDER_PATH}

Check is Arcdps installed
    ${file_exists}=    Does File Exist    path=${GW2_FOLDER_PATH}\\${ARCDPS_DLL}
    IF    ${file_exists} is False
        Download and Install latest Arcdps
    ELSE
        Check latest version
    END

Check latest version
    ${local_version}=    Get File Modified Date    path=${GW2_FOLDER_PATH}\\${ARCDPS_DLL}
    ${latest_version}=    Retrieve last modified Date
    IF    ${local_version} < ${latest_version}
        Download and Install latest Arcdps
    END

Download and Install latest Arcdps
    Download    ${ARCDPS_WEBSITE_URL}/${ARCDPS_DLL}
    OperatingSystem.Move File    ${ARCDPS_DLL}    ${GW2_FOLDER_PATH}

Retrieve last modified Date
    Open Headless Chrome Browser    ${ARCDPS_WEBSITE_URL}
    ${table_data}=    Get Table Cell    xpath://table[@id="indexlist"]    3    2
    ${converted_data}=    Datetime To Timestamp    ${table_data}
    RETURN    ${converted_data}
