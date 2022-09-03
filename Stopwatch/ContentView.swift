//
//  ContentView.swift
//  Stopwatch
//
//  Created by Alexander Ostrovsky on 18.08.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    @State private var currentDate = Date.now
    @State private var formattedTime = "9.50"
    let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("mm:ss.SS")
        return formatter
    }()
    
    var body: some View {
        VStack {
            Text(formattedTime)
                .font(.system(size: 128, design: .monospaced))
                .onReceive(timer) { timer in
                    formattedTime = stringFromTime(interval: timer.timeIntervalSince(currentDate))
                }
            Button("Reset") {
                currentDate = .now
            }
            .font(.largeTitle)
            .buttonStyle(.borderedProminent)
            .tint(.indigo)
        }
    }
    
    func stringFromTime(interval: TimeInterval) -> String {
        let fractions = (interval.truncatingRemainder(dividingBy: 1) * 20).rounded(.towardZero) * 5
        let timeFormatter = DateComponentsFormatter()
        timeFormatter.allowedUnits = [.hour, .minute, .second]
        let fractionsFormatter = NumberFormatter()
        fractionsFormatter.minimumIntegerDigits = 2
        return timeFormatter.string(from: interval)! + "." + fractionsFormatter.string(from: NSNumber(value: fractions))!
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
