Pod::Spec.new do |s|
  s.name         = 'GalleryModule'
  s.version      = '1.0.0'
  s.summary      = 'Gallery Module is an gallery module that used for take an photo on their gallery'
  s.homepage     = 'https://source.gits.id/RnD/swift-ios-framework'
  s.license = { :type => 'MIT', :file => 'LICENSE' }
  s.author             = { 'GITS Indonesia' => 'ajie@gits.id' }
  s.platform     = :ios, '10.0'
  s.source       = { :git => 'https://git.gits.id/RnD/ios-dev-kit.git', :tag => s.version }
  s.source_files = 'GalleryModule/Classes', 'GalleryModule/Classes/**/*.{h,m,swift}'
  s.resource_bundles = { 'GalleryModule' => ['GalleryModule/Assets/**/*.{storyboard,xib,xcassets,json,imageset,png,bundle,ttf}']}
  s.swift_version = '5.0'
  s.dependency 'GITSFramework'
  s.dependency 'Shimmer'
  s.dependency 'TOCropViewController'
end
