# 独立账号登录配置指引

> 此邮箱、手机号、验证码方案已按最新要求取消。当前方案仅使用账号和密码，不开放注册。请改读 [PASSWORD-LOGIN.md](PASSWORD-LOGIN.md)。本文件仅保留为历史记录，不再需要注册 Supabase 或短信服务。

## 当前先做什么

Supabase 项目已验证连接，邮箱登录开关已开启，Phone 登录开关尚未开启。主账号手机号已按国际格式保存在本地配置，文档不展示完整号码。

### 先注册 Cloudflare

1. 打开 https://dash.cloudflare.com/sign-up ，使用你自己的邮箱注册。
2. 设置登录密码并完成邮件里的邮箱验证。账号密码、邮箱验证码由你自行输入，不发送到聊天中。
3. 登录后进入 Cloudflare 控制台，找到 Workers & Pages（界面名称可能调整）即可。此阶段不需要先购买域名；Worker 可以使用平台的 `workers.dev` 地址。
4. 告知开发者「Cloudflare 已注册并登录」。后续再在你的授权下创建独立数据库、配置运行时变量和部署 ERP；当前未创建、未收费、未替你绑定支付方式。

Cloudflare 官方注册说明：https://developers.cloudflare.com/fundamentals/account/create-account/ 。Worker 地址说明：https://developers.cloudflare.com/workers/configuration/routing/workers-dev/ 。

### 再接短信验证码

1. 在 Supabase 项目中打开 Authentication 的登录供应商设置，找到 Phone。单独打开开关还不等于具备发送能力，需要配置短信供应商。
2. 直接集成的供应商包括 MessageBird、Twilio、Vonage、TextLocal（社区支持）。先确认供应商支持你的中国大陆 `+86` 号码、认证码用途及实际送达，再决定开通或充值。Twilio 明确说明中国大陆短信采用尽力投递，不保证送达，不应把开通账号当作送达保证。
3. 供应商提供的发送凭据只填写到 Supabase 控制台或部署平台的 Secret，不发到聊天中，不提交到 Git。
4. 在 Supabase 保存 Phone 配置、设置发送限额后，再由你确认发送一条实际验证码测试；完成测试前，不声称手机号登录已经可用。
5. 如果希望使用没有原生列出的短信服务商，Supabase 提供 Send SMS Hook 接入方式，需要额外开发并验证签名。不要把国内短信服务商的密钥直接填到另一个供应商的配置栏中。

官方资料：https://supabase.com/docs/guides/auth/phone-login 、https://www.twilio.com/en-us/guidelines/cn/sms 、https://supabase.com/docs/guides/auth/auth-hooks/send-sms-hook 。

此分支 `codex/independent-login` 为独立部署准备。现有 `chatgpt.site` 网站仍保留线上版本及其 ChatGPT 门禁；本分支尚未部署到该网站。独立登录不能通过改登录页面来绕过托管平台的门禁，需部署到自己的 Cloudflare Worker / 域名。

## 登录规则

- 昵称：账号显示名称，可修改，不能仅凭昵称登录。
- 登录标识：邮箱或手机号；手机号采用国际格式，例如中国大陆 `+86` 加手机号。
- 验证码登录：由 Supabase 验证；只有主账号及已开通、启用的子账号可以申请验证码。界面不会暴露验证码。
- 密码登录：密码由 Supabase 管理，ERP 不保存明文密码。首次可先使用验证码登录，再在「昵称 / 密码」中设置密码。
- 业务数据和权限继续按 ERP 的账号 ID 隔离。验证了手机号或邮箱，不等于获得主账号权限。

## 1. 创建 Supabase 项目

请在 https://supabase.com/dashboard 使用你自己的账号创建项目。选择合适区域，保留项目所有权。登录密码、数据库密码及 service_role / secret key 不要发送到聊天中。

在项目的 API 设置找到：

- Project URL，如 `https://项目编号.supabase.co`
- publishable key（或 legacy anon key）。这是本项目接入所需的公开项目标识，**不是 service_role 密钥**。

可以把这两个公开配置提供给开发者；敏感密钥只在服务商控制台或部署平台的 Secret 中配置。

## 2. 配置真实验证码发送

邮箱：启用 Email 身份验证，配置自己的 SMTP 发送服务，并将登录邮件模板改为发送验证码，模板正文含 `{{ .Token }}`。配置邮件发送限额、验证码有效期和适当的验证码长度。生产使用前测试收件、退信与垃圾邮箱。

手机：启用 Phone 身份验证，按 Supabase 控制台支持的渠道连接短信服务商，完成服务商账户、签名/模板及目标国家地区配置；短信可能产生费用，开通前由账号所有者确认。中国大陆号码需特别核对当地发送合规及服务商覆盖范围。

本系统有服务器限流，仍需在身份服务中设置请求限制和反滥用保护。密码和验证码不应写入日志。不要为测试关闭验证或使用固定验证码。

参考：https://supabase.com/docs/guides/auth/auth-email-passwordless 和 https://supabase.com/docs/guides/auth/phone-login 。

## 3. 准备独立部署环境

需要你自己的 Cloudflare 账号（也可以再绑定自己的域名），以及独立的 D1 数据库。开发者可在你授权后协助部署；无需把 Cloudflare 登录密码发到聊天中。

运行时配置如下。不要将项目 key 写入前端文件或提交到 Git：

```
ERP_AUTH_MODE=independent
ERP_OWNER_LOGIN=你的主账号邮箱或国际格式手机号
SUPABASE_URL=你的项目 URL
SUPABASE_PUBLIC_KEY=你的 publishable 或 anon key
```

部署时保留 `DB` 数据库绑定；应用 `drizzle/` 下的全部 SQL 迁移，构建生产 Worker，并在自有 Worker 配置中填入真实数据库 ID。现有 Sites 自动生成配置中的占位数据库 ID 不能直接用于独立生产部署。

上线必须使用 HTTPS。登录会话使用 HttpOnly、SameSite Cookie，HTTPS 下启用 Secure。ERP 每次请求仍验证业务账号权限；登录服务的用户资料字段不能提升角色。

## 4. 迁移与验收

切换前由主账号分别导出需要保留的账号业务备份。在独立站建立对应子账号后，按账号逐份导入；核对库存、发票、装箱表和已发货状态。不要把多个子账号的备份合并成一个账号的数据。

先验收主账号邮箱验证码、邮箱密码、手机号验证码、手机号密码和退出登录，再用两个子账号验证相互不能访问数据。确认真实验证码送达、限流、账号停用、会话过期刷新和密码设置后，再把独立站交给员工使用。

项目地址及公开 key 已接入本机被 Git 忽略的 `.dev.vars`；主账号登录标识也保存在该文件中，不提交个人联系方式和项目配置到仓库。

本次读取真实项目 `/auth/v1/settings` 检查成功（HTTP 200）：邮箱登录已开启，手机号登录尚未开启。公开接口不能确认 SMTP、短信供应商或实际送达情况，本次没有发送验证码。

下一步请在 Supabase 的 Authentication 登录供应商设置中启用 Phone，并配置短信发送渠道。然后准备自有 Cloudflare 账号和独立 D1 数据库部署。项目 publishable key 不具有管理配置、开启供应商或部署网站的权限。

接口、数据库限流和模拟身份服务测试已完成；真实邮件/短信送达、真实身份验证端到端测试及独立域名上线仍待上述配置完成。可用 `node scripts/check-auth-project.mjs` 重新读取项目设置，此命令不会发送验证码或输出项目 key。
