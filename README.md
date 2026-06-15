# 🚗 Xiaomi EV Mate

![Docker Image](https://img.shields.io/badge/Docker-ponyix%2Fxiaomiev--mate-2496ED?logo=docker&logoColor=white)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-15-4169E1?logo=postgresql&logoColor=white)
![Deploy](https://img.shields.io/badge/Deploy-Docker%20Compose-0db7ed?logo=docker&logoColor=white)

Xiaomi EV Mate 是一个面向小米汽车车主的私有化数据管理工具，用于统一查看车辆状态、行程记录、充电分析、车况历史、统计数据和月度报告。

> 建议部署在 NAS、家庭服务器或个人云主机等私有环境中。项目会保存车辆、行程和账号相关配置，请妥善保管数据库、日志和 `.env` 文件。

## ✨ 快速入口

| 入口 | 链接                                                       |
| --- |----------------------------------------------------------|
| 🌐 官网首页 | [官方网站](http://www.xiaomievmate.com/)                     |
| 🎮 在线演示 | [体验演示站](https://www.xiaomimate.com)                      |
| 📘 快速开始 | [快速开始文档](http://www.xiaomievmate.com/issues/quick-start) |
| 🚀 部署指南 | [部署指南](http://www.xiaomievmate.com/issues/deploy)        |
| 🔐 小米账号配置 | [账号配置指南](http://www.xiaomievmate.com/issues/account)     |
| 🧭 常见问题 | [FAQ](http://www.xiaomievmate.com/issues/faq)            |
| 📝 更新日志 | [Changelog](http://www.xiaomievmate.com/changelog)       |
| 🐳 Docker Hub | [镜像仓库](https://hub.docker.com/r/ponyix/xiaomiev-mate)    |

## 🧩 功能概览

- 📊 **监控大屏**：查看车辆状态、续航、电量、温度等概览信息
- 🛣️ **行程记录**：同步历史行程，查看行程详情和轨迹
- 🔋 **充电记录**：查看充电历史、充入电量、充电功率和充电过程曲线
- 📈 **数据统计**：汇总里程、能耗、充电、用车习惯等指标
- 🧾 **车况历史**：记录车辆状态变化，辅助分析异常波动
- 📅 **月度报告**：同步小米汽车侧月度行车报告
- 🔔 **事件通知**：支持充电、车况等事件通知配置

## 🐳 Docker 镜像

项目镜像发布在 Docker Hub：

- Docker Hub：[镜像仓库](https://hub.docker.com/r/ponyix/xiaomiev-mate)
- 后端镜像：`ponyix/xiaomiev-mate:backend-latest`
- 前端镜像：`ponyix/xiaomiev-mate:web-latest`

如果需要固定版本，可以使用类似下面的标签：

```text
ponyix/xiaomiev-mate:backend-v1.0.x
ponyix/xiaomiev-mate:web-v1.0.x
```

最新版本号请查看：[更新日志](http://www.xiaomievmate.com/changelog)。

## 🚀 快速部署

### Linux 一键安装

Linux 用户推荐使用官网安装脚本，自动检查 Docker 并部署最新版本：

```bash
curl -fSsL 'https://www.xiaomievmate.com/scripts/install.sh' | sudo bash
```

首次安装时，脚本会提示输入数据库密码。详细说明请阅读：
[Linux 一键安装教程](https://www.xiaomievmate.com/issues/linux)。

### Docker Compose 部署

需要通过 `docker-compose.yml` 控制端口、目录或镜像版本时，可以使用仓库部署脚本：

```bash
git clone git@github.com:Ponyix/xiaomiev-mate-public.git
cd xiaomiev-mate-public
cp .env.example .env
chmod +x deploy.sh
./deploy.sh
```

首次部署前，请先修改 `.env` 中的数据库密码：

```bash
DB_PASSWORD=your_password
```

部署完成后，在浏览器访问本机或部署设备的 `18080` 端口。

更完整的部署说明、端口配置和版本固定方式，请阅读：[部署指南](http://www.xiaomievmate.com/issues/deploy)。

## 📌 固定版本部署

如果不想使用 `latest`，可以在 `.env` 中固定镜像版本：

```bash
BACKEND_IMAGE_TAG=v1.0.x
WEB_IMAGE_TAG=v1.0.x
```

也可以执行部署时临时指定：

```bash
BACKEND_IMAGE_TAG=v1.0.x WEB_IMAGE_TAG=v1.0.x ./deploy.sh
```

## 🧱 手动 Docker Compose 部署

如果你希望自己控制 Compose 配置，可以直接使用仓库中的 `docker-compose.yml`：

```bash
docker compose -f docker-compose.yml up -d
```

手动部署时请确认数据库密码已正确配置，并保证后端环境变量中的数据库密码与 PostgreSQL 密码一致。

完整 Compose 示例和参数说明请阅读：[部署指南](http://www.xiaomievmate.com/issues/deploy)。

## 📚 NAS 图文教程

如果你使用 NAS 部署，可以参考线上图文教程：

- 🟢 绿联 NAS 安装教程：[查看教程](http://www.xiaomievmate.com/issues/ugnas)
- 🟣 极空间安装教程：[查看教程](http://www.xiaomievmate.com/issues/zspace)

## 🔑 首次登录

系统首次启动时会自动创建管理员账号：

```text
用户名：admin
密码：admin
```

首次登录后请立即修改默认密码。

## 🔐 小米账号配置

进入 Web 端 **个人中心 → 登录小米账号**，按页面提示完成小米账号配置。

不同设备的推荐方式略有区别：

- 📱 **小米手机**：优先使用二维码登录，并选择当前登录小米汽车 App 的设备
- 🍎 **iPhone**：推荐手动配置，抓包获取 `EUI` 和 `deviceId`
- 🤖 **非小米安卓**：通常使用二维码登录，并手动填写 `deviceId`

账号配置涉及敏感信息，详细图文步骤请参考：[小米账号配置指南](http://www.xiaomievmate.com/issues/account)。

## 🧭 添加车辆与同步数据

登录后按下面顺序完成初始化：

1. 进入 **车辆管理 → 添加车辆**
2. 选择需要同步数据的小米汽车
3. 进入 **个人中心 → 车辆管理 → 数据同步**
4. 首次部署建议执行一次完整历史行程和月度报告同步

更完整的新手流程请阅读：[快速开始](http://www.xiaomievmate.com/issues/quick-start)。

## 🧹 临时体验清理

如果只是临时体验，建议体验结束后删除容器与本地数据，避免敏感信息残留：

```bash
docker compose -f docker-compose.yml down
rm -rf pgdata logs
```

## 🛟 反馈与支持

部署或使用中遇到问题时，优先查看：[常见问题](http://www.xiaomievmate.com/issues/faq)。

也可以通过以下方式反馈：

- GitHub Issues：[提交问题](https://github.com/Ponyix/xiaomiev-mate-public/issues)
- 邮箱：`mkx3887@gmail.com`

## ⚠️ 免责声明

- 本项目仅用于个人学习与数据管理，请遵守当地法律法规与小米服务协议。
- 车辆、行程、账号配置等数据较敏感，请仅部署在可信环境中。
- 因使用本项目导致的账号风控、服务异常、数据损失等风险，请自行承担。
- 抓包、扫码登录等操作请确认由本人授权并妥善保存敏感信息。

## 🙏 致谢

- 感谢 [guopenglong](https://github.com/guopenglong) 提供的小米扫码登录解决方案。

## 🖼️ 截图预览

![监控大屏](效果图/监控大屏.png)
![统计数据1](效果图/统计数据1.png)
![统计数据2](效果图/统计数据2.png)
![统计数据3](效果图/统计数据3.png)
![行程管理](效果图/行程管理.png)
![行程详情](效果图/行程详情.png)
![车况历史](效果图/车况历史.png)
![充电记录](效果图/充电记录.png)
![月度用车报告](效果图/月度用车报告.png)
![车辆管理](效果图/车辆管理.png)
