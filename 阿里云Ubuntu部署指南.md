# 🚀 阿里云Ubuntu 22.04部署指南 - TravelBlog

## 📋 服务器配置
- **操作系统**: Ubuntu 22.04
- **CPU**: 2核心
- **内存**: 2GB RAM
- **网络**: 按量付费
- **云服务商**: 阿里云

---

## 第一步：连接到阿里云服务器

### 1.1 获取服务器信息
在阿里云控制台获取：
- **公网IP地址**（例如：123.456.789.10）
- **SSH端口**（默认22）
- **用户名**（默认root）
- **密码**或**密钥文件**

### 1.2 使用SSH连接服务器

**Windows用户（使用PowerShell或CMD）：**
```bash
ssh root@你的公网IP
# 例如：ssh root@123.456.789.10
# 输入密码后回车
```

**如果使用密钥文件：**
```bash
ssh -i "你的密钥文件.pem" root@你的公网IP
```

---

## 第二步：安装必要软件

### 2.1 更新系统
```bash
# 更新软件包列表
sudo apt update

# 升级已安装的软件包
sudo apt upgrade -y
```

### 2.2 安装Java 21
```bash
# 安装OpenJDK 21
sudo apt install openjdk-21-jdk -y

# 验证安装
java -version
# 应该显示：openjdk version "21.x.x"
```

### 2.3 安装MySQL 8.0
```bash
# 安装MySQL服务器
sudo apt install mysql-server -y

# 启动MySQL服务
sudo systemctl start mysql

# 设置开机自启动
sudo systemctl enable mysql

# 检查MySQL状态
sudo systemctl status mysql
# 看到"active (running)"表示运行正常
```

### 2.4 配置MySQL安全设置
```bash
# 运行安全配置脚本
sudo mysql_secure_installation

# 按照提示操作：
# 1. 是否设置密码验证插件？ 选择 No（或根据需要）
# 2. 设置root密码：输入你的密码（记住这个密码！）
# 3. 删除匿名用户？ Yes
# 4. 禁止root远程登录？ Yes（安全起见）
# 5. 删除test数据库？ Yes
# 6. 重新加载权限表？ Yes
```

### 2.5 安装Maven（可选，用于本地构建）
```bash
sudo apt install maven -y

# 验证安装
mvn -version
```

---

## 第三步：准备数据库

### 3.1 登录MySQL
```bash
sudo mysql -u root -p
# 输入你在安全配置时设置的密码
```

### 3.2 创建数据库和用户
在MySQL命令行中执行：
```sql
-- 创建数据库
CREATE DATABASE mytour_travel CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- 创建专用用户（不使用root）
CREATE USER 'travelblog'@'localhost' IDENTIFIED BY 'your_secure_password_here';

-- 授予权限
GRANT ALL PRIVILEGES ON mytour_travel.* TO 'travelblog'@'localhost';

-- 刷新权限
FLUSH PRIVILEGES;

-- 退出MySQL
EXIT;
```

**重要提醒**：请将 `'your_secure_password_here'` 替换为你自己的强密码！

### 3.3 导入数据库初始化脚本

首先需要上传 `database-init.sql` 文件到服务器：

**方法1：使用SCP上传（在你的本地电脑执行）**
```bash
scp C:\Users\12285\Documents\TravelBlog2.0\database-init.sql root@你的公网IP:/tmp/
```

**方法2：使用文件管理工具**
使用WinSCP、FileZilla等工具上传文件到服务器的 `/tmp/` 目录

**然后在服务器上执行导入：**
```bash
# 导入数据库
mysql -u travelblog -p mytour_travel < /tmp/database-init.sql
# 输入travelblog用户的密码

# 验证导入
mysql -u travelblog -p
```

在MySQL中验证：
```sql
USE mytour_travel;
SHOW TABLES;
-- 应该看到：users, destinations, packages, bookings等表

SELECT COUNT(*) FROM destinations;
-- 应该看到一些预设的目的地数据

EXIT;
```

---

## 第四步：部署应用程序

### 4.1 创建应用目录
```bash
# 创建应用目录
sudo mkdir -p /opt/travelblog
sudo mkdir -p /opt/travelblog/logs

# 设置权限
sudo chmod 755 /opt/travelblog
```

### 4.2 上传WAR文件到服务器

**在你的本地电脑上，先构建项目：**
```bash
# 在项目目录下执行
cd C:\Users\12285\Documents\TravelBlog2.0
mvn clean package -Pprod -DskipTests
```

构建成功后，WAR文件位于：`target/travelblog.war`

**使用SCP上传到服务器：**
```bash
scp target/travelblog.war root@你的公网IP:/opt/travelblog/
```

