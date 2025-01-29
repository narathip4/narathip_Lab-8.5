*** Settings ***
Documentation     A resource file with reusable keywords and variables.
...
...               The system specific keywords created here form our own
...               domain specific language. They utilize keywords provided
...               by the imported SeleniumLibrary.
Library           SeleniumLibrary

*** Variables ***
${SERVER}           localhost:7272
${BROWSER}          custom_chrome
${DELAY}            0
${VALID USER}       demo
${VALID PASSWORD}   mode
${LOGIN URL}        http://${SERVER}/
${WELCOME URL}      http://${SERVER}/welcome.html
${ERROR URL}        http://${SERVER}/error.html
${CHROME PATH}          ${EXECDIR}${/}testing${/}ChromeForTesting${/}ChromeForTesting${/}chrome.exe
${CHROMEDRIVER PATH}    ${EXECDIR}${/}testing${/}ChromeForTesting${/}ChromeForTesting${/}chromedriver.exe



*** Keywords ***
Open Browser To Login Page
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Set Variable    ${options.binary_location}    ${CHROME PATH}
    Call Method    ${options}    add_argument    --no-sandbox
    Call Method    ${options}    add_argument    --disable-dev-shm-usage
    Call Method    ${options}    add_argument    --disable-gpu
    ${service}=    Evaluate    sys.modules['selenium.webdriver.chrome.service'].Service(r"${CHROMEDRIVER PATH}")    sys
    Create WebDriver    Chrome    service=${service}    options=${options}
    Go To    ${LOGIN URL}
    Maximize Browser Window     
    Set Selenium Speed    ${DELAY}
    Login Page Should Be Open



Login Page Should Be Open
    Title Should Be    Login Page

Go To Login Page
    Go To    ${LOGIN URL}
    Login Page Should Be Open

Input Username
    [Arguments]    ${username}
    Input Text    username_field    ${username}

Input Password
    [Arguments]    ${password}
    Input Text    password_field    ${password}

Submit Credentials
    Click Button    login_button

Welcome Page Should Be Open
    Location Should Be    ${WELCOME URL}
    Title Should Be    Welcome Page


