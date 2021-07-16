//
//  ActivittyGraph.swift
//  StravaGraph
//
//  Created by Mark Pruit on 3/25/21.
//

import SwiftUI

struct ActivityGraph: View {
    
    //var parentGeometry: GeometryProxy
    
    var logs: [ActivityLog]
    var logs2: [ActivityLog]
    var logs3: [ActivityLog]
    
    @State var lg = [Color(red: 251/255, green: 82/255, blue: 0), .white]
    
        @Binding var selectedIndex: Int
    //@Binding var selectedIndexHrv: Int
        
        @State var lineOffset: CGFloat = 8 // Vertical line offset
        @State var selectedXPos: CGFloat = 8 // User X touch location
        @State var selectedYPos: CGFloat = 0 // User Y touch location
        @State var isSelected: Bool = false // Is the user touching the graph
        
  
    
    func drawGrid() -> some View {
        VStack(spacing: 0) {
            Color.black
                .frame(height: 1, alignment: .center)
            HStack(spacing: 0) {
                Color.clear
                    .frame(width: 8, height: 150)
                //ForEach(0..<11) { i in
                ForEach(0..<(logs.count - 1)) { i in
                    Color.black
                        .frame(width: 1, height: 150, alignment: .center)
                    Spacer()

                }
                Color.black
                    .frame(width: 1, height: 150, alignment: .center)
                Color.clear
                    .frame(width: 8, height: 150)
            }
            Color.black
                .frame(height: 1, alignment: .center)
        }
    }
    
