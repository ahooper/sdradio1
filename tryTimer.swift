import Foundation
let timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { timer in
    print("timer")
}
RunLoop.main.add(timer, forMode: .`default`)
//RunLoop.main.run()
for _ in 0..<10 {
    sleep(1)
}
timer.invalidate()
