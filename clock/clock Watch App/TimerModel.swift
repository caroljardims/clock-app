//
//  TimerModel.swift
//  clock
//
//  Created by Caroline Jardim Siqueira on 03/09/24.
//

import Foundation
import UserNotifications

class TimerModel: ObservableObject {
    @Published var timeRemaining: Int = 0
    private var timer: Timer?
    
    func startTimer(duration: Int) {
        timeRemaining = duration
        scheduleTimer()
    }
    
    private func scheduleTimer() {
        timer?.invalidate() // Invalida qualquer timer anterior
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self?.tick()
        }
    }
    
    private func tick() {
        if timeRemaining > 0 {
            timeRemaining -= 1
        } else {
            timer?.invalidate()
            sendNotification()
        }
    }
    
    private func sendNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Pomodoro Complete"
        content.body = "Time for a break!"
        content.sound = UNNotificationSound.default

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: nil)
        UNUserNotificationCenter.current().add(request)
    }
    
    func pauseTimer() {
        timer?.invalidate()
    }
    
    func resumeTimer() {
        scheduleTimer()
    }
    
    func resetTimer() {
        timer?.invalidate()
        timeRemaining = 0
    }
    
    func persistTimerState() {
        // Implementar lógica para salvar o estado do timer quando o app for para o background
    }
    
    func restoreTimerState() {
        // Implementar lógica para restaurar o estado do timer quando o app voltar ao foreground
    }
}


