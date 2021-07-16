//
//  HealthTypesSelectionView.swift
//  Humantiv2
//
//  Created by Mark Pruit on 7/4/21.
//

import SwiftUI
import HealthKit

struct HealthTypesSelectionView: View {
    @Binding var showHealthTypesSelection: Bool
    @ObservedObject var hkm: HealthKitManager
    //make this a Realm array with hi /lo values etc
    @State var ingredients: [Ingredient] = [Ingredient(name: "Heart Rate"), Ingredient(name: "Steps"), Ingredient(name: "Activity"), Ingredient(name: "Heart Rate Variability"), Ingredient(name: "O2 Saturation"), Ingredient(name: "Mindfulness"), Ingredient(name: "Weight"), Ingredient(name: "Blood Pressure"), Ingredient(name: "Sleep")]
    
    func setUpSelections() {
        ingredients.enumerated().forEach { (index, element) in
            if hkm.healthMeasurables.contains(element.name) {
                ingredients[index].isSelected = true
            }
        }
        hkm.healthMeasurables.removeDuplicates()
    }
    
    var body: some View {
        VStack (alignment: .leading) {
            Spacer()
                .frame(height: 16)
            HStack {
                Spacer()
                    .frame(width: 10)
            VStack {
                Text("Health Measures")
                    .fontWeight(.heavy)
                    .font(.title)
            }.padding()
            .background(Color.green)
            .cornerRadius(10)
        }
            Text("Tap on a row below to select / deselect a health measure to follow.")
                .fontWeight(.heavy)
                .font(.headline)
                .fixedSize(horizontal: false, vertical: true)
                .padding()
        List{
            ForEach(0..<ingredients.count){ index in
                HStack {
                    Button(action: {
                        ingredients[index].isSelected = ingredients[index].isSelected ? false : true
                        
                        if ingredients[index].isSelected == true {
                            hkm.healthMeasurables.append(ingredients[index].name)
                        } else {
                            if hkm.healthMeasurables.contains(ingredients[index].name) {
                                
                                self.hkm.healthMeasurables = self.hkm.healthMeasurables.filter { $0 != ingredients[index].name }
                            }
                        }
                    }) {
                        HStack{
                            if ingredients[index].isSelected {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                                    .animation(.easeIn)
                            } else {
                                Image(systemName: "circle")
                                    .foregroundColor(.primary)
                                    .animation(.easeOut)
                            }
                            Text(ingredients[index].name)
                        }
                    }.buttonStyle(BorderlessButtonStyle())
                }
            }
        }.onAppear(perform: {
            setUpSelections()
        })
    }
    }
}

struct HealthTypesSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        HealthTypesSelectionView(showHealthTypesSelection: .constant(false), hkm: HealthKitManager())
    }
}


struct Ingredient{
    var id = UUID()
    var name: String
    var isSelected: Bool = false
}

struct HealthMeasure {
    var id: Int
    var name: String
    var healthKitType: HKSampleType
}
