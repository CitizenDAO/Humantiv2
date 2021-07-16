//
//  MeditView.swift
//  DynamicViewsTesting
//
//  Created by Mark Pruit on 6/5/21.
//

import SwiftUI

struct MeditView: View {
    @ObservedObject var db: DataBroadcaster
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "m.circle")
                    .resizable()
                    .frame(width: 80, height: 60)
                    .foregroundColor(.white)
                    .opacity(0.6)
                Spacer()
                    .frame(width: 25)
                VStack {
            Text(String(db.meditBalance))
                .foregroundColor(.white)
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .bold()
            Text(db.meditText)
                .font(.footnote)
                .foregroundColor(.white)
                }
                
                Spacer()
            }
        }.padding()
        .background(LinearGradient(gradient: Gradient(colors: [.blue, .blue, .blue, .blue, .blue, .green]), startPoint: .leading, endPoint: .trailing))
        .cornerRadius(10.0)
    }
}

struct MeditView_Previews: PreviewProvider {
    static var previews: some View {
        MeditView(db: DataBroadcaster())
    }
}
