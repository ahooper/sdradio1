// https://www.swiftbysundell.com/articles/different-flavors-of-type-erasure-in-swift/

protocol SinkProto {
    associatedtype Input
    func process(_ input:Input)
}

struct AnySink<Input> {
    typealias Handler = (Input) -> Void
    let process: (@escaping Handler) -> Void
    let handler: Handler
}

class Source<Output> {
    var sinks = [ (Output) -> Void ]()
    func add<S:SinkProto>(_ sink:S) where S.Input == Output {
        let wrapper = { (_ input:Output) in sink.process(input) }
        sinks.append(wrapper)
    }
    func run(_ out:Output) {
        sinks.map { $0(out) }
    }
}

class Sink<Input>: SinkProto {
    let name: String
    init(_ name:String) { self.name = name }
    func process(_ input: Input) {
        print(name, "sink process", input)
    }
}

let x = Source<String>()
let y = Sink<String>("y")
let z = Sink<String>("z")
x.add(y)
x.add(z)
//x.add(Sink<Float>("incompatible"))
x.run("input")

