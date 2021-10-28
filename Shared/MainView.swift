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
            NavigationView {
                ContentView()
            }.tabItem {
                Label("Портфель", systemImage: "briefcase.fill")
            }.tag(0)

            NavigationView {
                StatisticsView()
            }.tabItem {
                Label("Статистика", systemImage: "chart.bar.xaxis")
            }.tag(0)

            NavigationView {
                SettingsView()
            }.tabItem {
                Label("Настройки", systemImage: "gear")
            }.tag(0)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
