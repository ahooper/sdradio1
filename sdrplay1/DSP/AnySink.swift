#if false
// https://chris.eidhof.nl/post/type-erasers-in-swift/
// https://academy.realm.io/posts/type-erased-wrappers-in-swift/
// https://github.com/apple/swift/blob/release/5.3/stdlib/public/core/ExistentialCollection.swift#L36
public struct AnySink<Input> {
    @usableFromInline internal let box: AnySinkBoxBase<Input>
    @inlinable init<S:SinkProtocol>(_ base:S) where S.Input == Input {
        self.box = SinkBox(base)
    }
    @inlinable init(box:AnySinkBoxBase<Input>) {
        self.box = box
    }
}
extension AnySink: SinkProtocol {
    @inlinable public func process(_ input: Input) {
        box.process(input)
    }
}
@inline(never)
@usableFromInline
internal func _abstract(
  file: StaticString = #file,
  line: UInt = #line
) -> Never {
  fatalError("Method must be overridden", file: file, line: line)
}
@usableFromInline internal class AnySinkBoxBase<Input>: SinkProtocol {
    @inlinable internal init() {}
    @inlinable deinit {}
    @inlinable func process(_ input: Input) { _abstract() }
}
@usableFromInline internal final class SinkBox<Base: SinkProtocol>: AnySinkBoxBase<Base.Input> {
    @usableFromInline internal var base: Base
    @inlinable internal init(_ base: Base) { self.base = base }
    @inlinable deinit {}
    @inlinable internal override func process(_ input: Base.Input) { base.process(input) }
}
#elseif false
// https://www.swiftbysundell.com/articles/different-flavors-of-type-erasure-in-swift/
struct AnySink<Input> {
    typealias Handler = (Input) -> Void
    let process: (@escaping Handler) -> Void
    let handler: Handler
}
#endif
