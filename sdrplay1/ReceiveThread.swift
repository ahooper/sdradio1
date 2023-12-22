//
//  ReceiveThread.swift
//  sdrplay1
//
//  Created by Andy Hooper on 2023-02-02.
//

import sdrlib
import Foundation.NSThread

protocol ReceiveThreadProtocol: AnyObject {
    // Thread methods
    func start()
    func cancel()
    // Radio methods
    func setFrequency(_ frequency:Double)
    func setDemodulator(_ key:String)
    func startReceive()
    func stopReceive()
    var spectrum: SpectrumData? { get }
    func printTimes()
    func getAntennas()-> [String]
    func set(antenna:String)
    func getGains()-> [Int]
    func set(gain:Int)
}

/// Mock receive thread used for UI preview and unit testing
class MockReceiveThread: ReceiveThreadProtocol {
    let mockSource: Oscillator<ComplexSamples>
    let spectrum: SpectrumData?
    init() {
        mockSource = Oscillator<ComplexSamples>(signalHz: 1, sampleHz: 5)
        spectrum = SpectrumData(source: mockSource, fftLength: 16)
    }
    func start() {
        print("MockReceiveThread", "start")
    }
    func cancel() {
        print("MockReceiveThread", "cancel")
    }
    func setFrequency(_ frequency: Double) {
        print("MockReceiveThread", "setFrequency", frequency)
    }
    func setDemodulator(_ key: String) {
        print("MockReceiveThread", "setDemodulator", key)
    }
    func startReceive() {
        print("MockReceiveThread", "startReceive")
    }
    func stopReceive() {
        print("MockReceiveThread", "stopReceive")
    }
    func printTimes() {}
    func getAntennas()-> [String] {
        ["Antenna 1","Antenna 2","Antenna 3"]
    }
    func set(antenna: String) {
        print("MockReceiveThread", "set(antenna:)", antenna)
    }
    func getGains()-> [Int] {
        [0, -10, -20, -30, -40, -50, -60, -70, -80]
    }
    func set(gain: Int) {
        print("MockReceiveThread", "set(gain:)", gain)
    }
}

class ReceiveThread: Thread, ReceiveThreadProtocol {
    let sdr: SDRplay
    let audioOut: AudioOutput
    let spectrum: SpectrumData?
    static let demodulators =
                ["AM": AMDemodulator.self,
                 "FM": FMDemodulator.self,
                 "No demod.": AudioDemodulator.self]
    var demodulator: AudioDemodulator

    override init() {
        sdr = SDRplay()
        sdr.setOption(SDRplay.OptRFNotch, SDRplay.Opt_Disable)
        sdr.setOption(SDRplay.OptAntenna, SDRplay.OptAntenna_A)
        sdr.setOption(SDRplay.OptRFGainReduction, 40)
        sdr.setOption(SDRplay.OptBandwidth, SDRplay.OptBandwidth_1_536)
        //sdr.setOption(SDRplay.OptDebug, SDRplay.Opt_Enable)

        audioOut = AudioOutput()
        sdr.sampleHz = audioOut.sampleFrequency() * 50 // 2.4 MHz
//        sdr.sampleHz = 6000000
//        sdr.setOption(SDRplay.OptBandwidth, SDRplay.OptBandwidth_1_536)
//        sdr.setOption(SDRplay.OptIFType, SDRplay.OptIF_1_620)
//        print("Low IF fs", sdr.sampleFrequency())

        demodulator = FMDemodulator(sdr, audioOut)
        
        spectrum = SpectrumData(source: sdr, fftLength: 1024)
        
        super.init()
        /*Thread*/name = "ReceiveThread"
    }
    
    override func main() {
        let audioPeriod = audioOut.getFramePeriod(),
            sdrBufferSize = Int(audioPeriod * sdr.sampleHz)
        print("ReceiveThread", "audioPeriod", Float(audioPeriod), "sdrBufferSize", sdrBufferSize)
        
        set_realtime(audioPeriod)
        self.qualityOfService = .userInteractive
        // https://lapcatsoftware.com/articles/prevent-app-nap.html
        // http://arsenkin.com/Disable-app-nap.html
        // https://developer.apple.com/library/archive/documentation/Performance/Conceptual/power_efficiency_guidelines_osx/PrioritizeWorkAtTheAppLevel.html
        let activityToken = ProcessInfo.processInfo.beginActivity(
                                options: [.userInitiated,.latencyCritical],
                                reason: "Real time signal")

        sdr.receiveLoop(sdrBufferSize)
        
        ProcessInfo.processInfo.endActivity(activityToken)
    }

    func setFrequency(_ frequency: Double) {
        print("ReceiveThread", "setFrequency", frequency)
        sdr.tuneHz = frequency
        spectrum?.centreHz = frequency
    }
    
    func setDemodulator(_ key: String) {
        print("ReceiveThread", "setDemodulator", key)
//        stopReceive()
        if demodulator.head != nil { sdr.disconnect(sink: demodulator.head!) }
        audioOut.disconnect()
        if let demod = Self.demodulators[key] {
            demodulator = demod.init(sdr, audioOut)
        }
    }
    
    func startReceive() {
        print("ReceiveThread", "startReceive")
        sdr.setOption(SDRplay.OptDebug, SDRplay.Opt_Enable)
        sdr.startReceive()
        sdr.setOption(SDRplay.OptDebug, SDRplay.Opt_Disable)
        audioOut.resume()
    }
    
    func stopReceive() {
        print("ReceiveThread", "stopReceive")
        audioOut.stop()
        sdr.stopReceive()
    }
    
    override func cancel() {
        stopReceive()
        super.cancel()
    }
    
    func printTimes() {
    }
    
    func getAntennas()-> [String] {
        sdr.getAntennas()
    }
    
    func set(antenna: String) {
        sdr.setOption(SDRplay.OptAntenna, antenna)
    }
    
    func getGains()-> [Int] {
        [0, -5, -10, -15, -20, -25, -30, -35, -40, -45, -50, -55, -60, -65, -70, -75, -80] // TODO:
    }
    
    func set(gain: Int) {
        sdr.setOption(SDRplay.OptRFGainReduction, -gain)
    }
}
