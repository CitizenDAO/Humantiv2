//
//  HGHeaderView.swift
//  DynamicViewsTesting
//
//  Created by Mark Pruit on 6/5/21.
//

import SwiftUI

struct HGHeaderView: View {
    @State var showHealthTypesSelection = false
    @ObservedObject var hkm: HealthKitManager
    var body: some View {
        HStack {
            Spacer()
                .frame(width: 10)
            Text("Health graph")
                .font(.headline)
                .foregroundColor(.gray)
                .opacity(0.8)
            Spacer()
            Button(action: {
                showHealthTypesSelection.toggle()
            }, label: {
                Label("Add data source", systemImage: "plus.circle")
                    .font(.headline)
            })
            Spacer()
                .frame(width: 10)
        }.padding()
        .background(Color.white)
        .cornerRadius(10.0)
        .sheet(isPresented: $showHealthTypesSelection) {
            HealthTypesSelectionView(showHealthTypesSelection: $showHealthTypesSelection, hkm: hkm)
        }
    }
}

struct HGHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HGHeaderView( hkm: HealthKitManager())
    }
}