### 4.3 创建配置文件

在服务器上创建生产环境配置：
```bash
sudo nano /opt/travelblog/application-prod.yml
```

输入以下内容（**根据你的实际情况修改**）：
```yaml
spring:
  datasource:
    url: jdbc:mysql://localhost:3306/mytour_travel?useSSL=false&serverTimezone=Asia/Kuala_Lumpur&allowPublicKeyRetrieval=true&characterEncoding=utf8
    username: travelblog
    password: your_secure_password_here  # 改为你设置的密码
    driver-class-name: com.mysql.cj.jdbc.Driver
    hikari:
      maximum-pool-size: 5  # 2G内存服务器，降低连接池大小
      minimum-idle: 2
      connection-timeout: 30000
  
  jpa:
    hibernate:
      ddl-auto: none
    show-sql: false
    properties:
      hibernate:
        dialect: org.hibernate.dialect.MySQL8Dialect
        format_sql: false
        jdbc:
          batch_size: 20

server:
  port: 8080
  compression:
    enabled: true
    mime-types: text/html,text/xml,text/plain,text/css,text/javascript,application/javascript,application/json
  tomcat:
    threads:
      max: 50  # 降低最大线程数以适应2G内存
      min-spare: 10
    accept-count: 20

logging:
  level:
    root: INFO
    com.example.travelblog: INFO
  file:
    name: /opt/travelblog/logs/application.log
  pattern:
    file: '%d{yyyy-MM-dd HH:mm:ss} - %msg%n'
```

**按Ctrl+X，然后按Y，最后按Enter保存文件。**

### 4.4 创建启动脚本

```bash
sudo nano /opt/travelblog/start.sh
```

输入以下内容：
```bash
#!/bin/bash

# Java启动参数（针对2G内存优化）
JAVA_OPTS="-Xms512m -Xmx1024m"
JAVA_OPTS="$JAVA_OPTS -XX:+UseG1GC"
JAVA_OPTS="$JAVA_OPTS -XX:MaxGCPauseMillis=200"
JAVA_OPTS="$JAVA_OPTS -XX:+HeapDumpOnOutOfMemoryError"
JAVA_OPTS="$JAVA_OPTS -XX:HeapDumpPath=/opt/travelblog/logs/"

# 应用配置
SPRING_OPTS="--spring.profiles.active=prod"
SPRING_OPTS="$SPRING_OPTS --spring.config.location=file:/opt/travelblog/application-prod.yml"

# 启动应用
nohup java $JAVA_OPTS -jar /opt/travelblog/travelblog.war $SPRING_OPTS > /opt/travelblog/logs/console.log 2>&1 &

# 保存进程ID
echo $! > /opt/travelblog/app.pid

echo "Application started! PID: $(cat /opt/travelblog/app.pid)"
echo "Check logs: tail -f /opt/travelblog/logs/console.log"
```

**保存并赋予执行权限：**
```bash
sudo chmod +x /opt/travelblog/start.sh
```

### 4.5 创建停止脚本

```bash
sudo nano /opt/travelblog/stop.sh
```

输入以下内容：
```bash
#!/bin/bash

if [ -f /opt/travelblog/app.pid ]; then
    PID=$(cat /opt/travelblog/app.pid)
    echo "Stopping application (PID: $PID)..."
    kill $PID
    
    # 等待进程结束
    sleep 5
    
    # 如果进程还在运行，强制结束
    if ps -p $PID > /dev/null; then
        echo "Force killing..."
        kill -9 $PID
    fi
    
    rm /opt/travelblog/app.pid
    echo "Application stopped!"
else
    echo "PID file not found. Application may not be running."
fi
```

**保存并赋予执行权限：**
```bash
sudo chmod +x /opt/travelblog/stop.sh
```

### 4.6 启动应用

```bash
cd /opt/travelblog
sudo ./start.sh
```

### 4.7 查看启动日志

```bash
# 实时查看日志
tail -f /opt/travelblog/logs/console.log

# 按Ctrl+C退出日志查看
```

看到以下类似信息表示启动成功：
```
Started TravelBlogApplication in X.XXX seconds
```

---

## 第五步：配置防火墙和安全组

### 5.1 配置Ubuntu防火墙（UFW）

```bash
# 允许SSH（重要！防止被锁在外面）
sudo ufw allow 22/tcp

# 允许HTTP
sudo ufw allow 80/tcp

# 允许HTTPS（可选，如果配置SSL）
sudo ufw allow 443/tcp

# 启用防火墙
sudo ufw enable

# 查看状态
sudo ufw status
```

### 5.2 配置阿里云安全组

**重要！必须在阿里云控制台操作：**

