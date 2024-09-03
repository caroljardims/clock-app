//
//  ContentView.swift
//  clock Watch App
//
//  Created by Caroline Jardim Siqueira on 03/09/24.
//

import SwiftUI
import UserNotifications

struct ContentView: View {
    @StateObject private var viewModel = TimerViewModel()
        
        var body: some View {
            VStack {
                Text(viewModel.timeRemaining)
                    .font(.largeTitle)
                    .padding()
                
                HStack {
                    Button("Start") {
                        viewModel.startPomodoro()
                    }
                    Button("Pause") {
                        viewModel.pausePomodoro()
                    }
                    Button("Reset") {
                        viewModel.resetPomodoro()
                    }
                }
            }
            .onAppear {
                viewModel.restoreTimerState()
            }
            .onDisappear {
                viewModel.persistTimerState()
            }
        }
}


#Preview {
    ContentView()
}
