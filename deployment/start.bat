@echo off
REM TravelBlog 生产环境启动脚本
echo 启动TravelBlog应用...

REM 设置Java参数
set JAVA_OPTS=-Xms512m -Xmx1024m -XX:+UseG1GC -XX:MaxGCPauseMillis=200

REM 启动应用
java %JAVA_OPTS% -jar travelblog.war --spring.profiles.active=prod --spring.config.location=file:config/application-prod.yml

pause
