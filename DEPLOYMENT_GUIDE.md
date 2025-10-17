# 🚀 MyTour Travel Blog Deployment Guide

## 📋 Table of Contents
1. [Prerequisites](#prerequisites)
2. [Local Development Environment Deployment](#local-development-environment-deployment)
3. [Production Environment Deployment](#production-environment-deployment)
4. [Cloud Platform Deployment](#cloud-platform-deployment)
5. [Common Issues](#common-issues)

---

## 🔧 Prerequisites

### Required Software
- **Java 21** or higher [Download](https://www.oracle.com/java/technologies/downloads/)
- **Maven 3.8+** [Download](https://maven.apache.org/download.cgi)
- **MySQL 8.0+** [Download](https://dev.mysql.com/downloads/mysql/)

### Verify Installation
```bash
# Check Java version
java -version
# Should display: java version "21.x.x"

# Check Maven version
mvn -version
# Should display: Apache Maven 3.8.x

# Check if MySQL is running
mysql --version
# Should display: mysql Ver 8.0.x
```

---

## 💻 Local Development Environment Deployment

### Step 1: Prepare Database

#### 1.1 Start MySQL Service
```bash
# Windows (Run CMD as Administrator)
net start MySQL80

# macOS/Linux
sudo systemctl start mysql
# or
sudo service mysql start
```

#### 1.2 Create Database and Import Data
```bash
# Method 1: Using command line
mysql -u root -p

# After entering MySQL, execute:
source C:/Users/12285/Documents/TravelBlog/database-init.sql
# or on Linux/Mac:
source /path/to/database-init.sql

# Method 2: Direct import
mysql -u root -p < database-init.sql
```

#### 1.3 Verify Database Creation
```sql
mysql -u root -p

USE mytour_travel;
SHOW TABLES;
-- Should see: users, destinations, packages, bookings, contact_messages tables

SELECT COUNT(*) FROM destinations;
-- Should see some preset destination data
```

### Step 2: Configure Application

#### 2.1 Edit Configuration File
Open `src/main/resources/application.yml` and modify database connection information:

```yaml
spring:
  datasource:
    url: jdbc:mysql://localhost:3306/mytour_travel?useSSL=false&serverTimezone=Asia/Kuala_Lumpur&allowPublicKeyRetrieval=true
    username: root  # Change to your MySQL username
    password: your_password  # Change to your MySQL password
    driver-class-name: com.mysql.cj.jdbc.Driver
```

**Important Note**: Timezone is set to `Asia/Kuala_Lumpur` (Malaysia timezone)

#### 2.2 Development Environment Configuration (Optional)
Edit `src/main/resources/application-dev.yml`:
```yaml
spring:
  datasource:
    password: dev_password  # Development environment password
  jpa:
    show-sql: true  # Display SQL statements for debugging
    properties:
      hibernate:
        format_sql: true
```

### Step 3: Build Project

```bash
# Navigate to project directory
cd C:\Users\12285\Documents\TravelBlog

# Clean and build project
mvn clean install

# If tests fail, skip tests
mvn clean install -DskipTests
```

**Build Success Indicator**:
```
[INFO] BUILD SUCCESS
[INFO] Total time: 45.123 s
```

### Step 4: Run Application

#### Method 1: Using Maven (Recommended for Development)
```bash
# Run with default configuration
mvn spring-boot:run

# Run with development environment configuration
mvn spring-boot:run -Dspring-boot.run.profiles=dev

# Run with specified port
mvn spring-boot:run -Dspring-boot.run.arguments=--server.port=8081
```

#### Method 2: Run JAR File
```bash
# First build JAR file
mvn clean package -DskipTests

# Run JAR
java -jar target/travelblog-0.0.1-SNAPSHOT.jar

# Run with specific configuration
java -jar target/travelblog-0.0.1-SNAPSHOT.jar --spring.profiles.active=dev
```

#### Method 3: Run in IDE
1. Open `src/main/java/com/example/travelblog/TravelBlogApplication.java`
2. Right-click on file
3. Select "Run 'TravelBlogApplication'"

### Step 5: Verify Deployment

Access the following URLs to verify the application is running correctly:

```
✅ Homepage: http://localhost:8080
✅ Health Check: http://localhost:8080/actuator/health
✅ Destinations Page: http://localhost:8080/destinations
✅ Packages Page: http://localhost:8080/packages
✅ Login Page: http://localhost:8080/account/login
✅ Profile Page: http://localhost:8080/account/profile
```

**Create Test Account**:
```sql
-- Login to MySQL
mysql -u root -p
USE mytour_travel;

-- Create test user (password: password123)
INSERT INTO users (username, password, email, first_name, last_name, role, active, created_at, updated_at)
VALUES ('testuser', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iAt6Z5EH', 
        'test@example.com', 'Test', 'User', 'USER', TRUE, NOW(), NOW());

-- Create admin account (password: admin123)
INSERT INTO users (username, password, email, first_name, last_name, role, active, created_at, updated_at)
VALUES ('admin', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iAt6Z5EH', 
        'admin@example.com', 'Admin', 'User', 'ADMIN', TRUE, NOW(), NOW());
```

---

## 🌐 Production Environment Deployment

### Step 1: Prepare Production Server

**Server Requirements**:
- Operating System: Ubuntu 20.04+ / CentOS 7+ / Windows Server
- Memory: At least 2GB RAM (4GB recommended)
- CPU: 2 cores or more
- Storage: 20GB or more
- Java 21 installed
- MySQL 8.0 installed

### Step 2: Configure Production Environment

#### 2.1 Edit Production Configuration
Edit `src/main/resources/application-prod.yml`:

```yaml
spring:
  datasource:
    url: jdbc:mysql://your-server-ip:3306/mytour_travel?useSSL=true&serverTimezone=Asia/Kuala_Lumpur
    username: prod_user
    password: ${DB_PASSWORD}  # Use environment variable
  
  jpa:
    show-sql: false  # Don't display SQL in production
    hibernate:
      ddl-auto: none  # Don't auto-modify database structure in production

server:
  port: 8080
  compression:
    enabled: true  # Enable response compression
  
logging:
  level:
    root: INFO
    com.example.travelblog: INFO
  file:
    name: logs/travel-blog.log
    max-size: 10MB
    max-history: 30
```

#### 2.2 Set Environment Variables
```bash
# Linux/Mac
export DB_PASSWORD="your_secure_password"
export SPRING_PROFILES_ACTIVE=prod

# Windows (PowerShell)
$env:DB_PASSWORD="your_secure_password"
$env:SPRING_PROFILES_ACTIVE="prod"

# Windows (CMD)
set DB_PASSWORD=your_secure_password
set SPRING_PROFILES_ACTIVE=prod
```

### Step 3: Build Production Version

```bash
# Build with production configuration
mvn clean package -Pprod -DskipTests

# Build will generate:
# target/travelblog-0.0.1-SNAPSHOT.jar
```

### Step 4: Deploy to Server

#### Method 1: Traditional Deployment (JAR File)

```bash
# 1. Upload JAR file to server
scp target/travelblog-0.0.1-SNAPSHOT.jar user@your-server:/opt/travelblog/

# 2. Connect to server
ssh user@your-server

# 3. Create startup script
cat > /opt/travelblog/start.sh << 'EOF'
#!/bin/bash
export DB_PASSWORD="your_password"
export SPRING_PROFILES_ACTIVE=prod
nohup java -jar \
  -Xms512m \
  -Xmx1024m \
  -Dserver.port=8080 \
  /opt/travelblog/travelblog-0.0.1-SNAPSHOT.jar \
  > /opt/travelblog/logs/app.log 2>&1 &
echo $! > /opt/travelblog/app.pid
EOF

chmod +x /opt/travelblog/start.sh

# 4. Start application
cd /opt/travelblog
./start.sh

# 5. View logs
tail -f logs/app.log
```

#### Method 2: Using systemd Service (Linux Recommended)

Create service file `/etc/systemd/system/travelblog.service`:

```ini
[Unit]
Description=MyTour Travel Blog Application
After=mysql.service

[Service]
Type=simple
User=travelblog
WorkingDirectory=/opt/travelblog
Environment="DB_PASSWORD=your_password"
Environment="SPRING_PROFILES_ACTIVE=prod"
ExecStart=/usr/bin/java -jar \
  -Xms512m \
  -Xmx1024m \
  /opt/travelblog/travelblog-0.0.1-SNAPSHOT.jar
Restart=always
RestartSec=10

[Install]
WantedBy=multi-user.target
```

Start service:
```bash
# Reload systemd
sudo systemctl daemon-reload

# Start service
sudo systemctl start travelblog

# Enable auto-start on boot
sudo systemctl enable travelblog

# Check status
sudo systemctl status travelblog

# View logs
sudo journalctl -u travelblog -f
```

### Step 5: Configure Reverse Proxy (Nginx)

Install Nginx:
```bash
# Ubuntu/Debian
sudo apt update
sudo apt install nginx

# CentOS/RHEL
sudo yum install nginx
```

Configure Nginx `/etc/nginx/sites-available/travelblog`:
```nginx
server {
    listen 80;
    server_name yourdomain.com www.yourdomain.com;
    
    # Redirect to HTTPS
    return 301 https://$server_name$request_uri;
}

server {
    listen 443 ssl http2;
    server_name yourdomain.com www.yourdomain.com;
    
    # SSL certificate configuration
    ssl_certificate /etc/ssl/certs/your_cert.crt;
    ssl_certificate_key /etc/ssl/private/your_key.key;
    
    # Static file caching
    location ~* \.(jpg|jpeg|png|gif|ico|css|js|woff|woff2|ttf)$ {
        proxy_pass http://localhost:8080;
        expires 1y;
        add_header Cache-Control "public, immutable";
    }
    
    # Proxy to Spring Boot
    location / {
        proxy_pass http://localhost:8080;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        
        # WebSocket support
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
    }
    
    # Logging
    access_log /var/log/nginx/travelblog_access.log;
    error_log /var/log/nginx/travelblog_error.log;
}
```

Enable configuration:
```bash
sudo ln -s /etc/nginx/sites-available/travelblog /etc/nginx/sites-enabled/
sudo nginx -t  # Test configuration
sudo systemctl restart nginx
```

---

## ☁️ Cloud Platform Deployment

### AWS Deployment (Elastic Beanstalk)

1. **Prepare JAR File**
   ```bash
   mvn clean package -Pprod -DskipTests
   ```

2. **Upload to Elastic Beanstalk**
   - Login to AWS Console
   - Go to Elastic Beanstalk
   - Create new application
   - Select Java platform
   - Upload JAR file

3. **Configure Environment Variables**
   - DB_PASSWORD
   - SPRING_PROFILES_ACTIVE=prod

### Azure Deployment (App Service)

```bash
# Install Azure CLI
# Login
az login

# Create resource group
az group create --name travelblog-rg --location southeastasia

# Create App Service Plan
az appservice plan create \
  --name travelblog-plan \
  --resource-group travelblog-rg \
  --sku B2 \
  --is-linux

# Create Web App
az webapp create \
  --resource-group travelblog-rg \
  --plan travelblog-plan \
  --name mytour-travelblog \
  --runtime "JAVA:21-java21"

# Deploy JAR
az webapp deploy \
  --resource-group travelblog-rg \
  --name mytour-travelblog \
  --src-path target/travelblog-0.0.1-SNAPSHOT.jar
```

### Google Cloud Platform (App Engine)

Create `app.yaml`:
```yaml
runtime: java21
instance_class: F2

env_variables:
  SPRING_PROFILES_ACTIVE: "prod"
  DB_PASSWORD: "your_password"

automatic_scaling:
  min_instances: 1
  max_instances: 5
```

Deploy:
```bash
gcloud app deploy
```

---

## 🔍 Common Issues

### Issue 1: Port Already in Use

**Error Message**:
```
Web server failed to start. Port 8080 was already in use.
```

**Solution**:
```bash
# Method 1: Change port
mvn spring-boot:run -Dspring-boot.run.arguments=--server.port=8081

# Method 2: Find and kill process using the port
# Windows
netstat -ano | findstr :8080
taskkill /PID <process_id> /F

# Linux/Mac
lsof -i :8080
kill -9 <process_id>
```

### Issue 2: Database Connection Failed

**Error Message**:
```
Communications link failure
```

**Solution**:
1. Check if MySQL is running
   ```bash
   # Windows
   net start MySQL80
   
   # Linux
   sudo systemctl status mysql
   ```

2. Check connection information
   - Confirm port number (default 3306)
   - Confirm username and password
   - Confirm database name

3. Test connection
   ```bash
   mysql -u root -p -h localhost -P 3306
   ```

### Issue 3: Static Resources 404

**Solution**:
Ensure static resources are in the correct location:
```
src/main/resources/static/
  ├── css/
  ├── js/
  └── images/
src/main/webapp/
  ├── images/
  └── videos/
```

### Issue 4: Out of Memory

**Error Message**:
```
OutOfMemoryError: Java heap space
```

**Solution**:
```bash
# Increase heap memory
java -jar -Xms1g -Xmx2g target/travelblog-0.0.1-SNAPSHOT.jar
```

### Issue 5: Log Files Too Large

**Solution**:
Configure log rotation (already configured in `logback-spring.xml`):
```xml
<rollingPolicy class="ch.qos.logback.core.rolling.SizeAndTimeBasedRollingPolicy">
    <maxFileSize>10MB</maxFileSize>
    <maxHistory>30</maxHistory>
</rollingPolicy>
```

---

## 📊 Performance Optimization Recommendations

### 1. JVM Tuning
```bash
java -jar \
  -Xms1g \
  -Xmx2g \
  -XX:+UseG1GC \
  -XX:MaxGCPauseMillis=200 \
  -XX:+HeapDumpOnOutOfMemoryError \
  app.jar
```

### 2. MySQL Optimization
```sql
-- Increase connection pool size
SET GLOBAL max_connections = 200;

-- Optimize query cache
SET GLOBAL query_cache_size = 67108864;

-- Add indexes (already in database-init.sql)
```

### 3. Enable Caching
The application is already configured with Caffeine cache, no additional configuration needed.

### 4. Use CDN
Upload static resources to CDN to improve loading speed.

---

## 🔒 Security Recommendations

1. **Use HTTPS**
   - Apply for SSL certificate (Let's Encrypt is free)
   - Configure Nginx/Apache to use HTTPS

2. **Environment Variable Management**
   - Don't hardcode passwords in code
   - Use environment variables or key management services

3. **Regular Updates**
   - Regularly update dependencies
   - Monitor security vulnerabilities

4. **Backup Strategy**
   ```bash
   # Database backup script
   #!/bin/bash
   DATE=$(date +%Y%m%d_%H%M%S)
   mysqldump -u root -p mytour_travel > backup_$DATE.sql
   ```

---

## 📞 Technical Support

If you encounter issues:
1. Check log files: `logs/travel-blog.log`
2. Check application status: `http://localhost:8080/actuator/health`
3. Review detailed documentation: `README.md`

---

**After successful deployment, your application will be available at**:
- 🌐 Homepage: http://your-domain.com
- 👤 Profile: http://your-domain.com/account/profile
- 📦 Browse Packages: http://your-domain.com/packages
- 🏖️ Destinations: http://your-domain.com/destinations

**Happy Deploying!** 🎉