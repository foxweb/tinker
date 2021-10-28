//
//  StatisticsView.swift
//  Tinker
//
//  Created by Aleksey Kurepin on 23.10.2021.
//

import SwiftUI

struct StatisticsView: View {
    var body: some View {
        Text("Здесь будет статистика")
            .onAppear()
            .navigationTitle("Статистика")
    }
}

struct StatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsView()
    }
}
