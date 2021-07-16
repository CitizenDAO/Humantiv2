//
//  ActivityHistoryText.swift
//  StravaGraph
//
//  Created by Mark Pruit on 3/25/21.
//

import SwiftUI

struct ActivityHistoryText: View {
    
    var logs: [ActivityLog]
    var logs2: [ActivityLog]
    var logs3: [ActivityLog]

    @Binding var selectedIndex: Int
    //@Binding var selectedIndexHrv: Int
    
    var body: some View {
        if logs.count > 0 && logs2.count > 0 && logs3.count > 0{
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(logs[selectedIndex].date, style: .date)
                    .font(.system(size: 18, weight: .bold, design: .default))
                    .foregroundColor(.white)
                    .bold()
                
                 Text(logs[selectedIndex].date, style: .time)
                 .font(.system(size: 16, weight: .bold, design: .default))
                    .foregroundColor(.white)
                 .bold()
            }
            .padding(.leading, 10)
            
            HStack(spacing: 16) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Heart Rate")
                        .font(.caption)
                        .foregroundColor(Color.red.opacity(0.8))
                    Text(String(format: "%.2f bpm", logs[selectedIndex].value))
                        .font(Font.system(size: 12, weight: .medium, design: .default))
                        .foregroundColor(.white)
                }
                
                Color.gray
                    .opacity(0.5)
                    .frame(width: 1, height: 30, alignment: .center)
                    
                VStack(alignment: .leading, spacing: 4) {
                    Text("Energy")
                        .font(.caption)
                        .foregroundColor(Color.blue.opacity(0.8))
                    Text(String(format: "%.2f kcal", logs2[selectedIndex].value))
                        .font(Font.system(size: 12, weight: .medium, design: .default))
                        .foregroundColor(.white)
                }
                
                Color.gray
                    .opacity(0.5)
                    .frame(width: 1, height: 30, alignment: .center)
                
                if selectedIndex < logs3.count {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Movement")
                        .font(.caption)
                        .foregroundColor(Color.orange.opacity(0.8))
                    Text(String(format: "%.1f mvmt", logs3[selectedIndex].value))
                        .font(Font.system(size: 12, weight: .medium, design: .default))
                        .foregroundColor(.white)
                }
                }
                
                Spacer()
            }.padding(.leading, 10)
            
            VStack(alignment: .leading, spacing: 5) {
                Text("Sleep Observations")
                    .font(Font.caption.weight(.heavy))
                    .foregroundColor(Color.white.opacity(0.7))
                //Text("\(mileMax) mi")
                    //.font(Font.caption)
                    //.foregroundColor(Color.black.opacity(0.5))
            }.padding(.top, 10)
            
        }.padding(.top)
      }
    }
}
