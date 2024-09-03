//
//  TimerViewModel.swift
//  clock
//
//  Created by Caroline Jardim Siqueira on 03/09/24.
//

import SwiftUI

class TimerViewModel: ObservableObject {
    @ObservedObject private var timerModel = TimerModel()
    
    @Published var timeRemaining: String = "25:00"
    private var duration: Int = 25 * 60
    
    init() {
        timerModel.$timeRemaining
            .map { self.formatTime($0) }
            .assign(to: &$timeRemaining)
    }
    
    func startPomodoro() {
        timerModel.startTimer(duration: duration)
    }
    
    func pausePomodoro() {
        timerModel.pauseTimer()
    }
    
    func resumePomodoro() {
        timerModel.resumeTimer()
    }
    
    func resetPomodoro() {
        timerModel.resetTimer()
        timeRemaining = formatTime(duration)
    }
    
    private func formatTime(_ time: Int) -> String {
        let minutes = time / 60
        let seconds = time % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func persistTimerState() {
        timerModel.persistTimerState()
    }
    
    func restoreTimerState() {
        timerModel.restoreTimerState()
    }
}
