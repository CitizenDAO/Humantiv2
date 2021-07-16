//
//  HGFooterView.swift
//  DynamicViewsTesting
//
//  Created by Mark Pruit on 6/5/21.
//

import SwiftUI

struct HGFooterView: View {
    var body: some View {
        HStack {
            Spacer()
            Button(action: {
                guard let url = URL(string: "x-apple-health://") else {
                        return
                    }

                    if UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url, options: [:])
                    }
            }, label: {
                Label("Add manual activity", systemImage: "plus.circle")
                    .font(.headline)
                    //.foregroundColor(.gray)
            })
            Spacer()
        }.padding()
        .background(Color.white)
        .cornerRadius(10.0)
    }
}

struct HGFooterView_Previews: PreviewProvider {
    static var previews: some View {
        HGFooterView()
    }
}