1. 登录阿里云控制台
2. 进入 **云服务器ECS** → **实例**
3. 找到你的服务器，点击 **更多** → **网络和安全组** → **安全组配置**
4. 点击 **配置规则** → **添加安全组规则**
5. 添加以下规则：

| 规则方向 | 协议类型 | 端口范围 | 授权对象 | 描述 |
|---------|---------|---------|---------|------|
| 入方向 | TCP | 22 | 0.0.0.0/0 | SSH访问 |
| 入方向 | TCP | 80 | 0.0.0.0/0 | HTTP访问 |
| 入方向 | TCP | 443 | 0.0.0.0/0 | HTTPS访问（可选） |

---

## 第六步：安装和配置Nginx反向代理

### 6.1 安装Nginx

```bash
sudo apt install nginx -y

# 启动Nginx
sudo systemctl start nginx

# 设置开机自启动
sudo systemctl enable nginx
```

### 6.2 配置Nginx

```bash
# 创建配置文件
sudo nano /etc/nginx/sites-available/travelblog
```

输入以下内容：
```nginx
server {
    listen 80;
    server_name 你的公网IP;  # 改为你的实际IP或域名
    
    # 请求体大小限制（允许上传图片）
    client_max_body_size 10M;
    
    # 静态资源缓存
    location ~* \.(jpg|jpeg|png|gif|ico|css|js|woff|woff2|ttf|svg|mp4)$ {
        proxy_pass http://localhost:8080;
        expires 7d;
        add_header Cache-Control "public, immutable";
    }
    
    # 代理到Spring Boot应用
    location / {
        proxy_pass http://localhost:8080;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        
        # 超时设置
        proxy_connect_timeout 60s;
        proxy_send_timeout 60s;
        proxy_read_timeout 60s;
    }
    
    # 日志
    access_log /var/log/nginx/travelblog_access.log;
    error_log /var/log/nginx/travelblog_error.log;
}
```

**按Ctrl+X，然后按Y，最后按Enter保存。**

### 6.3 启用配置并重启Nginx

```bash
# 创建软链接启用配置
sudo ln -s /etc/nginx/sites-available/travelblog /etc/nginx/sites-enabled/

# 测试配置是否正确
sudo nginx -t

# 如果显示"syntax is ok"和"test is successful"，重启Nginx
sudo systemctl restart nginx
```

---

## 第七步：验证部署

### 7.1 检查应用状态

```bash
# 检查Java进程
ps aux | grep java

# 检查端口监听
sudo netstat -tlnp | grep 8080

# 查看应用日志
tail -f /opt/travelblog/logs/application.log
```

### 7.2 访问应用

在浏览器中访问：
```
http://你的公网IP
```

例如：`http://123.456.789.10`

**应该能看到旅游博客的首页！**

### 7.3 测试其他页面

- 首页：`http://你的IP/`
- 目的地页面：`http://你的IP/destinations`
- 套餐页面：`http://你的IP/packages`
- 登录页面：`http://你的IP/account/login`
- 健康检查：`http://你的IP/actuator/health`

---

## 第八步：创建systemd服务（推荐）

为了让应用开机自启动和方便管理，创建systemd服务：

```bash
sudo nano /etc/systemd/system/travelblog.service
```

输入以下内容：
```ini
[Unit]
Description=MyTour Travel Blog Application
After=mysql.service network.target

[Service]
Type=simple
User=root
WorkingDirectory=/opt/travelblog
ExecStart=/usr/bin/java -Xms512m -Xmx1024m -XX:+UseG1GC -jar /opt/travelblog/travelblog.war --spring.profiles.active=prod --spring.config.location=file:/opt/travelblog/application-prod.yml
ExecStop=/bin/kill -15 $MAINPID
Restart=always
RestartSec=10
StandardOutput=append:/opt/travelblog/logs/console.log
StandardError=append:/opt/travelblog/logs/console.log

[Install]
WantedBy=multi-user.target
```

**保存并启用服务：**
```bash
# 重新加载systemd配置
sudo systemctl daemon-reload

# 停止之前手动启动的应用
sudo /opt/travelblog/stop.sh

# 启动服务
sudo systemctl start travelblog

# 设置开机自启动
sudo systemctl enable travelblog

# 查看服务状态
sudo systemctl status travelblog
```

**管理服务命令：**
```bash
# 启动服务
sudo systemctl start travelblog

# 停止服务
sudo systemctl stop travelblog

# 重启服务
sudo systemctl restart travelblog

# 查看日志
sudo journalctl -u travelblog -f
```

---

## 第九步：性能优化（针对2G内存）

### 9.1 调整MySQL配置

