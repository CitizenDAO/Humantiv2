//
//  MDXView.swift
//  DynamicViewsTesting
//
//  Created by Mark Pruit on 6/5/21.
//

import SwiftUI

struct MDXView: View {
    @ObservedObject var db: DataBroadcaster
    var body: some View {
        VStack {
            HStack {
                VStack {
            Text(String(db.mdxBalance))
                .foregroundColor(.white)
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .bold()
            Text(db.mdxText)
                .font(.footnote)
                .foregroundColor(.white)
                }
                Image(systemName: "arrow.right.square")
                    .resizable()
                    .frame(width: 40, height: 60)
                    .foregroundColor(.yellow)
                    .opacity(0.6)
            }
        }.padding()
        .background(LinearGradient(gradient: Gradient(colors: [.green, .green, .green, .green, .green, .white]), startPoint: .leading, endPoint: .trailing))
        .cornerRadius(10.0)
    }
}

struct MDXView_Previews: PreviewProvider {
    static var previews: some View {
        MDXView(db: DataBroadcaster())
    }
}
