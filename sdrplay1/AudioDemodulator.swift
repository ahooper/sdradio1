//
//  AudioDemodulator.swift
//  sdrplay1
//
//  Created by Andy Hooper on 2023-02-12.
//

import sdrlib

class AudioDemodulator {
    /// head is required by ReceiveThread to disconnect the demodulator
    let head: Buffered<ComplexSamples,ComplexSamples>?
    init(head: Buffered<ComplexSamples,ComplexSamples>?) {
        self.head = head
    }
    /// Null demodulator
    required init(_ source: BufferedSource<ComplexSamples>, _ audioOut: AudioOutput) {
        self.head = nil
    }
}

class FMDemodulator: AudioDemodulator {
    static let FREQUENCY_DEVIATION = 75_000,
               DEEMPHASIS_TIME = Float(75e-6),
               AUDIO_FILTER_HZ = 15_000

    required init(_ source: BufferedSource<ComplexSamples>, _ audioOut: AudioOutput) {
        let audioSampleHz = audioOut.sampleFrequency()
        let downSampleHz = audioSampleHz * 5
        let downSampleIQ = UpFIRDown(source: source,
                                     Int(downSampleHz),
                                     Int(source.sampleFrequency()),
                                     15,
                                     Float(Self.FREQUENCY_DEVIATION) / Float(downSampleHz),
                                     windowFunction: WindowFunction.blackman)
        super.init(head: downSampleIQ)
        let demodulated = FMDemodulate(source: downSampleIQ,
                                       modulationFactor: 0.5)
        let downSampleAF = UpFIRDown(source: demodulated,
                                     Int(audioSampleHz),
                                     Int(downSampleHz),
                                     15, // * 25 * 2
                                     Float(Self.AUDIO_FILTER_HZ) / Float(audioSampleHz),
                                     windowFunction: WindowFunction.blackman)
        let deemphasis = FMDeemphasis(source: downSampleAF,
                                      tau: Self.DEEMPHASIS_TIME)
        //let audioDC = DCRemove(source:deemphasis, 64)
        //let audioAGC = AutoGainControl(source:audioDC)
        let last = deemphasis
        print("FMDemodulator", "source", source.sampleFrequency(),
              "downSample", downSampleHz,
              "AF", last.sampleFrequency(),
              "audio", audioOut.sampleFrequency())
        assert(last.sampleFrequency() == audioOut.sampleFrequency())
        
        audioOut.connect(source: last)
    }
    
}

class AMDemodulator: AudioDemodulator {
    static let BANDWIDTH = 10_000,
               AUDIO_FILTER_HZ = 5000
    
    required init(_ source: BufferedSource<ComplexSamples>, _ audioOut: AudioOutput) {
        let audioSampleHz = audioOut.sampleFrequency()
        let downSampleHz = audioSampleHz * 5
        let downSampleIQ = UpFIRDown(source: source,
                                     Int(downSampleHz),
                                     Int(source.sampleFrequency()),
                                     15, // * 10 * 2
                                     Float(Self.BANDWIDTH) / Float(downSampleHz),
                                     windowFunction: WindowFunction.blackman)
        super.init(head: downSampleIQ)
        let demodulated = AMEnvDemodulate(source: downSampleIQ, factor: 5)
        let downSampleAF = UpFIRDown(source:demodulated,
                                     Int(audioSampleHz),
                                     Int(downSampleHz),
                                     15, // * 25 * 2
                                     Float(Self.AUDIO_FILTER_HZ) / Float(audioSampleHz),
                                     windowFunction: WindowFunction.blackman)
//        let audioAGC = AutoGainControl(downSampleAF, gain: 1e4)
        let audioAGC = AGC(downSampleAF, gain: 1e3)
        let last = audioAGC
        print("AMDemodulator", "source", source.sampleFrequency(), "downSample", downSampleHz, "AF", last.sampleFrequency(), "audio", audioOut.sampleFrequency())
        assert(last.sampleFrequency() == audioOut.sampleFrequency())
       
        audioOut.connect(source: last)
    }
}
