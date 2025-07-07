Gem::Specification.new do |spec|
    spec.name                = "jekyll-baidu-push"
    spec.version             = "0.1.2"
    spec.summary          = "Jekyll plugin to push URLs to Baidu. 每次构建的时候将 Jekyll 的链接推送到百度搜索索引。"
    spec.authors            = ["note4"]
    spec.email               = ["l.zabcv@gmail.com"]
    spec.files                 = Dir["lib/**/*.rb"]
    spec.require_paths = ["lib"]
    spec.homepage      = "https://github.com/note4/jekyll-baidu-push"
    spec.license            = "MIT"
    spec.metadata        = {
      "bug_tracker_uri"   => "https://github.com/note4/jekyll-baidu-push/issues",
      "changelog_uri"     => "https://github.com/note4/jekyll-baidu-push/blob/main/CHANGELOG.md",
      "documentation_uri" => "https://github.com/note4/jekyll-baidu-push",
      "source_code_uri"   => "https://github.com/note4/jekyll-baidu-push",
      "homepage_uri"   => "https://1px.run",
    }
    spec.add_runtime_dependency "jekyll", ">= 3.0", "< 5.0"
end