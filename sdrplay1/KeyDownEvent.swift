//
//  KeyDownEvent.swift
//  TrySwiftUI
//
//  Created by Andy Hooper on 2023-02-25.
//
//  https://github.com/underthestars-zhy/SwiftUIKeyPress

import SwiftUI

struct KeyDownEvent: Equatable/*automatic synthesis*/ {
    let modifierFlags: NSEvent.ModifierFlags
    let keyCode: UInt16
    let characters: String?
    init(modifierFlags: NSEvent.ModifierFlags, keyCode: UInt16, characters: String?) {
        self.modifierFlags = modifierFlags
        self.keyCode = keyCode
        self.characters = characters
    }
    init(_ event: NSEvent) {
        self.modifierFlags = event.modifierFlags
        self.keyCode = event.keyCode
        self.characters = event.characters
    }
    init() {
        self.modifierFlags = []
        self.keyCode = 0
        self.characters = nil
    }
    func print(_ label: String) {
        Swift.print(label,
                    (modifierFlags.contains(.command) ? "⌘" : "") +
                    (modifierFlags.contains(.shift) ? "⇧" : "") +
                    (modifierFlags.contains(.option) ? "⌥" : "") +
                    (modifierFlags.contains(.control) ? "⌃" : "") +
                    (modifierFlags.contains(.capsLock) ? "⇪" : "") +
                    (modifierFlags.contains(.function) ? "fn" : ""),
                    String(keyCode),
                    (characters ?? ""))
    }
}

class KeyDownController: NSViewController {
    var delegate: KeyDownViewControllerDelegate? = nil

    override func keyDown(with event: NSEvent) {
        //KeyDownEvent(event).print("KeyDownController keyDown")
        if let delegate = delegate,
           !delegate.event(KeyDownEvent(event)) {
            super.keyDown(with: event)
        }
    }
    
    override func loadView() {
        self.view = KeyView()
    }
    
    override var acceptsFirstResponder: Bool { true }
    
    class KeyView: NSView {
        override var acceptsFirstResponder: Bool { true }
        
        override func keyDown(with event: NSEvent) {
            //KeyDownEvent(event).print("KeyView keyDown")
            super.keyDown(with: event)
        }
    }
}

struct KeyDownView: NSViewControllerRepresentable {
    @State var keyDownList: [Int]
    @Binding var keyDownEvent: KeyDownEvent
    
    func makeCoordinator()-> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, KeyDownViewControllerDelegate {
        var parent: KeyDownView
        
        init(_ parent: KeyDownView) {
            self.parent = parent
        }
        
        func event(_ event: KeyDownEvent)-> Bool {
            //print("Coordinator event", event.keyCode, event.characters?.utf16.first, self.parent.keyDownList)
            if let ec = event.characters?.utf16.first, self.parent.keyDownList.contains(where: { $0 == ec }) {
                self.parent.keyDownEvent = event // fire event
                return true
            } else {
                return false
            }
        }
    }

    func makeNSViewController(context: Context)-> KeyDownController {
        let controller = KeyDownController()
        controller.delegate = context.coordinator
        return controller
    }
    
    func updateNSViewController(_ nsViewController: KeyDownController, context: Context) {
        
    }
}

protocol KeyDownViewControllerDelegate {
    func event(_ event: KeyDownEvent)-> Bool
}

struct TryKeyDown: View {
    @State var keysString = "No Keys"
    @State var keyDownEvent = KeyDownEvent()

    var body: some View {
        HStack {
            Text("Keys:")
            Text(keysString)
                .padding()
        }
        .frame(width: 400, height: 100)
        .background(KeyDownView(keyDownList: [NSUpArrowFunctionKey, NSDownArrowFunctionKey],
                                keyDownEvent: $keyDownEvent))
        .onChange(of: keyDownEvent) { newValue in
            newValue.print("TryKeyDown keyDownEvent")
            keysString = newValue.characters?.utf16.first.debugDescription ?? "nil"
            
        }
    }
}

struct TryKeyEvent_Previews: PreviewProvider {
    static var previews: some View {
        TryKeyDown()
    }
}
