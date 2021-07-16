//
//  MoodHeaderView.swift
//  Humantiv2
//
//  Created by Mark Pruit on 7/12/21.
//

import SwiftUI

struct MoodHeaderView: View {
    var body: some View {
        HStack {
            Spacer()
                .frame(width: 10)
            Text("Mood")
                .font(.headline)
                .foregroundColor(.gray)
                .opacity(0.8)
            Spacer()
        }.padding()
        .background(Color.white)
        .cornerRadius(10.0)
    }
}

struct MoodHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        MoodHeaderView()
    }
}
