Pod::Spec.new do |s|
#name必须与文件名一致
s.name              = "Categorys"

#更新代码必须修改版本号
s.version           = "1.0.12"
s.summary           = "It is a Categorys used on iOS, which implement by Objective-C"
s.description       = <<-DESC
It is a Categorys used on iOS, which implement by Objective-C.
DESC
s.homepage          = "https://github.com/ChenZhenChun"
s.license           = 'MIT'
s.author            = { "ChenZhenChun" => "346891964@qq.com" }

#submodules 是否支持子模块
s.source            = { :git => "https://github.com/ChenZhenChun/Categorys.git", :tag => s.version, :submodules => true}
s.platform          = :ios, '7.0'
s.requires_arc = true

#source_files路径是相对podspec文件的路径
s.dependency 'MBProgressHUD', '0.9.2'
s.source_files = 'Categorys/*.{h,m}'
s.public_header_files = 'Categorys/*.h'
s.frameworks = 'Foundation', 'UIKit'

end
