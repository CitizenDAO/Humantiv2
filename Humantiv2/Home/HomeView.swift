//
//  RadarChartView.swift
//  DynamicViewsTesting
//
//  Created by Mark Pruit on 6/5/21.
//

import Foundation
import SwiftUI
import HealthKit

struct HomeView: View {
    @StateObject var db = DataBroadcaster()
    @StateObject var hkm = HealthKitManager()
    
    @State var showHGraph = false
    @State var inProcess = false
    @State var hScore = 0
    @State var circleGradient = LinearGradient(gradient: Gradient(colors: [.blue, .green, .green, .green]), startPoint: .top, endPoint: .bottom)

    let gridColor: Color
    let dataColor: Color
    
    let formatter = DateFormatter()
    let timeFormatter = DateFormatter()
    
    init(gridColor: Color = .gray, dataColor: Color = .blue) {
        self.gridColor = gridColor
        self.dataColor = dataColor
    }
    
    func startItUp() {
        showHGraph = false
       // hkm.healthMeasurables.removeDuplicates()
        inProcess = true
        hkm.startItUp { success in
            let tGoal = Double(hkm.humantiveData.count) * 10
            let hSum = db.normalizeHD2(hData: hkm.humantiveData).0.reduce(0, +)
        let pct = hSum / tGoal
        
        let prehScore = 1000 * pct
        hScore = Int(prehScore)
        
        //self.showHGraph = true
        
        switch hScore {
        
        case 200..<499:
            circleGradient = LinearGradient(gradient: Gradient(colors: [.red, .orange, .orange, .green]), startPoint: .top, endPoint: .bottom)
        case 500..<799:
            circleGradient = LinearGradient(gradient: Gradient(colors: [.red, .purple, .orange, .green]), startPoint: .top, endPoint: .bottom)
        case 800..<999:
            circleGradient = LinearGradient(gradient: Gradient(colors: [.blue, .purple, .green, .green]), startPoint: .top, endPoint: .bottom)
        case 1000:
            circleGradient = LinearGradient(gradient: Gradient(colors: [.blue, .green, .green, .green]), startPoint: .top, endPoint: .bottom)
        default:
            circleGradient = LinearGradient(gradient: Gradient(colors: [.red, .orange, .orange, .orange]), startPoint: .top, endPoint: .bottom)
        }
            
            self.showHGraph = true
            inProcess = false
            
            //temp save to User Defaults
            let defaults = UserDefaults.standard
            defaults.set(self.hkm.healthMeasurables, forKey: "healthMeasurables")
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                KRefreshScrollView(progressTint: .green, arrowTint: .green) {
                    ZStack {
                        Color(.gray)
                            .opacity(0.1)
                            .ignoresSafeArea()
                        VStack {
                            Spacer()
                                .frame(height: 10)
                            HStack {
                                MeditView(db: db)
                                    .frame(width: geometry.size.width * 0.95)
                            }
                            HGHeaderView( hkm: hkm)
                                .padding(.top)
                                .frame(width: geometry.size.width * 0.95)
                            if showHGraph {
                            VStack {
                                ZStack {
                                    Circle()
                                        .stroke(circleGradient, lineWidth: 30)
                                        .opacity(0.3)
                                        .frame(width: 175, height: 175, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    
                                    
                                        RadarChartGrid(db: db, hkm: hkm, categories: hkm.humantiveData.count, divisions: hkm.humantiveData.count)
                                            .stroke(gridColor, lineWidth: 0.5)
                                            .opacity(0.02)
                                            .frame(width: 175, height: 175, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                        
                                        RadarChartPath(db: db, hkm: hkm, data: db.normalizeHD().0)
                                            .fill(RadialGradient(gradient: Gradient(colors: [.white, .white, .blue, .blue, .blue]), center: .center, startRadius: 0, endRadius: 175))
                                            .frame(width: 175, height: 175, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                            .opacity(0.1)
                                        
                                        RadarChartPath(db: db, hkm: hkm, data: db.normalizeHD2(hData: hkm.humantiveData).0)
                                            .stroke(dataColor, lineWidth: 1.0)
                                            .opacity(0.4)
                                            .frame(width: 175, height: 175, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                        
                                        Text(String(hScore))
                                            .font(.system(size: 50, weight: .bold, design: .default))
                                            .foregroundColor(.green)
                                            .opacity(0.8)
                                        
                                        HealthTypes(db: db, hkm: hkm)
                                            .frame(width: 300, height: 300)
                                    //} else {
                                        //BreathAnimation()
                                    //}
                               //}
                                   }
                                    }
                            
                            .frame(width: geometry.size.width * 0.95)
                            .background(Color.white)
                            .cornerRadius(10.0)
                                   //}
                                Group {
                            HGFooterView()
                                .frame(width: geometry.size.width * 0.95)
                            MyStatsHeaderView()
                                .frame(width: geometry.size.width * 0.95)
                            StatsView(db: db, hkm: hkm)
                                .frame(width: geometry.size.width * 0.95)
                                .cornerRadius(10.0)
                            SleepHeaderView()
                                .frame(width: geometry.size.width * 0.95)
                            SleepAnalysisView(hkModel: hkm)
                                .frame(width: geometry.size.width * 0.95)
                                .cornerRadius(10.0)
                                }
                            MoodHeaderView()
                                    .frame(width: geometry.size.width * 0.95)
                            MoodSelectionView(crop: geometry)
                                .frame(width: geometry.size.width * 0.95)
                            EnvironmentalHeaderView()
                                .frame(width: geometry.size.width * 0.95)
                            PollenCastView()
                                .frame(width: geometry.size.width * 0.95)
                                .cornerRadius(10.0)
                            } else {
                                BreathAnimation()
                                    .frame(height: 300)
                           }
                                //}
                            //}
                        }.onAppear(perform: {
                            startItUp()
                        })
                    //}
                    }.navigationTitle("Humantiv")
                    .onChange(of: self.hkm.healthMeasurables, perform: { value in
                        if inProcess == false {
                        
                            startItUp()
                        }
                    })
                        
                } onUpdate: {
                    
                    startItUp()
                }
            }
        }
    }
}
