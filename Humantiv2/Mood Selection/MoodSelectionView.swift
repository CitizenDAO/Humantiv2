//
//  MoodSelectionView.swift
//  Mood
//
//  Created by Mark Pruit on 7/12/21.
//

import SwiftUI

struct MoodSelectionView: View {
    @State private var rating = 50.0
    @State var crop: GeometryProxy
    @AppStorage("moodRating") private var moodRating = 50.0
    //@Environment(\.scenePhase) private var scenePhase
    var body: some View {
        VStack(spacing: 15) {
            //Text("Rating: \(Int(rating))")
            SwiftyMoji(value: rating, crop: crop)
            Text("Rating: \(Int(rating))")
                .font(.title)
                .fontWeight(.bold)
            Slider(value: $rating,
                   in: 0...100)
        }.onAppear {
            // evrytime when we start app from xcode we get this
            print("onAppear moodRating is \(moodRating)")
            rating = moodRating
        }/*.onChange(of: scenePhase) { [scenePhase] phase in
            // only when we put the app in backgropund or close in background we get these message
            print("old scenePhase value is \(scenePhase)")
            print("new phase value is \(phase)")
            if phase == .background {
                moodRating = rating
            }
        }*/
        .padding()
    }
}

struct MoodSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        Text("Hello")
        //MoodSelectionView()
    }
}
