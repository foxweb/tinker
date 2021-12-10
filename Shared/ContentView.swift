//
//  ContentView.swift
//  Shared
//
//  Created by Aleksey Kurepin on 20.10.2021.
//

import SwiftUI

struct ContentView: View {

    @State var positions = [Position]()

    var body: some View {
        List(positions) { position in
            HStack {
                HStack {
                    AsyncImage(url: position.imageURL) { image in
                        image.resizable()
                    } placeholder: {
                        Color.gray
                    }
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                }

                Spacer()

                VStack {
                    HStack {
                        Text(position.name)
                            .font(.headline)
                            .fontWeight(.semibold)
                            .lineLimit(1)
                            .padding(.bottom, 1)

                        Spacer()

                        Text(position.positionCostFormatted)
                            .font(.headline)
                            .fontWeight(.regular)
                    }

                    HStack {
                        let balance = String(format: "%g шт.", position.balance)

                        Text(balance)
                            .font(.footnote)
                            .foregroundColor(.secondary)

                        Text("•")
                            .font(.footnote)
                            .foregroundColor(.secondary)

                        Text(position.currentPriceFormatted)
                            .font(.footnote)
                            .foregroundColor(.secondary)

                        Spacer()

                        Text(position.expectedYieldFormatted)
                            .font(.footnote)
                            .foregroundColor(position.expectedYield.value > 0 ? .green : .red)
                    }
                }
            }
        }
        .listStyle(PlainListStyle())
        .onAppear {
            TinkoffClient().getPortfolio { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let positions):
                        let sortedPositions = positions.sorted { $0.name < $1.name }
                        self.positions = sortedPositions
                    case .failure:
                        self.positions = []
                    }
                }
            }
        }
        .refreshable {
            TinkoffClient().getPortfolio { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let positions):
                        let sortedPositions = positions.sorted { $0.name < $1.name }
                        self.positions = sortedPositions
                    case .failure:
                        self.positions = []
                    }
                }
            }
        }
        .navigationTitle("Портфель")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
