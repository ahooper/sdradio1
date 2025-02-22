//
//  TestCycle.swift
//  sdrplay1
//
//  Created by Andy Hooper on 2023-02-20.
//

import sdrlib
import Foundation.NSThread

class TestCycle: Thread, ReceiveThreadProtocol {
    let sdr: SDRplay
    let AUDIO_SAMPLE_HZ = 48_000
    let spectrum: SpectrumData?
    private var activityToken: NSObjectProtocol?
    var timeReports = [TimeReport]()

    override init() {
        sdr = SDRplay()
        sdr.setOption(SDRplay.OptRFNotch, SDRplay.Opt_Disable)
        sdr.setOption(SDRplay.OptAntenna, SDRplay.OptAntenna_A)
        sdr.setOption(SDRplay.OptRFGainReduction, 60)
        sdr.setOption(SDRplay.OptBandwidth, SDRplay.OptBandwidth_1_536)

        let downSampleHz = AUDIO_SAMPLE_HZ * 10
        let downSampleIF = UpFIRDown(source:sdr,
                                     Int(downSampleHz),
                                     AUDIO_SAMPLE_HZ,
                                     15, // * 10 * 2
                                     Float(FMDemodulator.FREQUENCY_DEVIATION) / Float(downSampleHz),
                                     windowFunction:WindowFunction.blackman) // kaiser(5.0f));
        let demodulated = FMDemodulate(source:downSampleIF,
                                       modulationFactor: 0.5) //(WFM_FREQUENCY_DEVIATION / WFM_SAMPLE_HZ));
        let downSampleAF = UpFIRDown(source:demodulated,
                                     AUDIO_SAMPLE_HZ,
                                     Int(downSampleHz),
                                     15, // * 25 * 2
                                     Float(FMDemodulator.AUDIO_FILTER_HZ) / Float(AUDIO_SAMPLE_HZ),
                                     windowFunction:WindowFunction.blackman) // kaiser(5.0f));
        let deemphasis = FMDeemphasis(source: downSampleAF,
                                      tau: FMDemodulator.DEEMPHASIS_TIME)
        //let audioDC = DCRemove(source:deemphasis, 64)
        //let audioAGC = AutoGainControl(source:audioDC)
        sdr.sampleHz = Double(AUDIO_SAMPLE_HZ) * 50

        let spectrumSource:SDRplay? = nil
        spectrum = SpectrumData(source: spectrumSource, fftLength: 1024, windowFunction: WindowFunction.blackman)
        timeReports.append(sdr.sinkWaitTime)
        timeReports.append(downSampleIF.sinkWaitTime)
        timeReports.append(demodulated.sinkWaitTime)
        timeReports.append(downSampleAF.sinkWaitTime)
        //timeReports.append(deemphasis.sinkWaitTime)

        super.init()
        /*Thread*/name = "TestCycle"
        let audioPeriod = 512 / Double(AUDIO_SAMPLE_HZ)
        set_realtime(audioPeriod)
        qualityOfService = .userInteractive
    }

    // Thread method forwarding
    override func start() {
        super.start()
    }
    override func cancel() {
        super.cancel()
    }

    func printTimes() {
        timeReports.forEach { tr in
            tr.printAccumulated(reset: true)
        }
    }
    
    override func main() {
        if sdr.devices.isEmpty {
            print("TestCycle no devices")
            return
        }
        let audioPeriod = 512 / Double(AUDIO_SAMPLE_HZ),
            processSize = Int(audioPeriod * sdr.sampleFrequency()),
            bufferSize = processSize * 8
        print("TestCycle main", "period", audioPeriod, "buffer", bufferSize, "sample", sdr.sampleFrequency()/1e6, "MHz")
        sdr.setBufferSize(bufferSize)
        // https://lapcatsoftware.com/articles/prevent-app-nap.html
        // http://arsenkin.com/Disable-app-nap.html
        // https://developer.apple.com/library/archive/documentation/Performance/Conceptual/power_efficiency_guidelines_osx/PrioritizeWorkAtTheAppLevel.html
        activityToken = ProcessInfo.processInfo.beginActivity(
            options: [.userInitiated,.latencyCritical],
            reason:"Real time signal")

        sdr.receiveLoop(processSize)

        ProcessInfo.processInfo.endActivity(activityToken!)
        print("TestCycle ending")
        
        printTimes()
        
    }
    
    func setFrequency(_ frequency:Double) {
        //print("ReceiveThread setFrequency", frequency)
        sdr.tuneHz = frequency
        spectrum?.centreHz = frequency
    }
    
    func setDemodulator(_ key:String) {
    }
    
    func startReceive() {
        sdr.startReceive()
    }
    
    func stopReceive() {
        sdr.stopReceive()
    }
    
    func getAntennas()-> [String] {
        ["None"]
    }
    
    func set(antenna: String) {
    }

    func getGains()-> [Int] {
        [0, -10, -20]
    }

    func set(gain: Int) {
    }

}