    func drawActivityGradient(logs: [ActivityLog]) -> some View {
        //guard logs.count > 0 else { return EmptyView()}
        //LinearGradient(gradient: Gradient(colors: [Color(red: 251/255, green: 82/255, blue: 0), .white]),
        //LinearGradient(gradient: Gradient(colors: logs[0].lg), startPoint: .top, endPoint: .bottom)
        /*
        DispatchQueue.main.async {
            switch logs[0].logType {
                case "hrLog":
                    lg = [.gray, .gray]
                case "aeLog":
                    lg = [.purple, .purple]
                case "stepsLog":
                    lg = [.orange, .orange]
                default:
                    lg = [.red, .white]
            }
        }*/
        return LinearGradient(gradient: Gradient(colors: logs[0].lg), startPoint: .top, endPoint: .bottom)
            .padding(.horizontal, 8)
            .padding(.bottom, 1)
            .opacity(0.8)
            .mask(
                GeometryReader { parentGeometry in
                     Path { p in
                        // Used for scaling graph data
                        let maxNum = logs.reduce(0) { (res, log) -> Double in
                            return max(res, log.value)
                        }

                        //let scale = geo.size.height / CGFloat(maxNum)
                        let scale = parentGeometry.size.height / CGFloat(maxNum)

                        //Week Index used for drawing (0 - (logs.count - 1))
                        var index: CGFloat = 0

                        // Move to the starting y-point on graph
                        p.move(to: CGPoint(x: 8, y: parentGeometry.size.height -
                            (CGFloat(logs[Int(index)].value) * scale)))
                        // For each week draw line from previous week
                        //**
                        for _ in logs {
                            if index != 0 {
                                p.addLine(to: CGPoint(x: 8 + ((parentGeometry.size.width - 16) / CGFloat(logs.count - 1)) * index, y: parentGeometry.size.height -
                                    (CGFloat(logs[Int(index)].value) * scale)))
                            }
                            index += 1
                        }

                        // Finally close the subpath off by looping around to the beginning point.
                        //**
                        p.addLine(to: CGPoint(x: 8 + ((parentGeometry.size.width - 16) / CGFloat(logs.count - 1)) * (index - 1), y: parentGeometry.size.height))
                        p.addLine(to: CGPoint(x: 8, y: parentGeometry.size.height))
                        p.closeSubpath()
                    }
                }
            )
    }
    
    
    func drawActivityLine(logs: [ActivityLog]) -> some View {
        GeometryReader { parentGeometry in
            Path { p in
                let maxNum = logs.reduce(0) { (res, log) -> Double in
                    //return max(res, log.distance)
                    return max(res, log.value)
                }

                let scale = parentGeometry.size.height / CGFloat(maxNum)
                var index: CGFloat = 0

                p.move(to: CGPoint(x: 8, y: parentGeometry.size.height -
                    (CGFloat(logs[0].value) * scale)))

                for _ in logs {
                    if index != 0 {
                        p.addLine(to: CGPoint(x: 8 + ((parentGeometry.size.width - 16) / CGFloat(logs.count - 1)) * index, y: parentGeometry.size.height -
                            (CGFloat(logs[Int(index)].value) * scale)))
                    }
                    index += 1
                }
            }
            .stroke(style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round, miterLimit: 80, dash: [], dashPhase: 0))
            //.foregroundColor(Color(red: 251/255, green: 82/255, blue: 0))
            .foregroundColor(.red)
        }
    }
    
    func drawLogPoints(logs: [ActivityLog]) -> some View {
        GeometryReader { parentGeometry in

            let maxNum = logs.reduce(0) { (res, log) -> Double in
                return max(res, log.value)
            }

            let scale = parentGeometry.size.height / CGFloat(maxNum)

            ForEach(logs.indices) { i in
                Circle()
                    .stroke(style: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round, miterLimit: 80, dash: [], dashPhase: 0))
                    
                    //.foregroundColor(Color(red: 251/255, green: 82/255, blue: 0))
                    .foregroundColor(.red)
                    .background(Color.white)
                    .cornerRadius(5)
                    .offset(x: 8 + ((parentGeometry.size.width - 16) / CGFloat(logs.count - 1)) * CGFloat(i) - 5, y: (parentGeometry.size.height - (CGFloat(logs[i].value) * scale)) - 5)
                    .frame(width: 10, height: 10, alignment: .center)
            }
        }
    }

    
    func addUserInteraction(logs: [ActivityLog]) -> some View {
        GeometryReader { parentGeometry in
            
            let logsCount = CGFloat(logs.count - 1)
            
            let maxNum = logs.reduce(0) { (res, log) -> Double in
                //return max(res, log.distance)
                return max(res, log.value)
            }
            
            let scale = parentGeometry.size.height / CGFloat(maxNum)
            
            ZStack(alignment: .leading) {
                // Line and point overlay
                //Color(red: 251/255, green: 82/255, blue: 0)
                Color(.white)
                    .frame(width: 2)
                    .overlay(
                        Circle()
                            .frame(width: 24, height: 24, alignment: .center)
                            //.foregroundColor(Color(red: 251/255, green: 82/255, blue: 0))
                            .foregroundColor(.red)
                            .opacity(0.2)
                            .overlay(
                                Circle()
                                    .fill()
                                    .frame(width: 12, height: 12, alignment: .center)
                                    //.foregroundColor(Color(red: 251/255, green: 82/255, blue: 0))
                                    .foregroundColor(.red)
                            )
                            //
                            .offset(x: 0, y: isSelected ? CGFloat(logs.count) - (selectedYPos * scale) : CGFloat(logs.count) - (CGFloat(logs[selectedIndex].value) * scale))
                        , alignment: .bottom)
                    
                    .offset(x: isSelected ? lineOffset : 8 + ((parentGeometry.size.width - 16) / CGFloat(logs.count - 1)) * CGFloat(selectedIndex), y: 0)
                    .animation(Animation.spring().speed(4))
                
                // Future Drag Gesture Code
                Color.white.opacity(0.1)
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { touch in
                                let xPos = touch.location.x
                                self.isSelected = true
                                //let index = (xPos - 8) / (((geo.size.width - 16) / 11))
                                let index = (xPos - 8) / (((parentGeometry.size.width - 16) / CGFloat(logsCount)))
                                
                                //if index > 0 && index < 11 {
                                if index > 0 && index < logsCount {
                                    let m = (logs[Int(index) + 1].value - logs[Int(index)].value)
                                    self.selectedYPos = CGFloat(m) * index.truncatingRemainder(dividingBy: 1) + CGFloat(logs[Int(index)].value)
                                }
                                
                                
                                //if index.truncatingRemainder(dividingBy: 1) >= 0.5 && index < 11 {
                                if index.truncatingRemainder(dividingBy: 1) >= 0.5 && index < logsCount {
                                    self.selectedIndex = Int(index) + 1
                                } else {
                                    self.selectedIndex = Int(index)
                                }
                                self.selectedXPos = min(max(8, xPos), parentGeometry.size.width - 8)
                                self.lineOffset = min(max(8, xPos), parentGeometry.size.width - 8)
                            }
                            .onEnded { touch in
                                let xPos = touch.location.x
                                self.isSelected = false
                                //let index = (xPos - 8) / (((geo.size.width - 16) / 11))
                                let index = (xPos - 8) / (((parentGeometry.size.width - 16) / CGFloat(logsCount)))
                                
                                //if index.truncatingRemainder(dividingBy: 1) >= 0.5 && index < 11 {
                                if index.truncatingRemainder(dividingBy: 1) >= 0.5 && index < logsCount {
                                    self.selectedIndex = Int(index) + 1
                                } else {
                                    self.selectedIndex = Int(index)
                                }
                            }
                    )
            }
        }
    }
    
    var body: some View {
        if logs.count > 0 && logs2.count > 0 && logs3.count > 0 {
        drawGrid()
            .opacity(0.3)
            //.overlay(drawActivityGradient(logs: logs))
            .overlay(drawActivityGradient(logs: logs3))
            //.opacity(0.5)
            .overlay(drawActivityGradient(logs: logs2))
            .overlay(drawActivityLine(logs: logs))
            .overlay(drawLogPoints(logs: logs))
            .overlay(addUserInteraction(logs: logs))
        } else {
            EmptyView()
        }
    }
}

/*
struct ActivityGraph_Previews: PreviewProvider {
    static var previews: some View {
        //ActivityGraph(parentGeometry: nil, logs: [ActivityLog](), logs2: [ActivityLog](), logs3: [ActivityLog](), selectedIndex: .constant(0))
    }
}*/

