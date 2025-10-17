@echo off
REM ===================================================================
REM TravelBlog 生产环境部署脚本 (Windows)
REM ===================================================================

echo.
echo ==========================================
echo    TravelBlog 生产环境部署脚本
echo ==========================================
echo.

REM 检查Java环境
echo [1/8] 检查Java环境...
java -version
if %errorlevel% neq 0 (
    echo 错误: 未找到Java环境，请安装Java 21+
    pause
    exit /b 1
)
echo Java环境检查通过 ✓
echo.

REM 检查Maven环境
echo [2/8] 检查Maven环境...
mvn -version
if %errorlevel% neq 0 (
    echo 错误: 未找到Maven环境
    pause
    exit /b 1
)
echo Maven环境检查通过 ✓
echo.

REM 构建项目
echo [3/8] 构建生产环境WAR包...
call mvn clean package -Pprod -DskipTests
if %errorlevel% neq 0 (
    echo 错误: 项目构建失败
    pause
    exit /b 1
)
echo 项目构建成功 ✓
echo.

REM 检查WAR文件
echo [4/8] 检查WAR文件...
if not exist "target\travelblog.war" (
    echo 错误: WAR文件不存在
    pause
    exit /b 1
)
echo WAR文件检查通过 ✓
echo.

REM 显示WAR文件信息
for %%I in (target\travelblog.war) do echo WAR文件大小: %%~zI 字节
echo.

REM 创建部署目录
echo [5/8] 创建部署目录...
if not exist "deployment" mkdir deployment
if not exist "deployment\config" mkdir deployment\config
if not exist "deployment\scripts" mkdir deployment\scripts
echo 部署目录创建完成 ✓
echo.

REM 复制WAR文件
echo [6/8] 复制WAR文件到部署目录...
copy "target\travelblog.war" "deployment\"
if %errorlevel% neq 0 (
    echo 错误: WAR文件复制失败
    pause
    exit /b 1
)
echo WAR文件复制完成 ✓
echo.

REM 生成生产环境配置
echo [7/8] 生成生产环境配置...
(
echo # 生产环境配置
echo spring:
echo   datasource:
echo     url: jdbc:mysql://localhost:3306/mytour_travel?useSSL=false^&serverTimezone=Asia/Kuala_Lumpur^&allowPublicKeyRetrieval=true^&characterEncoding=utf8
echo     username: travelblog
echo     password: CHANGE_THIS_PASSWORD
echo     driver-class-name: com.mysql.cj.jdbc.Driver
echo     hikari:
echo       maximum-pool-size: 10
echo       minimum-idle: 2
echo       connection-timeout: 30000
echo   
echo   jpa:
echo     hibernate:
echo       ddl-auto: none
echo     show-sql: false
echo     properties:
echo       hibernate:
echo         dialect: org.hibernate.dialect.MySQL8Dialect
echo         format_sql: false
echo   
echo server:
echo   port: 8080
echo   compression:
echo     enabled: true
echo   
echo logging:
echo   level:
echo     root: WARN
echo     com.example.travelblog: INFO
echo   file:
echo     name: logs/application.log
) > deployment\config\application-prod.yml

echo 生产环境配置文件生成完成 ✓
echo.

REM 生成启动脚本
echo [8/8] 生成启动脚本...
(
echo @echo off
echo REM TravelBlog 生产环境启动脚本
echo echo 启动TravelBlog应用...
echo.
echo REM 设置Java参数
echo set JAVA_OPTS=-Xms512m -Xmx1024m -XX:+UseG1GC -XX:MaxGCPauseMillis=200
echo.
echo REM 启动应用
echo java %JAVA_OPTS% -jar travelblog.war --spring.profiles.active=prod --spring.config.location=file:config/application-prod.yml
echo.
echo pause
) > deployment\start.bat

REM 生成停止脚本
(
echo @echo off
echo REM TravelBlog 停止脚本
echo echo 停止TravelBlog应用...
echo.
echo REM 查找Java进程
echo for /f "tokens=2" %%i in ('tasklist /fi "imagename eq java.exe" /fo table /nh ^| findstr travelblog'^) do (
echo     echo 停止进程 %%i
echo     taskkill /pid %%i /f
echo ^)
echo.
echo echo 应用已停止
echo pause
) > deployment\stop.bat

echo 启动脚本生成完成 ✓
echo.

REM 生成部署说明
(
echo # TravelBlog 生产环境部署说明
echo.
echo ## 部署文件
echo - travelblog.war: 应用程序WAR包
echo - config/application-prod.yml: 生产环境配置文件
echo - start.bat: 启动脚本
echo - stop.bat: 停止脚本
echo.
echo ## 部署步骤
echo.
echo ### 1. 准备服务器环境
echo - 安装Java 21+
echo - 安装MySQL 8.0+
echo - 创建数据库和用户
echo.
echo ### 2. 配置数据库
echo - 修改 config/application-prod.yml 中的数据库连接信息
echo - 导入 database-init.sql 到MySQL
echo.
echo ### 3. 启动应用
echo - 运行 start.bat 启动应用
echo - 访问 http://localhost:8080
echo.
echo ### 4. 验证部署
echo - 检查应用日志
echo - 测试各个功能页面
echo - 验证数据库连接
echo.
echo ## 注意事项
echo - 请修改数据库密码
echo - 确保防火墙开放8080端口
echo - 定期备份数据库
echo - 监控应用性能
) > deployment\README.md

echo 部署说明文档生成完成 ✓
echo.

echo ==========================================
echo           部署准备完成！
echo ==========================================
echo.
echo 生成的文件:
echo - deployment\travelblog.war
echo - deployment\config\application-prod.yml
echo - deployment\start.bat
echo - deployment\stop.bat
echo - deployment\README.md
echo.
echo 下一步:
echo 1. 修改 config/application-prod.yml 中的数据库配置
echo 2. 将deployment文件夹上传到服务器
echo 3. 在服务器上运行start.bat启动应用
echo.
echo 按任意键退出...
pause > nul
