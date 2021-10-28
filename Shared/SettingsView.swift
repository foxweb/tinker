//
//  OrderView.swift
//  Tinker
//
//  Created by Aleksey Kurepin on 23.10.2021.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var tinkoffClient = TinkoffClient()

    var body: some View {
        VStack {
            Form {
                Section(header: Text("API-ключ")) {
                    TextField("Введите API-ключ", text: $tinkoffClient.apiKey)
                }
            }
        }
        .navigationTitle("Настройки")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
