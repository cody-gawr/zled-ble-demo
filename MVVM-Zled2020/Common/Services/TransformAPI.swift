//
//  TransformAPI.swift
//  MVVM-Zled2020
//
//  Created by hope on 8/15/20.
//  Copyright © 2020 Ace. All rights reserved.
//

import Foundation

enum TransformAPI {
    
    static let defaultLeds: [[Int]] = Array(repeating: Array(repeating: 0, count: Constant.Values.countsOfLed), count: Constant.Values.countsOfDefaultTab)
    
    static let defaultCtrlBits: [Int] = [1, 1, 0, 1, 1]
    
    static func build(leds scripts: [PresetDTO]) -> (ctrls: [[[Int]]], leds: [[[[Int]]]], nameSet: [[String]]) {
        var leds: [[[[Int]]]] = Array(repeating: [], count: Constant.Values.numbersOfTab - 1)
        var ctrls: [[[Int]]] = Array(repeating: [], count: Constant.Values.numbersOfTab - 1)
        var playbackNames: [[String]] = Array(repeating: [], count: Constant.Values.numbersOfTab - 1)
        let tuplePresentName = transform(scripts: scripts)
        let presets: [[String]] = tuplePresentName.presets.transposed()
        let nameSets: [[String]] = tuplePresentName.names.transposed()
        for i in 0..<presets.count {
            var tempPlayback: [[[Int]]] = []
            var tempControlBits: [[Int]] = []
            presets[i].forEach { playback in
                if playback != Constant.Strings.empty {
                    var tempFrames = [[Int]]()
                    let strFrames: [String] = playback.components(separatedBy: Constant.Strings.separator)
                    Array(zip(strFrames.indices, strFrames)).forEach { (index, frame) in
                        if index == 0 && frame.count == Constant.Values.countsOfLed / 4 + Constant.Values.numbersOfTab {
                            let boundIndex = frame.index(frame.startIndex, offsetBy: Constant.Values.numbersOfTab)
                            tempControlBits.append(getControlBits(ctrlBits: String(frame[..<boundIndex])))
                            tempFrames.append(build(frame: String(frame[boundIndex...])))
                        } else {
                            tempFrames.append(build(frame: frame))
                        }
                    }
                    tempPlayback.append(tempFrames)
                }
            }
            if !tempPlayback.isEmpty && !tempControlBits.isEmpty {
                leds[i] = tempPlayback
                ctrls[i] = tempControlBits
            }
        }
        for i in 0..<nameSets.count {
            var tempPlaybackName = [String]()
            nameSets[i].forEach { name in
                if name != Constant.Strings.empty {
                    tempPlaybackName.append(name)
                }
            }
            playbackNames[i] = tempPlaybackName
        }
        ctrls = appendLastControlBits(ctrls)
        return (ctrls: ctrls, leds: leds, nameSet: playbackNames)
    }
    
    static func build(frame: String) -> [Int] {
        var ledsOfFrame: [Int] = []
        frame.forEach { char in
            String(char).hexValue.binaryValues.forEach {
                ledsOfFrame.append($0)
            }
        }
        
        return ledsOfFrame
    }
    
    static func build(for frame: [Int]) -> String {
        let reversedFrame: [Int] = frame.reversed()
        var hexFrame = ""
        for i in stride(from: 0, to: reversedFrame.count / 4, by: 1) {
            let fromIndex = 4 * i
            let toIndex = 4 * (i + 1)
            var hex = ""
            for j in fromIndex..<toIndex {
                hex += String(reversedFrame[j])
            }
            let number = Int(hex, radix: 2) ?? 0
            hexFrame.append(number.hexString)
        }
        
        return hexFrame
    }
    
    static func convert(ctrlBits: [Int], frames: [[Int]]) -> [String] {
        var result = [String]()
        var ctrlBitsString = convert(bits: ctrlBits)
        for index in frames.indices {
            let frameString = build(for: frames[index])
            var tempFrame = ""
            if index == 0 {
                ctrlBitsString.append(frameString)
                tempFrame = ctrlBitsString
            } else {
                tempFrame = frameString
            }
            if index == frames.endIndex - 1 {
                tempFrame.append(Constant.Values.EOF_LastFrame)
            } else {
                tempFrame.append(Constant.Values.EOF_Frame)
            }
            result.append(tempFrame)
        }
        
        return result
    }
    
    static func convert(bits: [Int]) -> String {
        var strCtrlBits = ""
        bits.forEach {
            strCtrlBits += $0.hexString
        }
        return strCtrlBits
    }
    
    static func convert(decimal: [Int]) -> String {
        var strCtrlBits = ""
        decimal.forEach {
            strCtrlBits += String($0)
        }
        return strCtrlBits
    }
    
