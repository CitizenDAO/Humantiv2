//
//  StatsView.swift
//  DynamicViewsTesting
//
//  Created by Mark Pruit on 6/5/21.
//

import SwiftUI
import LightChart

struct StatsView: View {
    var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible())]
    
    @ObservedObject var db: DataBroadcaster
    @ObservedObject var hkm: HealthKitManager
    
    @State var sysValue = 120
    @State var diaValue = 80
    @State var sysArr: [Double] = []
    @State var diaArr: [Double] = []
    
    
    func checkIfBpMonitored() {
        hkm.humantiveData.enumerated().forEach { (index, element) in
            if element.type == "SysBP" {
                sysValue = Int(element.valueArray.last ?? 120.0)
                sysArr = element.valueArray
            }
            if element.type == "DiaBP" {
                diaValue = Int(element.valueArray.last ?? 80.0)
                diaArr = element.valueArray
            }
        }
    }
    
    var body: some View {
        LazyVGrid(columns: gridItemLayout, spacing: 10) {
            ForEach(Array(hkm.humantiveData.enumerated()), id: \.1) { index, item in
                if item.type != "SysBP" && item.type != "DiaBP" {
                    StatView(value: item.value, valueArray: item.valueArray, measure: item.units, name: item.type, color: db.normalizeHD2(hData: hkm.humantiveData).1[index])
                } else if item.type == "DiaBP"{
                    BpStatView(valueSys: sysValue, valueDia: diaValue, valueSysArray: sysArr, valueDiaArray: diaArr, measure: "mmHg", name: "Blood Pressure", color: db.normalizeHD2(hData: hkm.humantiveData).1[index])
                } //else if item.type == "DiaBP" {
                    //EmptyView()
                //}
        }
        }.onAppear {
            checkIfBpMonitored()
        }
    }
}

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView(db: DataBroadcaster(), hkm: HealthKitManager())
    }
}

struct StatView: View {
    var value: Double
    var valueArray: [Double]
    var measure: String
    var name: String
    var color: Color
    var body: some View {
        VStack {
            HStack {
                Text(String(format:"%.1f", value))
                //Text(String(value.rounded()))
                    .font(.title)
                    .foregroundColor(color)
                    .bold()
                Text(measure)
                    .font(.footnote)
                    .foregroundColor(.black)
                Spacer()
            }
            HStack {
                Label(name, systemImage: "circle.fill")
                    .foregroundColor(color)
                Spacer()
            }.padding(.bottom, 5)
            ZStack {
                VStack {
                    Spacer()
                Rectangle()
                    .foregroundColor(.blue)
                   .frame(height: 20)
                    .opacity(0.3)
                }
                
            LightChartView(data: valueArray,
                           type: .curved,
                           visualType: .filled(color: color, lineWidth: 3),
                           offset: 0.2,
                           currentValueLineType: .dash(color: .gray, lineWidth: 1, dash: [5]))
                .opacity(0.99)
                .frame(height: 60)
        }
                .padding(.bottom,5)
        }.padding()
        .background(Color.white)
        .cornerRadius(10.0)
    }
}

struct BpStatView: View {
    var valueSys: Int = 120
    var valueDia: Int = 80
    var valueSysArray: [Double]
    var valueDiaArray: [Double]
    var measure: String = "mmHg"
    var name: String = "BP"
    var color: Color
    
    var body: some View {
        VStack {
            HStack {
                Text("\(valueSys) / \(valueDia)")
                    .font(.system(size: 24.0))
                    .foregroundColor(color)
                    .bold()
                Text(measure)
                    .font(.system(size: 8.0))
                Spacer()
            }
            HStack {
                Label(name, systemImage: "circle.fill")
                    .foregroundColor(color)
                Spacer()
            }.padding(.bottom, 5)
            ZStack {
                VStack {
                    Spacer()
                Rectangle()
                    .foregroundColor(.blue)
                   .frame(height: 20)
                    .opacity(0.3)
                }
                
            LightChartView(data: valueSysArray,
                           type: .curved,
                           visualType: .filled(color: color, lineWidth: 3),
                           offset: 0.2,
                           currentValueLineType: .dash(color: .gray, lineWidth: 1, dash: [5]))
                .opacity(0.99)
                .frame(height: 60)
        }
                .padding(.bottom,5)
        }.padding()
        .background(Color.white)
        .cornerRadius(10.0)
    }
}

