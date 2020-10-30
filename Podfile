# Uncomment the next line to define a global platform for your project
# platform :ios, '13.2'
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '13.2'
use_frameworks!

def shared_pods
	pod 'RxSwift', '~> 5'
  pod 'RxCocoa', '~> 5'
  pod 'RealmSwift'
end

def rx_bluetooth_kit
  pod 'RxBluetoothKit', '~> 5.0'
end

def notification_banner
  pod 'SwiftMessages'
  pod 'Toast-Swift', '~> 5.0.1'
end

target 'MVVM-Zled2020' do
  # Comment the next line if you don't want to use dynamic frameworks
  shared_pods
  rx_bluetooth_kit
  notification_banner
  # Pods for MvvmZled2020
  
end
