//
//  SleepHeaderView.swift
//  Humantiv2
//
//  Created by Mark Pruit on 7/12/21.
//

import SwiftUI

struct SleepHeaderView: View {
    var body: some View {
        HStack {
            Spacer()
                .frame(width: 10)
            Text("Sleep")
                .font(.headline)
                .foregroundColor(.gray)
                .opacity(0.8)
            Spacer()
        }.padding()
        .background(Color.white)
        .cornerRadius(10.0)
    }
}

struct SleepHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        SleepHeaderView()
    }
}
