//
//  OptionalBinding.swift
//  TryTabler
//
//  https://github.com/AlanQuatermain/AQUI/blob/master/Sources/AQUI/OptionalBinding.swift
//

import SwiftUI

extension Binding where Value: Equatable {
    /// Creates a non-nil binding by projecting to its unwrapped value, translating nil values
    /// to or from the given nil value. If the source contains nil, this binding will return the
    /// nil value. If this binding is set to the given nil value, it will assign nil to the underlying
    /// source binding.
    ///
    /// This is useful if you have optional values of a type that has a logical 'empty' value of
    /// its own, for example `String`:
    ///
    ///     @State var name: String?
    ///     ...
    ///     TextField(text: Binding($name, replacingWithNil: ""))
    ///
    /// If the `name` property contains `nil`, the text field will see an empty string. If the text field
    /// assigns an empty string, the `name` property will be set to `nil`.
    @available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
    init(_ source: Binding<Value?>, replacingNilWith nilValue: Value) {
        self.init(
            get: { source.wrappedValue ?? nilValue },
            set: { newValue in
                if newValue == nilValue {
                    source.wrappedValue = nil
                }
                else {
                    source.wrappedValue = newValue
                }
        })
    }
}
