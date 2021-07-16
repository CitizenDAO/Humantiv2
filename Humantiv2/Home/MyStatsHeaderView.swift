//
//  MyStatsHeaderView.swift
//  DynamicViewsTesting
//
//  Created by Mark Pruit on 6/5/21.
//

import SwiftUI

struct MyStatsHeaderView: View {
    var body: some View {
        HStack {
            Text("My Stats")
                .foregroundColor(.gray)
                .bold()
            Spacer()
            Button(action: {
                print("Edit button was tapped")
            }) {
                Image(systemName: "arrow.down.square")
            }.foregroundColor(.gray)
        }.padding()
        .background(Color.white)
        .cornerRadius(10.0)
    }
}

struct MyStatsHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        MyStatsHeaderView()
    }
}
