//
//  ContentView.swift
//  clock Watch App
//
//  Created by Caroline Jardim Siqueira on 03/09/24.
//

import SwiftUI
import UserNotifications

struct ContentView: View {
    @State private var isTimerRunning = false
    @State private var timeRemaining = 25 * 60 // 25 minutos

    var body: some View {
        VStack {
            Text("Time Remaining")
                .font(.headline)
            Text(timeString(time: timeRemaining))
                .font(.largeTitle)
                .padding()

            if isTimerRunning {
                Button("Pause") {
                    pauseTimer()
                }
            } else {
                Button("Start") {
                    startTimer()
                }
            }
        }
        .onReceive(timer) { _ in
            guard isTimerRunning else { return }
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                isTimerRunning = false
                sendNotification()
            }
        }
    }

    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    func startTimer() {
        isTimerRunning = true
    }

    func pauseTimer() {
        isTimerRunning = false
    }

    func sendNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Pomodoro Complete"
        content.body = "Time for a break!"
        content.sound = UNNotificationSound.default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }

    func timeString(time: Int) -> String {
        let minutes = time / 60
        let seconds = time % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}


#Preview {
    ContentView()
}
