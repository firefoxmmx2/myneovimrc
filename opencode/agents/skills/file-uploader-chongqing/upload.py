import asyncio
import sys
from playwright.async_api import async_playwright

URL = "https://58.144.217.62:17300/files/"
USERNAME = "oper"
PASSWORD = "Aisino@20230816"

async def upload_files(file_paths):
    async with async_playwright() as pw:
        browser = await pw.chromium.launch(headless=True, args=["--ignore-certificate-errors"])
        page = await browser.new_page()

        print("1/5 打开页面...")
        await page.goto(URL, wait_until="networkidle")

        print("2/5 登录...")
        await page.fill('input[placeholder="用户名"]', USERNAME)
        await page.fill('input[placeholder="密码"]', PASSWORD)
        await page.click('button:has-text("登录")')
        await page.wait_for_load_state("networkidle")

        print("3/5 进入上传页面...")
        await page.click('text=上传')
        await page.wait_for_load_state("networkidle")

        print("4/5 选择文件...")
        file_input = page.locator('input[type="file"]')
        await file_input.set_input_files(file_paths)
        print(f"   已选择 {len(file_paths)} 个文件")

        print("5/5 提交上传...")
        await page.click('button:has-text("上传到服务器")')
        await page.wait_for_timeout(10000)

        await page.screenshot(path="/tmp/upload_result.png")
        print("上传完成！截图: /tmp/upload_result.png")
        await browser.close()

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("用法: python3 upload.py <file1> [file2] ...")
        sys.exit(1)
    asyncio.run(upload_files(sys.argv[1:]))
