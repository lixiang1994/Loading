Pod::Spec.new do |s|

s.name         = "Loading"
s.version      = "1.2.1"
s.summary      = "An elegant loading view written in swift"

s.homepage     = "https://github.com/lixiang1994/Loading"

s.license      = { :type => "MIT", :file => "LICENSE" }

s.author       = { "LEE" => "18611401994@163.com" }

s.platform     = :ios, "9.0"

s.source       = { :git => "https://github.com/lixiang1994/Loading.git", :tag => s.version }

s.source_files  = "Sources/**/*.swift"

s.requires_arc = true

s.frameworks = "UIKit", "Foundation"

s.swift_version = "5.0"

s.subspec 'Privacy' do |ss|
    ss.resource_bundles = {
        s.name => 'Sources/PrivacyInfo.xcprivacy'
    }
end
end
