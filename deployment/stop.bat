@echo off
REM TravelBlog 停止脚本
echo 停止TravelBlog应用...

REM 查找Java进程
for /f "tokens=2" %%i in ('tasklist /fi "imagename eq java.exe" /fo table /nh | findstr travelblog') do (
    echo 停止进程 %%i
    taskkill /pid %%i /f
)

echo 应用已停止
pause
