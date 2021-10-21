//
//  ContentView.swift
//  Shared
//
//  Created by Aleksey Kurepin on 20.10.2021.
//

import SwiftUI

struct ContentView: View {
    
    @State var positions = [Position]()
    
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    var body: some View {
        List(positions) { position in
            VStack(alignment: .leading) {
                            HStack{
                                Text("\(position.name)")
                                    .font(.headline)
                                    .fontWeight(.semibold)
                                    .lineLimit(1)
                            }
                                
                            HStack {
                                let balance = String(format: "%g шт.", position.balance)
                                let expectedYield = String(format: "%+g \(position.expectedYield.currencySymbol!)", position.expectedYield.value)

                                Text("\(expectedYield)")
                                    .font(.footnote)
                                    .foregroundColor(position.expectedYield.value > 0 ? .green : .red)

                                Spacer()

                                Text("\(balance)")
                                    .font(.footnote)
                                    .foregroundColor(.secondary)
                            }

                        }
        }
            .onAppear() {
                TinkoffClient().getPortfolio { result in
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let positions):
                            self.positions = positions
                        case .failure:
                            self.positions = []
                        }
                    }
                }
            }.navigationTitle("Portfolio")
    };
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
