Gem::Specification.new do |spec|
    spec.name                = "jekyll-baidu-push"
    spec.version             = "0.1.1"
    spec.summary          = "Jekyll plugin to push URLs to Baidu"
    spec.authors            = ["note4"]
    spec.email               = ["l.zabcv@gmail.com"]
    spec.files                 = Dir["lib/**/*.rb"]
    spec.require_paths = ["lib"]
    spec.homepage      = "https://github.com/note4/jekyll-baidu-push"
    spec.license            = "MIT"
    spec.add_runtime_dependency "jekyll", ">= 3.0", "< 5.0"
end