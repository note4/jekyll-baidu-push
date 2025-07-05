# jekyll-baidu-push
通过百度搜索引擎推送 API ，将你的 Jekyll 站点链接推送给百度索引

## 安装教程

<https://rubygems.org/gems/jekyll-baidu-push>


## 配置方法

修改项目根目录下 _config.yml 文件

```yml
plugins:
  - jekyll-baidu-push


baidu_push:
  # true 启用插件 或 false（禁用插件）
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