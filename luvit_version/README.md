# 赛尔号 Luvit 游戏客户端

基于 Luvit 实现的游戏客户端资源服务器，参考 `test/gameres_proxy/root` 结构。

## 功能

- HTTP 静态资源服务（index.html、JS、config、SWF 等）
- `ip.txt`：返回登录服地址（如 `127.0.0.1:1863`）
- `/api/set_user?uid=xxx`：同机多开时设置 Cookie
- 服务 `test/gameres_proxy/root` 下的客户端文件

## 环境要求

- [Luvit](https://luvit.io/) 2.x 或更高
- 仅使用 Luvit 内置模块，无需额外依赖

## 安装 Luvit

**Windows (PowerShell):**
```powershell
# 使用 lit 安装脚本
iex (iwr https://github.com/luvit/lit/raw/master/get-lit.ps1)
```

**Linux/macOS:**
```bash
curl -L https://github.com/luvit/lit/raw/master/get-lit.sh | sh
```

## 使用方法

1. 确保 `test/gameres_proxy/root` 目录存在（含 index.html、config、js 等）
2. 启动 Go 游戏服务器（登录服 1863、游戏服 5000）
3. 运行 Luvit 资源服：

```bash
cd luvit_version
luvit reseer.lua
```

4. 浏览器打开 `http://127.0.0.1:32400` 加载游戏

## 配置

| 环境变量 | 默认值 | 说明 |
|----------|--------|------|
| RES_PORT | 32400 | 资源服务端口 |
| PUBLIC_IP | 127.0.0.1 | 对外暴露的 IP（ip.txt 返回的登录服地址） |

示例：
```bash
RES_PORT=32400 PUBLIC_IP=127.0.0.1 luvit reseer.lua
```

## 目录结构

```
luvit_version/
├── reseer.lua    # 主入口
├── litconfig     # lit 包配置
└── README.md     # 本说明
```

客户端文件来自 `../test/gameres_proxy/root`，包括：

- index.html
- js/swfobject.js, client-emulator.js, server-config.js
- config/ServerR.xml, doorConfig.xml
- crossdomain.xml
- ip.txt

## 架构说明

本 Luvit 程序作为**资源服务器**，与 Go 游戏服务器配合：

- **Luvit 资源服** (32400)：提供 HTML/JS/config/SWF 等静态资源
- **Go 登录服** (1863)：TCP，返回游戏服地址
- **Go 游戏服** (5000)：TCP，游戏逻辑

浏览器加载 `http://127.0.0.1:32400` 后，Flash 客户端会请求 ip.txt 获取登录服地址，再连接 1863/5000 进行登录和游戏。
