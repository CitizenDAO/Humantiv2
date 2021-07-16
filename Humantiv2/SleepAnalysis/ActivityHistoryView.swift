//
//  ActivityHistoryView.swift
//  StravaGraph
//
//  Created by Mark Pruit on 3/25/21.
//

import SwiftUI

struct ActivityHistoryView: View {
    @ObservedObject var hkModel: HealthKitManager
    @State var selectedIndex: Int = 0
    
    var body: some View {
        VStack(spacing: 16) {
            
        //if hkModel.sleep > 0 {
            ActivityHistoryText(logs: hkModel.sleepHrLogs, logs2: hkModel.sleepAeLogs, logs3: hkModel.sleepStepLogs, selectedIndex: $selectedIndex)
                .padding(.bottom,10)
            ActivityGraph(logs: hkModel.sleepHrLogs, logs2: hkModel.sleepAeLogs, logs3: hkModel.sleepStepLogs, selectedIndex: $selectedIndex)
            //} else {
                //Text("Sleep Details Not Available")
                    //.foregroundColor(.white)
                    //.padding(10)
            //}
                    
        }.padding()
        //.padding(.leading)
        //.padding(.trailing)
    }
}

struct ActivityHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityHistoryView(hkModel: HealthKitManager())
    }
}

