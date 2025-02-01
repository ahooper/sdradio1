//
//  StationsView.swift
//  sdrplay1
//
//  Created by Andy Hooper on 2023-04-30.
//
//  https://github.com/openalloc/SwiftTabler

import SwiftUI

struct StationsView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.name),
    ]) var bands: FetchedResults<Band>
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.name),
    ]) var stations: FetchedResults<Station>

    private func commitAction() {
        do {
            print("commitAction save")
            try managedObjectContext.save()
        } catch {
            let nsError = error as NSError
            print("\(#function): Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    let decimalFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()

    static let columnSpacing = CGFloat(10)
    let columns = [
        // must match views in gridRow
        GridItem(.flexible(minimum: 100, maximum: 150), spacing: columnSpacing, alignment: .leading),
        GridItem(.fixed(80), spacing: columnSpacing, alignment: .leading),
        GridItem(.fixed(80), spacing: columnSpacing, alignment: .leading),
        GridItem(.fixed(80), spacing: columnSpacing, alignment: .leading),
        GridItem(.fixed(30), spacing: columnSpacing, alignment: .center),
    ]
    private var columnPadding = EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)

    @ViewBuilder
    private func gridRow(_ s:Station?) -> some View {
        if let s = s {
            //ObservableHolder(element: s) { obs in
            //gridRow(obs)
            // https://github.com/openalloc/SwiftTabler/blob/main/Sources/Internal/ObservableHolder.swift
            @ObservedObject<Station> var obs = s
            TextField("",
                      text: Binding($obs.name, replacingNilWith: ""))
                .onSubmit(commitAction)
            TextField("",
                      value: $obs.frequency,
                      formatter: decimalFormatter)
                .multilineTextAlignment(.trailing)
                .onSubmit(commitAction)
            Picker("", selection: Binding($obs.demodulator, replacingNilWith: "")) {
                ForEach(Array(ReceiveThread.demodulators.keys).sorted(), id: \.self) {
                    Text($0)
                }
            }
    //        .pickerStyle(.automatic)
                .onSubmit(commitAction)
            Picker("", selection: $obs.band) {
                ForEach(bands) { b in
                    Text(b.name!)
                    .tag(Optional(b))
                }
            }
    //            .pickerStyle(.menu)
                .onSubmit(commitAction)
            Button("􀈑" /*✕*/)  {
                print("delete", s)
                managedObjectContext.delete(s)
            }.buttonStyle(.plain)
        } else {
            // for preview
            Text("*n")
                .padding(columnPadding)
            Text(NSNumber(value: 99_999.9),
                 formatter:decimalFormatter)
                .padding(columnPadding)
                .multilineTextAlignment(.trailing)
            Text("*d")
                .padding(columnPadding)
            Text("*b")
                .padding(columnPadding)
            Button("􀈑") { print("delete") }
                .padding(columnPadding)
                .buttonStyle(.plain)
        }
    }

    var body: some View {
        //Text("StationsView")
        VStack(spacing: 5) {
            //Text("header")
            ScrollView {
                LazyVGrid(columns: columns, spacing: 10) {
                    Text("Station Name").padding(columnPadding)//TODO: .onTapGesture { sort }
                    Text("F. kHz").padding(columnPadding)//.onTapGesture { }
                    Text("Demod.").padding(columnPadding)//.onTapGesture { }
                    Text("Band").padding(columnPadding)
                    Text("") // delete
                    
                    if ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] != nil {
                        gridRow(nil)
                    }
                    ForEach(stations, id:\.id) { s in
                        gridRow(s)
                    }
                }
            }
            //Text("footer")
        }.padding()
    }
}

struct StationsView_Previews: PreviewProvider {
    static var previews: some View {
        StationsView()
    }
}

