//
//  Constant.swift
//  MvvmZled2020
//
//  Created by hope on 7/25/20.
//  Copyright © 2020 Ace. All rights reserved.
//

import UIKit
import SwiftUI

struct Constant {
    
    struct Values {
        static let numbersOfTab = 6
        static let numberOfSlider = 5
        static let countsOfLed = 44
        static let countsOfDefaultTab = 2
        static let mainTabIndex = 1
        static let delay = 200
        static let EOF_LastFrame = String.convert(from: [59,13,10])
        static let EOF_Frame = String.convert(from: [13, 10])
        public static let KEY_LOGO_EXCHANGE_DELAY = 0.6;
        public static let KEY_LOGO_EXCHANGE_DELAY1 = 1.1;
        public static let KEY_SPLASH_DELAY = 1.5;
    }
    
    struct ImageRepo {
        
    }
    
    struct Strings {
        static let defaultDispatchQueueLabel = "com.polidea.rxbluetoothkit.timer"
        
        static let scanResultSectionTitle = "Scan Results"
        static let scanning = "Scanning..."
        static let connecting = "Connecting..."
        static let receiving = "Receiving..."
        static let scanDevice = "Scan Device"
        static let scan = "Scan"
        static let unknown = "Unknown"
        static let sequenceName = "Sequence Name"
        static let accessId = "Access ID"
        static let playback = "Playback"
        
        static let wait = "Please wait"
        static let connect = "Connect"
        static let connected = "Connected"
        static let disconnect = "Disconnect"
        static let disconnected = "Disconnected"
        
        static let success = "Success"
        static let error = "Error"
        static let warning = "Warning"
        static let empty = "empty"
        static let notice = "Notice"
        
        static let targetDeviceNamePrefix = "zled"
        static let tabSeparator = "*"
        static let playbackSeparator = "@"
        static let separator = "-"
        static var constraintName = "zled"
        static var appName = "Zled2020"
        static let assetsDirectoryName = "Assets"
        static let imageCache = "ImageCache"
        static let confirmRemove = "Do you want to remove this sequence?"
        
        struct Success {
            static let sequenceSaved = "Sequence saved successfully."
        }
        
        struct Errors {
            static let notFoundAnyDevice = "Can not find any device. Try again."
            static let unableToConnect = "Can not connect to this device."
            static let characteristicError = "Can not find any characteristic."
            static let disconnectedFromDevice = "Disconnected from this device."
            static let unableToCreateURLRequest = "Unable to create the URLRequest object"
            static let hasNoAccessToDevice = "You have no necessary permission to access."
            static let unableToSend = "Can't send the data."
        }
        
        struct Warnings {
            static let unableToRemoveFrame = "Can not remove Frame 1 or 2."
            static let sequenceNameUnableToBeNull = "The name of sequence can't be null."
            static let sameSequenceAlreadyExists = "The sequence with the same name already exists."
            static let accessIdUnableToBeNull = "The access id can't be null."
            static let noAvailableSequence = "No available sequence."
        }
    }
    
    struct FontSize {
        static let small: CGFloat = 12.0
        static let medium: CGFloat = 14.0
        static let large: CGFloat = 17.0
    }
    
    struct Color {
        static let blue = UIColor(rgb: 0x00AAE8).color
        static let smartBlue = UIColor(rgb: 0x80d4e5).color
        static let white = UIColor(rgb: 0xFFFFFF).color
        static let red = UIColor(rgb: 0xED5E68).color
        static let background = UIColor(rgb: 0x000000).color
        static let midBackground = UIColor(rgb: 0x222431).color
        static let darkBackground = UIColor(rgb:0x171a23).color
        static let green = UIColor(rgb:0x8bc341).color
        static let yellow = UIColor(rgb: 0xf8b819).color
        static let tabBackground = UIColor(rgb: 0x3326d3ff).color
        static let sliderPrimary = UIColor(rgb: 0x00AAE8).color
        static let sliderSecondary = UIColor(rgb: 0xd1d1d1).color
        static let colorGrey = UIColor(rgb: 0xCDCED1).color
        // Text Color
        static let darkerGrey = UIColor(rgb: 0xFFAAAAAA).color
        static let ligterGrey = UIColor(rgb: 0xFFDDDDD).color
        static let black = UIColor(rgb: 0xF5F5F5).color
    }
    
    struct UIColors {
        static let blue = UIColor(rgb: 0x00AAE8)
        static let smartBlue = UIColor(rgb: 0x80d4e5)
        static let white = UIColor(rgb: 0xFFFFFF)
        static let red = UIColor(rgb: 0xED5E68)
        static let background = UIColor(rgb: 0x000000)
        static let midBackground = UIColor(rgb: 0x222431)
        static let darkBackground = UIColor(rgb:0x171a23)
        static let green = UIColor(rgb:0x8bc341)
        static let yellow = UIColor(rgb: 0xf8b819)
        static let tabBackground = UIColor(rgb: 0x3326d3ff)
        static let sliderPrimary = UIColor(rgb: 0x00AAE8)
        static let sliderSecondary = UIColor(rgb: 0xd1d1d1)
        static let colorGrey = UIColor(rgb: 0xCDCED1)
        // Text Color
        static let darkerGrey = UIColor(rgb: 0xFFAAAAAA)
        static let black = UIColor(rgb: 0xFF000000)
        static let ligterGrey = UIColor(rgb: 0xF5F5F5)
    }
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int, alpha: CGFloat = 1.0) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alpha)
    }
    
    convenience init(rgb: Int) {
        if (rgb >> 24 > 0) {
            self.init(
                red: (rgb >> 24) & 0xFF,
                green: (rgb >> 16) & 0xFF,
                blue: (rgb >> 8) & 0xFF,
                alpha: CGFloat((rgb & 0xFF) / 0xFF)
            )
        }
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
    
    var color: Color {
        get {
            let rgbColours = self.cgColor.components
            return Color(red: Double(rgbColours![0]),
                         green: Double(rgbColours![1]),
                         blue: Double(rgbColours![2]))
        }
    }
}


