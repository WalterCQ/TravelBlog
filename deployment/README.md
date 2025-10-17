# TravelBlog 生产环境部署说明

## 部署文件
- `travelblog.war`: 应用程序WAR包
- `config/application-prod.yml`: 生产环境配置文件
- `start.bat`: 启动脚本
- `stop.bat`: 停止脚本

## 部署步骤

### 1. 准备服务器环境
- 安装Java 21+
- 安装MySQL 8.0+
- 创建数据库和用户

### 2. 配置数据库
- 修改 `config/application-prod.yml` 中的数据库连接信息
- 导入 `database-init.sql` 到MySQL

### 3. 启动应用
- 运行 `start.bat` 启动应用
- 访问 http://localhost:8080

### 4. 验证部署
- 检查应用日志
- 测试各个功能页面
- 验证数据库连接

## 注意事项
- 请修改数据库密码
- 确保防火墙开放8080端口
- 定期备份数据库
- 监控应用性能

## 服务器要求
- 操作系统: Windows Server 2019+ / Ubuntu 20.04+ / CentOS 7+
- Java: 21+
- MySQL: 8.0+
- 内存: 至少2GB RAM (推荐4GB)
- 存储: 至少20GB可用空间

## 快速部署命令

### Windows服务器
```cmd
# 1. 解压部署包到服务器
# 2. 修改配置文件
# 3. 启动应用
start.bat
```

### Linux服务器
```bash
# 1. 上传部署包到服务器
# 2. 修改配置文件
# 3. 启动应用
java -Xms512m -Xmx1024m -jar travelblog.war --spring.profiles.active=prod --spring.config.location=file:config/application-prod.yml
```

## 故障排除

### 常见问题
1. **端口被占用**: 修改配置文件中的端口号
2. **数据库连接失败**: 检查数据库服务和连接信息
3. **内存不足**: 调整Java堆内存参数
4. **文件权限问题**: 确保应用有读写权限

### 日志查看
- 应用日志: `logs/application.log`
- 控制台输出: 启动脚本的输出

## 性能优化建议
- 配置反向代理 (Nginx/Apache)
- 启用GZIP压缩
- 配置CDN加速静态资源
- 定期清理日志文件
- 监控系统资源使用情况
