//
//  TestAudio.swift
//  sdrplay1
//
//  Created by Andy Hooper on 2023-02-01.
//

import sdrlib
import class Foundation.Thread

class TestAudio: Thread, ReceiveThreadProtocol {
    
    let audioOut = AudioOutput() // initialize to set audio sample rate
    private var tone:Oscillator<RealSamples>
    var timeReports = [TimeReport]()

    public init(signalHz:Double, level:Float=1.0) {
#if true
        let sampleHz = audioOut.sampleFrequency() * 300 // stress test, startup and occaisonal glitches
        tone = Oscillator<RealSamples>(signalHz: signalHz, sampleHz: sampleHz, level: level)
        let audioSampleHz = Int(audioOut.sampleFrequency())
        let downSampleAF = UpFIRDown(source:tone,
                                     audioSampleHz,
                                     Int(sampleHz),
                                     15,
                                     Float(15000) / Float(audioSampleHz),
                                     windowFunction:WindowFunction.blackman)
        print("TestAudio last", downSampleAF.sampleFrequency(), "audio", audioOut.sampleFrequency())
        audioOut.connect(source: downSampleAF)

//        spectrum = SpectrumData(source: nil as ThreadSource<ComplexSamples>?, log2Size: 10 /*N=1024*/)
#else
        let sampleHz = audioOut.sampleFrequency()
        tone = Oscillator<RealSamples>(signalHz: signalHz, sampleHz: sampleHz, level: level)
        audioOut.connect(source: tone)
#endif
        //timeReports.append(audioOut.fillTime)
        //timeReports.append(audioOut.processTime)
        timeReports.append(audioOut.waitTime)

        super.init()
        /*Thread*/name = "TestAudio"
    }

    override func main() {
        let audioPeriod = audioOut.getFramePeriod(),
            bufferSize = Int(audioPeriod * tone.sampleFrequency())
        print("TestAudio main", "period", audioPeriod, "buffer", bufferSize, "sample", tone.sampleFrequency()/1e6, "MHz")
        set_realtime(audioPeriod)
        tone.bufferSize = bufferSize
        while !isCancelled {
            tone.generate(bufferSize)
        }
        audioOut.stop()
        printTimes()
        print("TestAudio cancelled")
    }
    
    func setFrequency(_ frequency: Double) {
    }
    
    func setDemodulator(_ key: String) {
    }
 
    func startReceive() {
    }
    
    func stopReceive() {
    }
    
    var spectrum: SpectrumData?
    
    func printTimes() {
        timeReports.forEach { tr in
            tr.printAccumulated(reset: true)
        }
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
