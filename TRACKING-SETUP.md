# 物流自动查询启用步骤

系统已接入 AfterShip Tracking API（2026-07）。服务端密钥不进入业务数据、浏览器或备份。目前生产环境尚未提供授权，所以接口会明确返回“未启用”。

1. 在 AfterShip 开通包含 Tracking API 权限的服务，按官方说明在 Settings → API keys 创建密钥：https://support.aftership.com/en/tracking/articles/15441939 。是否需要购买以及费用以服务商实际页面为准。
2. 在 AfterShip 添加要查询的真实运单。ERP 运单号必须与服务商记录一致；同号多个物流商时先在服务商核对，ERP 不自动选取不确定记录。
3. 在项目目录运行下面命令，并在终端的隐藏输入提示中粘贴密钥。不要把密钥写到聊天、商品备注、Git 或静态网页：

   ```powershell
   node --import ./scripts/sites-env.mjs ./node_modules/wrangler/bin/wrangler.js secret put AFTERSHIP_API_KEY --config .sites-runtime/deploy/wrangler.json
   ```

4. 打开 ERP → 业务中心 → 自动物流查询，确认“已连接”，选已有运单检查服务商轨迹。密钥是否有效及服务商套餐权限需真实请求验收。

自动刷新在查询面板打开且页面可见时每5分钟执行，每批最多10票，轮换处理；不是网站关闭后的后台定时任务。每账号每分钟限10次。原始服务商轨迹与实际签收数量独立，服务商返回 Delivered 不会擅自更改货品件数或登记仓库签收。

官方接口文档：https://www.aftership.com/docs/tracking/jh865r66gc6hi-get-trackings 。未购买、未授权、未登记运单或外部网络故障时，系统会显示原因，不生成模拟轨迹。
