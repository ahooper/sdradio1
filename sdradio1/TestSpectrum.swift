//
//  TestSpectrum.swift
//  sdrplay1
//
//  Created by Andy Hooper on 2023-02-17.
//

import sdrlib
import class Foundation.Thread

fileprivate class RealComponent: Buffered<ComplexSamples,RealSamples> {
       
    init(source:BufferedSource<Input>?) {
        super.init("RealComponent", source)
    }
    
    func process(_ x:ComplexSamples, _ out:inout RealSamples) {
        let inCount = x.count
        out.resize(inCount) // output same size as input
        if inCount == 0 { return }
        for i in 0..<inCount {
            // envelope
            out[i] = x[i].real
        }
    }
}

class TestSpectrum: Thread, ReceiveThreadProtocol {
    let spectrum: SpectrumData?
    let audioOut = AudioOutput() // initialize to set audio sample rate
#if true
    typealias Osc = OscillatorPrecise<RealSamples>
    //typealias Osc = Oscillator
    let tone:Osc

    override init() {
        let SAMPLE_HZ = 2e6
        let TONE_HZ = 440e0
        let CARRIER_HZ = SAMPLE_HZ/5
        tone = Osc(signalHz:TONE_HZ, sampleHz:SAMPLE_HZ, level:0.4)
        let modulated = AMModulate(source: tone,
                                   factor: 0.5,
                                   carrierHz: CARRIER_HZ,
                                   suppressedCarrier: false)
        spectrum = SpectrumData(source: modulated, fftLength: 1024, windowFunction: WindowFunction.blackman)
        spectrum?.centreHz = 0
        let mixDown = Mixer(source: modulated, signalHz: -CARRIER_HZ)
        let downSampleHz = audioOut.sampleFrequency() * 10
        let downSampleIQ = UpFIRDown(source:mixDown,
                                     Int(downSampleHz),
                                     Int(mixDown.sampleFrequency()),
                                     15, // * 10 * 2
                                     Float(10e3) / Float(downSampleHz),
                                     windowFunction:WindowFunction.hamming) // kaiser(5.0f));
        let demodulated = AMEnvDemodulate(source: downSampleIQ, factor: 5)
        let audioSampleHz = Int(audioOut.sampleFrequency())
        let downSampleAF = UpFIRDown(source:demodulated,
                                     audioSampleHz,
                                     Int(downSampleHz),
                                     15, // * 25 * 2
                                     Float(5000) / Float(audioSampleHz),
                                     windowFunction:WindowFunction.hamming) // kaiser(5.0f));
        assert(downSampleAF.sampleFrequency() == audioOut.sampleFrequency())
        audioOut.connect(source: downSampleAF)

        super.init()
        /*Thread*/name = "TestSpectrum"
    }
#else
    let tone:OscillatorPrecise<ComplexSamples>

    override init() {
        let SAMPLE_HZ = audioOut.sampleFrequency()
        let TONE_HZ = 440e0
        tone = OscillatorPrecise<ComplexSamples>(signalHz:TONE_HZ, sampleHz:SAMPLE_HZ, level:0.2)
        let real = RealComponent(source: tone)
        real.add(sink: audioOut)
        spectrum = SpectrumData(source: tone, log2Size: 10 /*N=1024*/)
        spectrum.centreHz = 0
        super.init()
        /*Thread*/name = "TestSpectrum"
    }
#endif

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
    }
    
    func setFrequency(_ frequency: Double) {
    }
    
    func setDemodulator(_ key: String) {
    }

    func startReceive() {
    }
    
    func stopReceive() {
    }
    
    func printTimes() {
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
