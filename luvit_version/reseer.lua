--[[
  赛尔号 Luvit 游戏客户端资源服务器
  基于 test/gameres_proxy/root 参考实现
  提供 HTTP 资源服务，供浏览器加载 Flash 游戏客户端
]]

local http = require('http')
local fs = require('fs')
local path = require('path')
local process = require('process')
local uv = require('uv')

-- 配置
local CONFIG = {
  port = tonumber(os.getenv('RES_PORT')) or 32400,
  publicIP = os.getenv('PUBLIC_IP') or '127.0.0.1',
  loginPort = 1863,
  gamePort = 5000,
}

-- 脚本所在目录（luvit_version/）
local scriptPath = process.argv[1] or 'reseer.lua'
local scriptDir = path.dirname(path.normalize(scriptPath))
if scriptDir == '' or scriptDir == '.' then
  scriptDir = uv.cwd()
end

-- 客户端根目录：优先 test/gameres_proxy/root，其次 luvit_version/root
local rootPaths = {
  path.join(scriptDir, '..', 'test', 'gameres_proxy', 'root'),
  path.join(scriptDir, 'root'),
  path.join(scriptDir, '..', 'gameres_proxy', 'root'),
}

-- 解析为绝对路径
local function toAbsolute(p)
  local sep = path.getSep and path.getSep() or '/'
  local isAbs = p:match('^/') or (sep == '\\' and p:match('^%a:[\\/]'))
  if isAbs then
    return path.normalize(p)
  end
  return path.normalize(path.join(uv.cwd(), p))
end

local rootDir = nil
for _, p in ipairs(rootPaths) do
  local absPath = toAbsolute(p)
  local ok, stat = pcall(fs.statSync, absPath)
  if ok and stat then
    local isDir = (stat.type == 'directory') or (stat.isDirectory and stat:isDirectory())
    if isDir then
      rootDir = absPath
      break
    end
  end
end

if not rootDir then
  rootDir = toAbsolute(path.join(scriptDir, '..', 'test', 'gameres_proxy', 'root'))
  print(string.format('[WARN] 未找到 root 目录，使用默认: %s', rootDir))
else
  print(string.format('[INFO] 客户端根目录: %s', rootDir))
end

-- MIME 类型
local MIME = {
  html = 'text/html; charset=utf-8',
  css = 'text/css',
  js = 'application/javascript',
  xml = 'application/xml',
  swf = 'application/x-shockwave-flash',
  png = 'image/png',
  jpg = 'image/jpeg',
  jpeg = 'image/jpeg',
  gif = 'image/gif',
  txt = 'text/plain',
}

local function getMime(filePath)
  local ext = path.extname(filePath):lower():gsub('^%.', '')
  return MIME[ext] or 'application/octet-stream'
end

-- 解析 URL 路径
local function parsePath(url)
  local p = url:match('^([^?]*)')
  p = p:gsub('^/', '')
  if p == '' then
    p = 'index.html'
  end
  return p
end

-- 发送文件
local function serveFile(res, filePath, statusCode)
  statusCode = statusCode or 200
  local stat, err = fs.statSync(filePath)
  if not stat or stat.type ~= 'file' then
    res:writeHead(404, { ['Content-Type'] = 'text/plain' })
    res:finish('File not found')
    return
  end

  local ok, data = pcall(fs.readFileSync, filePath)
  if not ok or not data then
    res:writeHead(500, { ['Content-Type'] = 'text/plain' })
    res:finish('Read error: ' .. tostring(data or 'unknown'))
    return
  end

  res:writeHead(statusCode, {
    ['Content-Type'] = getMime(filePath),
    ['Content-Length'] = #data,
  })
  res:finish(data)
end

-- 处理 ip.txt
local function handleIpTxt(res)
  local txt = string.format('%s:%d', CONFIG.publicIP, CONFIG.loginPort)
  res:writeHead(200, {
    ['Content-Type'] = 'text/plain',
    ['Content-Length'] = #txt,
  })
  res:finish(txt)
  print(string.format('[ip.txt] %s', txt))
end

-- 处理 /api/set_user
local function handleSetUser(res, req)
  local url = req.url or ''
  local uid = url:match('uid=([^&]*)')
  if not uid or uid == '' then
    res:writeHead(400, { ['Content-Type'] = 'text/plain' })
    res:finish('missing uid')
    return
  end
  res:writeHead(204)
  res:finish()
  print(string.format('[set_user] uid=%s', uid))
end

-- 主请求处理
local function onRequest(req, res)
  local url = req.url or '/'
  local method = (req.method or 'GET'):upper()

  -- CORS
  res:setHeader('Access-Control-Allow-Origin', '*')
  res:setHeader('Access-Control-Allow-Methods', 'GET, POST, OPTIONS')
  res:setHeader('Access-Control-Allow-Headers', 'Content-Type, Authorization')

  if method == 'OPTIONS' then
    res:writeHead(204)
    res:finish()
    return
  end

  -- favicon 等
  if url:find('favicon%.ico') or url:find('logo%.png') then
    res:writeHead(204)
    res:finish()
    return
  end

  -- 特殊路由
  if url == '/ip.txt' or url == '/ip' then
    handleIpTxt(res)
    return
  end

  if url:find('^/api/set_user') then
    handleSetUser(res, req)
    return
  end

  local relPath = parsePath(url)

  -- SPA 路由
  if relPath == 'game' then
    relPath = 'index.html'
  end

  local filePath = path.join(rootDir, relPath)
  filePath = path.normalize(filePath)

  -- 安全检查：防止目录穿越
  local sep = path.getSep and path.getSep() or '/'
  local rootNorm = path.normalize(rootDir)
  if rootNorm:sub(-1) ~= sep then
    rootNorm = rootNorm .. sep
  end
  if filePath:sub(1, #rootNorm) ~= rootNorm then
    res:writeHead(403, { ['Content-Type'] = 'text/plain' })
    res:finish('Forbidden')
    return
  end

  local stat = fs.statSync(filePath)
  if stat then
    local isFile = (stat.type == 'file') or (stat.isFile and stat:isFile())
    local isDir = (stat.type == 'directory') or (stat.isDirectory and stat:isDirectory())
    if isFile then
      serveFile(res, filePath)
      return
    end
    if isDir then
      local idxPath = path.join(filePath, 'index.html')
      local idxStat = fs.statSync(idxPath)
      if idxStat and ((idxStat.type == 'file') or (idxStat.isFile and idxStat:isFile())) then
        serveFile(res, idxPath)
        return
      end
    end
  end

  -- 404
  res:writeHead(404, { ['Content-Type'] = 'text/plain' })
  res:finish('File not found: ' .. relPath)
end

-- 启动服务器
local server = http.createServer(onRequest)
local ok, err = pcall(function()
  server:listen(CONFIG.port, '0.0.0.0')
end)
if not ok then
  print(string.format('[ERROR] 启动失败: %s', tostring(err)))
  process.exit(1)
end

print('============================================================')
print('  赛尔号 Luvit 游戏客户端资源服务器')
print('============================================================')
print(string.format('  资源服: http://127.0.0.1:%d', CONFIG.port))
print(string.format('  登录服: %s:%d', CONFIG.publicIP, CONFIG.loginPort))
print(string.format('  游戏服: %s:%d', CONFIG.publicIP, CONFIG.gamePort))
print('------------------------------------------------------------')
print(string.format('  请在浏览器打开: http://127.0.0.1:%d', CONFIG.port))
print('  需配合 Go 游戏服务器（登录服 1863、游戏服 5000）使用')
print('============================================================')
