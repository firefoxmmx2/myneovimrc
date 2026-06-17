---
name: file-uploader-chongqing
description: 如何使用 Playwright (Python) 上传文件到重庆文件传输服务器（58.144.217.62:17300）。当用户需要上传文件到重庆通道服务器、重庆外到内文件传输、或上传到 https://58.144.217.62:17300/files/ 时使用此技能。适用于上传 JAR 包、Elasticsearch 配置、Logstash 配置、索引模板等运维文件。
---

# 重庆文件上传器

使用 Playwright (Python) 自动化上传文件到重庆文件传输服务器。

## 前置条件

- Python 3 + Playwright 已安装 (`pip3 install playwright --break-system-packages && playwright install chromium`)
- 目标服务器地址：`https://58.144.217.62:17300/files/`
- 登录凭据：用户名 `oper`，密码 `Cshlw_61608`

## 上传流程

### 方式一：使用上传脚本（推荐）

该技能目录下提供了 `upload.py` 脚本，支持上传一个或多个文件：

```bash
python3 /home/firefoxmmx/.agents/skills/file-uploader-chongqing/upload.py \
  "path/to/file1.conf" \
  "path/to/file2.jar"
```

脚本会自动完成：打开页面 → 登录 → 进入上传页 → 选择文件 → 提交上传 → 截图。

### 方式二：使用 Python Playwright 代码（需要自定义逻辑时）

```python
import asyncio
from playwright.async_api import async_playwright

URL = "https://58.144.217.62:17300/files/"
USERNAME = "oper"
PASSWORD = "Cshlw_61608"

async def upload_files(file_paths):
    async with async_playwright() as pw:
        browser = await pw.chromium.launch(headless=True, args=["--ignore-certificate-errors"])
        page = await browser.new_page()

        # 1. 打开页面
        await page.goto(URL, wait_until="networkidle")

        # 2. 登录
        await page.fill('input[placeholder="用户名"]', USERNAME)
        await page.fill('input[placeholder="密码"]', PASSWORD)
        await page.click('button:has-text("登录")')
        await page.wait_for_load_state("networkidle")

        # 3. 进入上传页面
        await page.locator('text=上传').click(force=True)
        await page.wait_for_load_state("networkidle")
        await page.wait_for_timeout(2000)

        # 4. 选择文件
        await page.locator('input[type="file"]').set_input_files(file_paths)

        # 5. 点击上传
        await page.click('button:has-text("上传到服务器")')
        await page.wait_for_timeout(10000)

        # 6. 截图验证
        await page.screenshot(path="/tmp/upload_result.png")
        print("上传完成！")

        await browser.close()

asyncio.run(upload_files(["path/to/file1.conf", "path/to/file2.jar"]))
```

## 上传单个文件的完整示例

```python
import asyncio
from playwright.async_api import async_playwright

async def main():
    async with async_playwright() as pw:
        browser = await pw.chromium.launch(headless=True, args=["--ignore-certificate-errors"])
        page = await browser.new_page()

        await page.goto("https://58.144.217.62:17300/files/", wait_until="networkidle")
        await page.fill('input[placeholder="用户名"]', "oper")
        await page.fill('input[placeholder="密码"]', "Cshlw_61608")
        await page.click('button:has-text("登录")')
        await page.wait_for_load_state("networkidle")

        await page.locator('text=上传').click(force=True)
        await page.wait_for_load_state("networkidle")
        await page.wait_for_timeout(2000)

        await page.locator('input[type="file"]').set_input_files(["target/hycssjkafka-0.4.0-SNAPSHOT.jar"])
        await page.click('button:has-text("上传到服务器")')
        await page.wait_for_timeout(60000)  # 大文件需要更长时间

        await browser.close()

asyncio.run(main())
```

## 注意事项

1. **HTTPS 证书**：服务器使用自签名证书，必须添加 `--ignore-certificate-errors` 参数
2. **大文件上传**：JAR 包等大文件（284MB）需要更长的等待时间（`wait_for_timeout(60000)` 以上），脚本会自动处理分片上传
3. **文件列表**：最多一次上传多个文件，用 `set_input_files` 传入列表即可
4. **截图验证**：脚本会自动截图到 `/tmp/upload_result.png` 用于确认
6. **"上传"按钮为 `<LI>` 元素**：`text=上传` 匹配的是 `<LI>上传</LI>`，Playwright 默认认为不可点击，必须加 `force=True`。脚本中已处理。
7. **登录后延迟**：登录成功后需 `wait_for_timeout(2000)` 等待页面完全渲染，否则点不到"上传"的 `<LI>` 元素。

## 故障排查

### 无头浏览器无法启动
- 确认 Chromium 已安装: `playwright install chromium`

### 上传后未成功
- 检查 `/tmp/upload_result.png` 截图确认页面状态
- 适当增加 `wait_for_timeout` 时间

### 页面元素未找到
- 确认服务器地址和端口可达
- 确认登录凭据有效
- `<LI>` 元素的"上传"按钮若点不到，在原有 `click()` 上加 `force=True` 参数
