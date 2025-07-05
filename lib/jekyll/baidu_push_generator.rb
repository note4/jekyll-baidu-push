require 'net/http'
require 'uri'

module Jekyll
  class BaiduPushGenerator < Generator
    priority :lowest

    def generate(site)
      # 读取配置
      config = site.config['baidu_push'] || {}

      # 检查是否启用
      if config.key?('enabled') && !config['enabled']
        puts "[baidu_push] 插件未启用，跳过 Baidu Push。" if site.config['verbose']
        return
      end
      
      push_type = config['type'] || 'all'  # 默认推送所有内容
      limit = config['limit'] || 10  # 默认推送 10 个
      token = config['token'] || ""  # 获取 token
      base_url = site.config['url'].chomp('/')  # 使用 Jekyll 配置的 URL，去掉末尾的 /

      # 获取排除的路径和文件类型
      exclude_paths = config['exclude_paths'] || []  # 需要排除的路径
      exclude_types = config['exclude_types'] || []  # 需要排除的文件类型（不带 .）

      # 拼接 API URL
      api_url = "http://data.zz.baidu.com/urls?site=#{base_url}&token=#{token}"

      # 打印拼接的 API URL 方便调试
      puts "拼接的 API URL: #{api_url}"

      # 选择推送的内容类型
      items = case push_type
              when 'pages' then site.pages
              when 'posts' then site.posts.docs
              else site.pages + site.posts.docs  # all
              end

      # 过滤仅包含 Page 或 Post
      filtered_items = items.select { |item| item.is_a?(Jekyll::Page) || item.is_a?(Jekyll::Document) }

        # 排除不需要推送的路径
      filtered_items.reject! do |item|
        normalized_url = item.url.sub(/\/index\.html$/, '/')  # 统一 URL 格式
        exclude_paths.any? { |path| normalized_url == path || normalized_url.start_with?(path + '/') }
      end

      # 排除指定文件类型
      filtered_items.reject! do |item|
        ext = File.extname(item.path).delete('.').downcase  # 获取扩展名（无 `.`）
        exclude_types.include?(ext)
      end

      # **排除 `jekyll-redirect-from` 插件生成的重定向页面**
      filtered_items.reject! do |item|
        item.data.key?('redirect_from') || item.data.key?('redirect_to')
      end

      # **排除首页**
      filtered_items.reject! do |item|
        normalized_url = item.url.sub(/\/index\.html$/, '/')  # 统一 URL 格式
        normalized_url == '/'
      end

      # 按文件修改时间排序（最近修改的优先）
      urls = filtered_items
             .sort_by { |item| File.mtime(item.path) rescue Time.at(0) }
             .reverse
             .take(limit)  # 只取最近修改的 limit 个

      # 生成待推送的 URL
      batch = urls.map { |item| "#{base_url}#{item.url}" }

      # 打印待提交的 URLs 方便调试
      puts "待提交的 URLs: #{batch.join("\n")}"

      # 提交到百度，但不会影响构建
      push_to_baidu(api_url, batch) unless batch.empty?
    rescue => e
      puts "生成百度推送时发生错误: #{e.message}"
      puts e.backtrace.join("\n")
    end

    def push_to_baidu(api_url, urls)
      uri = URI.parse(api_url)
      request = Net::HTTP::Post.new(uri)
      request['Content-Type'] = 'text/plain'
      request.body = urls.join("\n")

      begin
        response = Net::HTTP.start(uri.host, uri.port) { |http| http.request(request) }
        puts "百度推送结果: #{response.body}"
      rescue => e
        puts "百度推送失败: #{e.message}"
        puts "构建继续进行..."
      end
    end
  end
end
