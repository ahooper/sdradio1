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
    // https://www.hackingwithswift.com/quick-start/swiftui/how-to-create-a-core-data-fetch-request-using-fetchrequest
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.name),
    ]) var bands: FetchedResults<Band>
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.name),
    ]) var stations: FetchedResults<Station>
#if false
    @FetchRequest(
        sortDescriptors: [
            SortDescriptor(\.name),
            ],
        predicate: NSPredicate(format: "name == %@", "previous")
    ) private var previousBand: FetchedResults<Band>
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
    @State var selectedBand: Band?
    @State var selectedStation: Station?
    @FocusState private var frequencyFocused: Bool
                // https://nsscreencast.com/episodes/529-swiftui-focus
    @State private var keyDownEvent = KeyDownEvent()
    @State var saveStation: String = ""
    @State private var presentEdit = false
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
                                print("Frequency", frequency)
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
                    VStack {
                        // https://stackoverflow.com/a/71594140
                        Picker("Band", selection: $selectedBand) {
                            Text("").tag(Optional<Band>(nilLiteral: ()))
                            ForEach(bands) { b in
                                Text(b.name!)
                                .tag(Optional(b))
                            }
                        }
                        .pickerStyle(.menu)
                        .onChange(of: selectedBand) { newValue in
                            setToBand(newValue)
                        }
                        Picker("Station", selection: $selectedStation) {
                            Text("").tag(Optional<Station>(nilLiteral: ()))
                            ForEach(stations) { s in
                                Text("\(s.name!) \(s.demodulator!) \(String(format: "%.0f", locale: .current, arguments: [s.frequency]))")
                                .tag(Optional(s))
                            }
                        }
                        .pickerStyle(.menu)
                        .onChange(of: selectedStation) { newValue in
                            setToStation(newValue)
                        }
                        // https://developer.apple.com/forums/thread/686024
                        HStack {
                            TextField("", text: $saveStation, prompt: Text("New station name"))
                                .onSubmit {
                                    print("New station", saveStation)
                                    let s = Station(context: managedObjectContext)
                                    s.name = saveStation
                                    s.frequency = frequency
                                    s.demodulator = demodulator
                                    s.band = selectedBand
                                    managedObjectContext.insert(s)
                                    saveStation = ""
                                }
                            Button("Edit") {
                                presentEdit = true
                            }
                            .sheet(isPresented: $presentEdit) {
                                VStack {
                                    StationsView()
                                    Spacer()
                                    Button("Dismiss") { presentEdit.toggle() }
                                    Spacer()
                                }
                                .frame(width: 500, height: 500)
    //                            .padding(10)
                            }
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
    
    func setToBand(_ selected:Band?) {
        print("band", selected?.debugDescription ?? "null")
        if let selected = selected {
            frequency = selected.frequency
            if let demod = selected.demodulator {
                demodulator = demod
            }
            if let ant = selected.antenna {
                antenna = ant
            }
            frequencyStep = selected.step
        }
    }
    
    func setToStation(_ selected:Station?) {
        print("station", selected?.debugDescription ?? "null")
        if let selected = selected {
            if selected.band != selectedBand {  // before frequency and demodulator are set
                selectedBand = selected.band
            }
            DispatchQueue.main.async {
                frequency = selected.frequency
                if started { receiveThread.setFrequency(frequency) }
                if let demod = selected.demodulator {
                    demodulator = demod
                    if started { receiveThread.setDemodulator(demodulator) }
                }
            }
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
