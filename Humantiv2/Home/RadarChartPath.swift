//
//  RadarChartPath.swift
//  DynamicViewsTesting
//
//  Created by Mark Pruit on 6/5/21.
//

import Foundation
import SwiftUI

struct RadarChartPath: Shape {
    
    @ObservedObject var db: DataBroadcaster
    @ObservedObject var hkm: HealthKitManager
   
  //have to make sure all data are in before continuing
  let data: [Double]
  
  func path(in rect: CGRect) -> Path {
    print(data)
    guard
      3 <= data.count,
        //3 <= db.humantiveData.count,
      let minimum = data.min(),
      0 <= minimum,
      let maximum = data.max()
    else { return Path() }
    
    let radius = min(rect.maxX - rect.midX, rect.maxY - rect.midY)
    var path = Path()
    
    for (index, entry) in data.enumerated() {
      switch index {
        case 0:
          path.move(to: CGPoint(x: rect.midX + CGFloat(entry / maximum) * cos(CGFloat(index) * 2 * .pi / CGFloat(data.count) - .pi / 2) * radius,
                                y: rect.midY + CGFloat(entry / maximum) * sin(CGFloat(index) * 2 * .pi / CGFloat(data.count) - .pi / 2) * radius))
          
        default:
          path.addLine(to: CGPoint(x: rect.midX + CGFloat(entry / maximum) * cos(CGFloat(index) * 2 * .pi / CGFloat(data.count) - .pi / 2) * radius,
                                   y: rect.midY + CGFloat(entry / maximum) * sin(CGFloat(index) * 2 * .pi / CGFloat(data.count) - .pi / 2) * radius))
      }
    }
    path.closeSubpath()
    return path
  }
}




struct HealthTypes: View {
    @ObservedObject var db: DataBroadcaster
    @ObservedObject var hkm: HealthKitManager
    var body: some View {
        ZStack{
            ForEach(Array(hkm.humantiveData.enumerated()), id: \.1) { index, element in
                HealthType(count: hkm.humantiveData.count, hour: index, type: element.type)
            }
        }
    }
}

struct HealthType: View {
    var count: Int
    var hour: Int
    var type: String
    var body: some View {
        VStack {
            Text("\(type)")
                .font(.system(size: 10, weight: .bold, design: .default))
                //.rotationEffect(.radians(-(Double.pi*2 / 10 * Double(hour))))
                .rotationEffect(.radians(-(Double.pi*2 / Double(count) * Double(hour))))
                .foregroundColor(.black)
            Spacer()
        }
        .padding()
        .rotationEffect(.radians( (Double.pi*2 / Double(count) * Double(hour))))
    }
}