    static func convert(decimal: String) -> [Int] {
        var result = [Int]()
        decimal.forEach {
            result.append(Int(String($0)) ?? 0)
        }
        return result
    }
    
    static func convert(frames: String) -> [[Int]] {
        var result = [[Int]]()
        frames.components(separatedBy: Constant.Strings.separator).forEach {
            result.append(convert(decimal: $0))
        }
        return result
    }
    
    static func convert(frames: [[Int]]) -> String {
        var strLeds = ""
        Array(zip(frames.indices, frames)).forEach { (idx, frame) in
            strLeds += convert(decimal: frame)
            if idx < frames.endIndex - 1 {
                strLeds += Constant.Strings.separator
            }
        }
        return strLeds
    }
    
    static func convertForLocal(ctrlBits: [Int], leds: [[Int]]) -> (ctrlBits: String, leds: String) {
        let strCtrlBits: String = convert(bits: ctrlBits)
        let strLeds = convert(frames: leds)
        return (ctrlBits: strCtrlBits, leds: strLeds)
    }
    
    private static func transform(scripts: [PresetDTO]) -> (presets: [[String]], names: [[String]]) {
        var presetsT: [[String]] = []
        var namesT: [[String]] = []
        scripts.forEach {
            var row = [String]()
            var rowName = [String]()
            $0.presetSet.forEach { playback in
                row.append(playback)
            }
            $0.typeNameSet.forEach {
                rowName.append($0)
            }
            presetsT.append(row)
            namesT.append(rowName)
        }
        return (presets: presetsT, names: namesT)
    }
    
    private static func getControlBits(ctrlBits: String) -> [Int] {
        var ctrls = [Int]()
        ctrlBits.forEach { ctrls.append(String($0).hexValue) }
        
        return ctrls
    }
    
    static func appendLastControlBits(_ backBone: [[[Int]]]) -> [[[Int]]] {
        var result = backBone
        result.append([[1, Constant.Values.numbersOfTab, 1, 1, 1, 1]])
        
        return result
    }
}

extension TransformAPI {
    
    static func convert(leds: [[[[Int]]]]) -> String {
        var result = ""
        for tab in leds.indices {
            for playbackNo in leds[tab].indices {
                result += convert(frames: leds[tab][playbackNo])
                if playbackNo < leds[tab].endIndex - 1 {
                    result += Constant.Strings.playbackSeparator
                }
            }
            if tab < leds.endIndex - 1 {
                result += Constant.Strings.tabSeparator
            }
        }
        return result
    }
    
    static func convert(ctrls: [[[Int]]]) -> String {
        var result = ""
        for tab in ctrls.indices {
            for playbackNo in ctrls[tab].indices {
                result += convert(decimal: ctrls[tab][playbackNo])
                if playbackNo < ctrls[tab].endIndex - 1 {
                    result += Constant.Strings.playbackSeparator
                }
            }
            if tab < ctrls.endIndex - 1 {
                result += Constant.Strings.tabSeparator
            }
        }
        return result
    }
    
    static func convert(names: [[String]]) -> String {
        var result = ""
        for tab in names.indices {
            for playbackNo in names[tab].indices {
                result += names[tab][playbackNo]
                if playbackNo < names[tab].endIndex - 1 {
                    result += Constant.Strings.playbackSeparator
                }
            }
            if tab < names.endIndex - 1 {
                result += Constant.Strings.tabSeparator
            }
        }
        return result
    }
    
    static func getLeds(from leds: String) -> [[[[Int]]]] {
        var result: [[[[Int]]]] = []
        leds.components(separatedBy: Constant.Strings.tabSeparator).forEach {
            var tab = [[[Int]]]()
            $0.components(separatedBy: Constant.Strings.playbackSeparator).forEach {
                tab.append(self.convert(frames: $0))
            }
            result.append(tab)
        }
        return result
    }
    
    static func getControls(from ctrls: String) -> [[[Int]]] {
        var result = [[[Int]]]()
        ctrls.components(separatedBy: Constant.Strings.tabSeparator).forEach {
            var tab = [[Int]]()
            $0.components(separatedBy: Constant.Strings.playbackSeparator).forEach {
                tab.append(self.convert(decimal: $0))
            }
            result.append(tab)
        }
        return result
    }
    
    static func getNames(from names: String) -> [[String]] {
        var result = [[String]]()
        names.components(separatedBy: Constant.Strings.tabSeparator).forEach {
            var tab = [String]()
            $0.components(separatedBy: Constant.Strings.playbackSeparator).forEach {
                tab.append($0)
            }
            result.append(tab)
        }
        return result
    }
}
