//
//  ContentView.swift
//  sdrplay1
//
//  Created by Andy Hooper on 2023-02-01.
//

import sdrlib
import SwiftUI
import AppKit.NSEvent

// https://www.appcoda.com/swiftui-toggle-style/
// https://sarunw.com/posts/swiftui-toggle-customization/
struct CustomToggleStyle: ToggleStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        return HStack {
            if configuration.isOn {
                Text("⏸️")//.background(Color.red)
            } else {
                Text("▶️")//.background(Color.green)
            }
        }
        .font(.system(size: 30))
//        .background(
//            RoundedRectangle(cornerRadius: 10)
//                .fill(configuration.isOn ? Color.red: Color.green)
//        )
        .onTapGesture {
            configuration.isOn.toggle()
        }
    }
}

struct ContentView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
#if false
    @FetchRequest private var previousBand: FetchedResults<Band>
    @FetchRequest private var previousStation: FetchedResults<Station>
#endif
    @State var frequency: Double
    @State var frequencyStep: Double = 200
    @State var started: Bool = false
    let receiveThread: ReceiveThreadProtocol
    @State private var demodulator = "FM"
    @State var antennaChoices: [String]
    @State var antenna: String
    @State var gainChoices: [Int]
    @State var gain: Int
    @FocusState private var frequencyFocused: Bool
                // https://nsscreencast.com/episodes/529-swiftui-focus
    @State var keyDownEvent = KeyDownEvent()
    let timer = Timer.publish(every: 5/*seconds*/,
                              on: .main, in: .common).autoconnect()
#if false
    init() {
        let stationFetch: NSFetchRequest<Station> = Station.fetchRequest()
        stationFetch.predicate = NSPredicate(format: "name == %@", "previous")
        stationFetch.fetchLimit = 1
        stationFetch.sortDescriptors = []
        _previousStation = FetchRequest(fetchRequest: stationFetch)
        let bandFetch: NSFetchRequest<Band> = Band.fetchRequest()
        bandFetch.predicate = NSPredicate(format: "name == %@", "previous")
        bandFetch.fetchLimit = 1
        bandFetch.sortDescriptors = []
        _previousBand = FetchRequest(fetchRequest: bandFetch)
    }
#endif
    var body: some View {
        VStack(alignment: .center, spacing: 5) {
            Spacer()
            Form {
                HStack(alignment: .center, spacing: 10) {
                    Spacer().padding(.leading)
                    VStack {
                        
                        TextField("Frequency:",
                                  value: $frequency, format: .number,
                                  prompt: Text("kHz"))
                            .font(.system(size: 20))
                            .multilineTextAlignment(.trailing)
                            .focused($frequencyFocused)
                            .onSubmit {
                                //print("Frequency", frequency)
                                receiveThread.setFrequency(frequency * 1e3)
                        }
                        
                        HStack {
                            Spacer().padding(.leading)
                            
                            TextField("Step:",
                                      value: $frequencyStep, format: .number,
                                      prompt: Text("kHz"))
                                .font(.system(size: 12))
                                .multilineTextAlignment(.trailing)
                                .onSubmit {
                                    //print("Frequency step", frequencyStep)
                            }
                            
                            Button("⬆︎", action:{
                                //print("Frequency up", frequencyStep)
                                frequencyFocused = false
                                frequency += frequencyStep
                                receiveThread.setFrequency(frequency * 1e3)
                            })
                            
                            Button("⬇︎", action:{
                                //print("Frequency down", frequencyStep)
                                frequencyFocused = false
                                frequency -= frequencyStep
                                receiveThread.setFrequency(frequency * 1e3)
                            })
                        }
                    }
                    Spacer()
                    
                    Toggle("Start/Stop", isOn: $started)
                        .toggleStyle(CustomToggleStyle())
                        .onChange(of: started) { newValue in
                            print("Start/Stop", newValue, frequency)
                            if newValue {
                                receiveThread.setFrequency(frequency * 1e3)
                                receiveThread.startReceive()
                            } else {
                                receiveThread.stopReceive()
                            }
                        }
                    VStack(alignment: .trailing, spacing: 10) {
                        
                        Picker("", selection: $demodulator) {
                            ForEach(Array(ReceiveThread.demodulators.keys).sorted(), id: \.self) {
                                Text($0)
                            }
                        }
                        .pickerStyle(.menu)
                        .frame(width: 70)
                        .clipped()
                        .onChange(of: demodulator) { newValue in
                            print("demodulator", newValue)
                            receiveThread.setDemodulator(newValue)
                            demodulator = newValue
                        }
                        
                        Picker("", selection: $antenna) {
                            ForEach(antennaChoices, id: \.self) {
                                Text($0)
                            }
                        }.id(antennaChoices)     // << important !! https://stackoverflow.com/a/62246023
                        .pickerStyle(.menu)
                        .frame(width: 120)
                        .clipped()
                        .onChange(of: antenna) { newValue in
                            print("antenna", newValue)
                            receiveThread.set(antenna: newValue)
                            antenna = newValue
                        }
                        
                        Picker(selection: $gain, label: Text("RF Gain:")) {
                            ForEach(gainChoices, id: \.self) {
                                Text(String($0))
                            }
                        }.id(gainChoices)
                        .pickerStyle(.menu)
                        .frame(width: 120)
                        .clipped()
                        .onChange(of: gain) { newValue in
                            print("gain", newValue)
                            receiveThread.set(gain: newValue)
                            gain = newValue
                        }
                    }
                    Spacer().padding(.trailing)
                }
            }
            Spacer()
            SpectrumView(source: receiveThread.spectrum)
        }
        .background(KeyDownView(keyDownList: [NSUpArrowFunctionKey, NSDownArrowFunctionKey],
                                keyDownEvent: $keyDownEvent))
        .onChange(of: keyDownEvent) { newValue in
            //newValue.print("keyDownEvent")
            if let c = newValue.characters?.utf16.first {
                if c == NSUpArrowFunctionKey {
                    frequencyFocused = false
                    frequency += frequencyStep
                    receiveThread.setFrequency(frequency * 1e3)
                } else if c == NSDownArrowFunctionKey {
                    frequencyFocused = false
                    frequency -= frequencyStep
                    receiveThread.setFrequency(frequency * 1e3)
                }
                DispatchQueue.main.async {
                    keyDownEvent = KeyDownEvent() // reset to allow repeating same key
                }

            }
        }
        .onReceive(timer) { input in
            receiveThread.printTimes()
        }

    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let mockReceive = MockReceiveThread()
        ContentView(frequency: 96300, started: false, receiveThread: mockReceive,
                    antennaChoices: mockReceive.getAntennas(), antenna: mockReceive.getAntennas()[0],
                    gainChoices: mockReceive.getGains(), gain: mockReceive.getGains()[0])
    }
}
