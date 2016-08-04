rem путь к JDK
set JAVA_HOME=C:\\Program Files (x86)\\Java\\jdk1.7.0_79

rem путь к Maven
set M2_HOME=C:\\Ccbo_Folder\\apache-maven-3.3.3

rem Здесь и далее ничего не меняем
cd..
mvn -o -Dfile.encoding=UTF-8 --errors -e site jetty:run
