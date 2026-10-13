# My Life RPG · 人生冒险日志 (MVP)

响应式网页原型，面向 Android 手机和电脑浏览器。UI 采用像素冒险角色 + 现代仪表盘。无需构建步骤，`index.html` 可直接打开；云端同步需要额外配置 Supabase。

## MVP 功能
- XP、GP、等级、五维属性成长
- 主线 / 支线 / 日常任务；重要程度、紧急程度、难度、预计耗时、计划日期、截止日期、重复任务
- 日 / 周 / 月日历视图
- 未来 14 天甘特图（按日期与预计耗时显示）
- 现实奖励商店、金币兑换与兑换账本
- 任务计时器与专注记录
- 周报 / 月报、成就图鉴
- JSON 数据导出与导入
- 可选 Supabase 邮箱登录与云端同步
- PWA manifest 与基础 Service Worker 缓存

## 本地运行
1. 解压文件夹。
2. 双击 `index.html` 即可试用主要功能。浏览器会把数据保存在本地。
3. 要测试 PWA 离线缓存，请通过本地 HTTP 服务器访问（例如 VS Code Live Server，或任意静态服务器）。不需要编辑代码。

## GitHub Pages 部署
1. 登录 GitHub，创建一个新仓库，例如 `my-life-rpg`。
2. 进入仓库，点击 **Add file → Upload files**，上传本文件夹中的 `index.html`、`manifest.webmanifest`、`sw.js`、`supabase.sql` 和 `README.md`（上传文件内容，不要只上传压缩包）。
3. 提交（Commit changes）。
4. 打开 **Settings → Pages**。
5. 在 **Build and deployment** 选择 **Deploy from a branch**，分支选 `main`，目录选 `/(root)`，保存。
6. 等待 GitHub Pages 发布完成，访问页面显示的 `https://你的用户名.github.io/my-life-rpg/` 地址。
7. Android：用 Chrome 打开部署网址，菜单选择“添加到主屏幕”或“安装应用”。电脑端可直接收藏，也可在支持的浏览器中安装。

注意：GitHub 仓库如果设为 public，源代码对所有人可见；不要把私人任务数据、邮箱、密钥或备份文件上传到仓库。用户数据默认只存本机浏览器。

## 可选：配置 Supabase 云端同步
1. 在 Supabase 创建项目。免费层适合原型使用，但配额和暂停规则可能变化；请保留 JSON 备份。
2. 打开项目的 **SQL Editor**，运行 `supabase.sql` 中的 SQL，创建 `rpg_saves` 表并启用行级安全策略（RLS）。
3. 在 **Project Settings → API** 找到 Project URL 和 anon/publishable key。只使用可公开的 anon/publishable key；绝不要把 `service_role` / secret key 放进网页。
4. 在网页的 **设置 → 云端同步** 中填写 URL 和 key，点击“保存配置并连接”。
5. 填写邮箱，点击“发送登录链接”，从邮件打开链接完成登录。若登录后没有返回应用，在 Supabase **Authentication → URL Configuration** 中把部署网址加入 Site URL / Redirect URLs。
6. 点击“立即同步”。在其他设备打开同一网址，填相同 URL/key，用同一个邮箱登录，再点同步。

云端合并策略在此 MVP 中是简单的手动选择，不是复杂的实时协作：如果云端已有数据，会询问是否恢复云端；选择取消则上传当前本地数据覆盖云端。首次同步前务必导出本地 JSON 备份，避免误覆盖。

## 当前原型边界
- 日历采用任务日期展示；甘特图按预计时长换算成工作日条宽（8 小时约等于 1 天），不是专业项目管理工具。
- 重复任务在完成时生成下一期实例。
- 任务奖励在首次完成时结算；取消完成会回退该任务奖励，但若已花掉金币，金币只会回退到 0，不会产生负数。
- 云同步是手动/变更后延迟上传，不支持多设备实时协作、冲突历史或多角色账户。
- 这是本地原型，不是经过安全审计的商业产品。请定期备份。
