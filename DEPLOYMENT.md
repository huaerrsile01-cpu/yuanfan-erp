# 独立账号密码版部署记录

当前版本：`08caff0d-1678-4abf-bd72-fbf6345d4439`，财务缺项补齐及物流查询入口已发布，详见 COMPLETE-RELEASE.md 和 TRACKING-SETUP.md。本次无需新增数据库表。

最新更新：第一批及第二批版本 `3d7488b8-6e50-4fcf-a725-52f93f2743ec` 已上线，迁移0003已应用，详情见 RELEASE-20261104.md。

日期：2026-11-04。

- 新地址：https://yuanfan-erp.yuanfan-trade.workers.dev/login
- Worker：`yuanfan-erp`；部署版本：`9c3e0f2b-56a8-45a6-9100-7e37a1d35313`。
- 运行模式：`ERP_AUTH_MODE=password`。没有注册、验证码或 Supabase 依赖。
- 独立 D1 数据库：`yuanfan-erp`，APAC。已应用 0000、0001、0002 迁移及首次管理员初始化 SQL。
- 两个管理员的密码在线验证及 ERP 主账号身份检查通过，测试会话已退出。验证脚本不输出密码。
- 主用 `owner` 与备用 `owner-backup` 的密码位于本机被 Git 忽略的 `.sites-runtime/password-setup/管理员登录信息.txt`，不得上传到静态网站或提交代码。
- 旧 `chatgpt.site` 网站及数据保持不变。新数据库不包含旧业务记录，迁移前须在旧站导出备份，导入后按账号核对库存、单据及已发货状态。
- 本机终端直连 workers.dev 曾出现连接超时；沿用已存在的系统代理后在线身份验证成功。自动浏览器页面检查超时，因此不声称已通过线上视觉验收。

独立部署配置保存在本机 `.sites-runtime/deploy/wrangler.json`。未来发布使用该配置，避免误用 Sites 托管配置重新加入 ChatGPT 门禁。
