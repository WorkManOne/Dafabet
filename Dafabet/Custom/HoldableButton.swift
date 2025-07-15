//
//  HoldableButton.swift
//  Dafabet
//
//  Created by Кирилл Архипов on 14.07.2025.
//
import SwiftUI

struct HoldableButton<Label: View>: View {
    var onTap: () -> Void
    var onHold: () -> Void
    var label: () -> Label

    @State private var timer: DispatchSourceTimer?
    @State private var interval: TimeInterval = 0.4
    @State private var holdCount = 0
    @GestureState private var isPressing = false

    func startTimer() {
        timer?.cancel()
        timer = DispatchSource.makeTimerSource(queue: DispatchQueue.main)
        timer?.schedule(deadline: .now(), repeating: interval)
        timer?.setEventHandler {
            onHold()
            holdCount += 1
            if holdCount % 2 == 0 && interval > 0.05 {
                interval *= 0.85
                startTimer()
            }
        }
        timer?.resume()
    }

    func stopTimer() {
        timer?.cancel()
        timer = nil
        interval = 0.4
        holdCount = 0
    }

    var body: some View {
        let dragGesture = DragGesture(minimumDistance: 0)
            .updating($isPressing) { _, state, _ in
                state = true
            }
            .onChanged { _ in
                if timer == nil {
                    startTimer()
                }
            }
            .onEnded { _ in
                stopTimer()
            }

        label()
            .scaleEffect(isPressing ? 0.95 : 1)
            .opacity(isPressing ? 0.6 : 1)
            .animation(.easeInOut(duration: 0.2), value: isPressing)
            .gesture(dragGesture)
            .onTapGesture {
                onTap()
            }
    }
}


#Preview {
    HoldableButton(onTap: {} , onHold: {}, label: {Text("Text").padding().background(.red)})
}
