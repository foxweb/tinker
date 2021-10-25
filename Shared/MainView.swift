//
//  MainView.swift
//  Tinker
//
//  Created by Aleksey Kurepin on 23.10.2021.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Label("Портфель", systemImage: "briefcase.fill")
                }

            StatisticsView()
                .tabItem {
                    Label("Статистика", systemImage: "chart.bar.xaxis")
                }

            SettingsView()
                .tabItem {
                    Label("Настройки", systemImage: "gear")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
