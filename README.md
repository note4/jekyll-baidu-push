# jekyll-baidu-push

通过百度搜索引擎推送 API ，在云端构建和部署的时候会将你的 Jekyll 站点链接推送给百度索引。

- [Gitlab 构建并部署 pages 截图](https://github.com/note4/jekyll-baidu-push/wiki)

## 安装教程

<https://rubygems.org/gems/jekyll-baidu-push>


## 配置方法

修改项目根目录下 _config.yml 文件

```yml
plugins:
  - jekyll-baidu-push


baidu_push:
  # true 启用插件 或 false （禁用插件）
  enabled: true   
  type: "pages"
  limit: 10
  token: "你的token"
  exclude_types:
    - pdf
  exclude_paths:
    - /404.html
```


### 配置示例

**百度推送 Token 必须换成你自己账号的，并在该账号有添加对应站点，否则无法推送**

```yml
plugins:
  - jekyll-baidu-push


# jekyll-baidu-push plugins guide
baidu_push:
  # true 启用插件 或 false （禁用插件）
  enabled: true   
  # 可选: "posts" | "pages" | "all"
  type: "pages" 
  # 只推送最近修改的 10 个页面
  limit: 10     
  # 你的百度推送 Token
  token: "2hqSLP4JcDtFF555" 
  #   排除的文件类型
  exclude_types:
    - pdf
    - txt
    - xml
    - css
    - scss
    - js
    - json
  #   排除的文件
  exclude_paths:
    - /baidu_verify_codeva-n2azB6oAAA.html
    - /google009f7cd40c002555.html
    - /404.html
```

## 避免本地构建影响预览速度

在根目录新增一个 `_config_local.yml` 文件，内容如下

```yml
# plugins
baidu_push:
  enabled: false
  # true 开启推送， false  不执行推送
```

本地命令运行服务使用以下命令

```bash
bundle exec jekyll serve --livereload --config _config.yml,_config_local.yml
```
