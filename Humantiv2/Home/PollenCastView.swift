//
//  PollenCastView.swift
//  HealthKitMonitoringWorkshop
//
//  Created by Mark Pruit on 2/14/21.
//

import SwiftUI
import LightChart

struct PollenCastView: View {
    @StateObject var emModel = EnvironmentalMeasuresManager.shared
    @StateObject var locationManager = CoreLocationManager.shared
    @State var showPollen = false
    @State private var revealDetails = false
    //@AppStorage("devideId") private var closestDevice: String?
    
    func getItStarted() {
        self.emModel.getNearestPSDevice(lat: locationManager.userLatitude, long: locationManager.userLongitude) {
                device in
            
            guard let deviceString = device.deviceId else { return }
    
            //deviceIdString = String(format: "%.0f", device.deviceId ?? "18219")
        
            self.emModel.callPollenSense(device: String(deviceString)) {
                pollenSense in
            
            DispatchQueue.main.async {
                emModel.pollensense = pollenSense
                self.showPollen = true
            }
        }
    }
}
    var body: some View {
       // GeometryReader { geometry in
        VStack {
             
            ScrollView(.horizontal) {
                HStack(spacing: 10) {
            //DisclosureGroup("Show Airborne Particulate", isExpanded: $revealDetails) {
                ForEach(self.emModel.pollensense?.categories ?? [], id: \.self) { cat in
                
                VStack {
                    VStack {
                        Text(cat.categoryCommonName ?? "Unknown")
                            .font(.headline)
                            .bold()
                            .padding(.top, 10)
                        Text(cat.categoryDescription ?? "Unknown")
                            .font(.footnote)
                            .bold()
                            .padding(.bottom, 5)
                        //Text(cat.categoryCode ?? "Yes")
                        //Text(cat.categoryGroupCode ?? "Yes")
                        
                    }
                    .foregroundColor(.white)
                    
                    ZStack {
                        LightChartView(data: cat.pPM3 ?? [],
                                       type: .curved,
                                       visualType: .filled(color: .white, lineWidth: 4),
                                       offset: 0.1,
                                       currentValueLineType: .line(color: .gray, lineWidth: 1))
                            .frame(height: 70)
                            .padding(4)
                        
                        VStack (alignment: .leading){
                            HStack {
                                Spacer()
                                Text(String(Int(cat.pPM3?.max() ?? 0.0)))
                                    //.font(.footnote)
                                    .font(.system(size: 14.0))
                                    .bold()
                                    .padding(3)
                                    .background(Color.green)
                                    .foregroundColor(.white)
                                    .cornerRadius(5)
                                    .padding(.trailing, 5)
                            }
                            Spacer()
                            HStack {
                                Spacer()
                                Text(String(Int(cat.pPM3?.min() ?? 0.0)))
                                    .font(.system(size: 14.0))
                                    .bold()
                                    .padding(3)
                                    .background(Color.green)
                                    .foregroundColor(.white)
                                    .cornerRadius(5)
                                    .padding(.trailing, 5)
                            }
                        }
                    }
                    Text("LAST 8 HRS (PPM)")
                        .font(.footnote)
                        .bold()
                        .foregroundColor(.white)
                        .padding(.bottom, 7)
                }
                .background(LinearGradient(gradient: Gradient(colors: [.green, .blue, .blue, .blue]), startPoint: .bottomLeading, endPoint: .topTrailing))
                .cornerRadius(10)
                .overlay(RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 1))
                .shadow(radius: 10)
                .frame(width: 250)
            }
            }
                
            }.padding(8)
            .foregroundColor(.green)
        }.onAppear(perform: getItStarted)
        //}
    }
}

struct PollenCastView_Previews: PreviewProvider {
    static var previews: some View {
        PollenCastView()
    }
}
