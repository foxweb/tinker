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
                                    .font(.title)
                                    .fontWeight(.semibold)
                                
                                Spacer()
                                
                                let balance = String(format: "%g шт.", position.balance)
                                let expectedYield = String(format: "%+g \(position.expectedYield.currency)", position.expectedYield.value)
                                
                                VStack(alignment: .trailing, spacing: 10) {
                                    Text("\(balance)")
                                        .font(.body)
                                    
                                    Text("\(expectedYield)")
                                        .font(.body)
                                }
                            }
                            Spacer()
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
