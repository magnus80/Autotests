rem путь к JDK
set JAVA_HOME=c:\\Program Files\\Java\\jdk1.8.0_91

rem путь к Maven
set M2_HOME=c:\\apache-maven-3.3.9\

rem Тег необходимого пакета тестов, список смотри в !readme.txt
set tests=UWebtest

rem Установка разрешения по горизонтали и вертикали экрана
set width=1440
set height=856

rem Количество повторов при неудачном тесте
set povtor=0

rem Здесь и далее ничего не меняем
set conf_for_test=-Dbell.tags=%tests% -Dbell.browser=chrome -Dbell.killAllAfterTest=false -Dbell.browserWidth=%width% -Dbell.browserHeight=%height% -Dbell.handleAlertWhenOpenUrl=accept -Dbell.testTimeout=3600000 -Dbell.downloadTimeoutMs=60000 -Dbell.ajaxWaitMs=180000 -Dselenide.timeout=10000 -Dselenide.pollingInterval=200 -Dselenide.browser=Autotest.common.utils.BellWebDriverProvider -Dselenide.holdBrowserOpen=false -Dselenide.start-maximized=false -Dselenide.screenshots=false -Dwebdriver.ie.driver.extractpath=target -Dbell.retryCount=%povtor% -Dwebdriver.timeouts.implicitlywait=10000 -Dwebdriver.chrome.driver=Dependencies\\chromedriver.exe -Dallure.max.title.length=30000 -DDYNATRACE_ACTIVATE=false -Dallure.screenshot.afterStep=true -Dallure.screenshot.beforeStep=false -Dwebdriver.nativeEvents=false -Dwebdriver.ie.windowFocus=true -Dwebdriver.ignoreZoomSetting=false

if exist target\ del /S /Q target\
mvn -o %conf_for_test% -Dfile.encoding=UTF-8 --errors -e clean test >>log.txt

rem mvn -site

pause