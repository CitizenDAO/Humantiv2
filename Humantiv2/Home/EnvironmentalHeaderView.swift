//
//  EnvironmentalHeaderView.swift
//  Humantiv2
//
//  Created by Mark Pruit on 7/10/21.
//

import SwiftUI

struct EnvironmentalHeaderView: View {
    var body: some View {
        HStack {
            Spacer()
                .frame(width: 10)
            Text("Environment")
                .font(.headline)
                .foregroundColor(.gray)
                .opacity(0.8)
            Spacer()
                //.frame(width: 10)
        }.padding()
        .background(Color.white)
        .cornerRadius(10.0)
    }
}

struct EnvironmentalHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        EnvironmentalHeaderView()
    }
}