```bash
sudo nano /etc/mysql/mysql.conf.d/mysqld.cnf
```

在 `[mysqld]` 部分添加或修改：
```ini
[mysqld]
# 针对2G内存的优化
max_connections = 50
innodb_buffer_pool_size = 256M
innodb_log_file_size = 64M
query_cache_size = 32M
query_cache_type = 1
```

**重启MySQL：**
```bash
sudo systemctl restart mysql
```

### 9.2 配置Swap空间（增加虚拟内存）

```bash
# 创建2GB的swap文件
sudo fallocate -l 2G /swapfile

# 设置权限
sudo chmod 600 /swapfile

# 设置为swap
sudo mkswap /swapfile

# 启用swap
sudo swapon /swapfile

# 开机自动挂载
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab

# 验证swap
free -h
```

### 9.3 监控系统资源

```bash
# 安装htop（可选）
sudo apt install htop -y

# 查看系统资源使用
htop

# 或使用free命令
free -h

# 查看磁盘使用
df -h
```

---

## 第十步：设置自动备份

### 10.1 创建备份脚本

```bash
sudo nano /opt/travelblog/backup.sh
```

输入以下内容：
```bash
#!/bin/bash

# 备份目录
BACKUP_DIR="/opt/travelblog/backups"
DATE=$(date +%Y%m%d_%H%M%S)

# 创建备份目录
mkdir -p $BACKUP_DIR

# 备份数据库
mysqldump -u travelblog -pyour_secure_password_here mytour_travel > $BACKUP_DIR/db_backup_$DATE.sql

# 压缩备份
gzip $BACKUP_DIR/db_backup_$DATE.sql

# 删除7天前的备份
find $BACKUP_DIR -name "db_backup_*.sql.gz" -mtime +7 -delete

echo "Backup completed: db_backup_$DATE.sql.gz"
```

**保存并赋予执行权限：**
```bash
sudo chmod +x /opt/travelblog/backup.sh
```

### 10.2 设置定时备份

```bash
# 编辑crontab
sudo crontab -e

# 添加以下行（每天凌晨2点自动备份）
0 2 * * * /opt/travelblog/backup.sh >> /opt/travelblog/logs/backup.log 2>&1
```

---

## 常见问题排查

### 问题1：应用启动失败

**查看日志：**
```bash
tail -100 /opt/travelblog/logs/console.log
```

**常见原因：**
- 数据库连接失败：检查MySQL是否运行，密码是否正确
- 端口被占用：检查8080端口是否已被使用
- 内存不足：检查系统内存使用情况

### 问题2：无法访问网站

**检查清单：**
```bash
# 1. 检查应用是否运行
sudo systemctl status travelblog

# 2. 检查Nginx是否运行
sudo systemctl status nginx

# 3. 检查端口监听
sudo netstat -tlnp | grep -E '80|8080'

# 4. 检查防火墙
sudo ufw status

# 5. 检查Nginx日志
sudo tail -50 /var/log/nginx/error.log
```

### 问题3：数据库连接错误

```bash
# 测试数据库连接
mysql -u travelblog -p mytour_travel

# 检查MySQL状态
sudo systemctl status mysql

# 查看MySQL错误日志
sudo tail -50 /var/log/mysql/error.log
```

### 问题4：内存不足

```bash
# 查看内存使用
free -h

# 重启应用释放内存
sudo systemctl restart travelblog

# 如果频繁内存不足，考虑升级服务器配置
```

---

## 维护命令速查表

```bash
# 查看应用状态
sudo systemctl status travelblog

# 重启应用
sudo systemctl restart travelblog

# 查看实时日志
tail -f /opt/travelblog/logs/application.log

# 查看系统资源
htop
# 或
free -h && df -h

# 手动备份数据库
sudo /opt/travelblog/backup.sh

# 查看Nginx访问日志
sudo tail -f /var/log/nginx/travelblog_access.log

# 清理日志（如果磁盘空间不足）
sudo find /opt/travelblog/logs -name "*.log" -mtime +7 -delete
```

---

## 🎉 部署完成！

恭喜！你的旅游博客已经成功部署到阿里云服务器上了！

**访问地址：**
- 网站：`http://你的公网IP`
- 健康检查：`http://你的公网IP/actuator/health`

**下一步建议：**
1. ✅ 绑定域名（在阿里云DNS管理）
2. ✅ 配置SSL证书（推荐使用Let's Encrypt免费证书）
3. ✅ 设置定期监控和告警
4. ✅ 定期更新系统和应用

**技术支持：**
- 查看完整文档：README.md
- 应用日志：/opt/travelblog/logs/
- 如有问题，查看日志文件排查

祝使用愉快！🚀

