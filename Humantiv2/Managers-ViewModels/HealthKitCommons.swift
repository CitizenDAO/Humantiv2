//
//  HealthKitCommons.swift
//  HealthKitMonitoringWorkshop
//
//  Created by Mark Pruit on 2/25/21.
//

import Foundation
import HealthKit

class HealthKitCommons {
    static let symptoms: [HKCategoryTypeIdentifier] = [ .chestTightnessOrPain, .rapidPoundingOrFlutteringHeartbeat, .acne, .drySkin, .hairLoss, .hotFlashes, .breastPain, .pelvicPain, .vaginalDryness, .abdominalCramps, .bloating, .constipation, .diarrhea, .heartburn, .nausea, .vomiting, .appetiteChanges, .chills, .fatigue, .fever, .generalizedBodyAche, .bladderIncontinence, .lowerBackPain, .headache, .dizziness, .memoryLapse, .moodChanges, .shortnessOfBreath, .coughing, .wheezing, .lossOfSmell, .lossOfTaste, .runnyNose, .soreThroat, .sinusCongestion, .nightSweats,.sleepChanges
    ]
    
    static let healthKitTypesToRead : Set<HKSampleType> = [
        //Height & Weight
        //HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.height)!,
        HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyMass)!,
        //Resp Measures
        HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.oxygenSaturation)!,
        //HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.forcedVitalCapacity)!,
        //HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.forcedExpiratoryVolume1)!,
        //HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.peakExpiratoryFlowRate)!,
        //Heart Measures
        HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate)!,
        HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRateVariabilitySDNN)!,
        HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bloodPressureDiastolic)!,
        HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bloodPressureSystolic)!,
        //HKSampleType.electrocardiogramType(),
        //Audio Measures
        HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.environmentalAudioExposure)!,
        //Steps & Activity
        HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!,
        HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.activeEnergyBurned)!,
        HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.distanceWalkingRunning)!,
        //HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.sixMinuteWalkTestDistance)!,
        //HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.distanceCycling)!,
        //HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.distanceSwimming)!,
        //HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.distanceDownhillSnowSports)!,
        //HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.distanceWheelchair)!,
        //HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.flightsClimbed)!,
        //HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.appleStandTime)!,
        //HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.numberOfTimesFallen)!,
        //HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.walkingStepLength)!,
        //HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.walkingAsymmetryPercentage)!,
        //HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.walkingDoubleSupportPercentage)!,
        //HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.walkingSpeed)!,
        //HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stairAscentSpeed)!,
        //HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stairDescentSpeed)!,
        HKQuantityType.workoutType(),
        //Temperature
        HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyTemperature)!,
        //Blood sugar
        HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bloodGlucose)!,
        HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.insulinDelivery)!,
        HKSampleType.categoryType(forIdentifier: HKCategoryTypeIdentifier.sleepAnalysis)!,
        
        HKSampleType.categoryType(forIdentifier: HKCategoryTypeIdentifier.mindfulSession)!,
        
        //**************** Symptoms ***********************

        //CV
        HKSampleType.categoryType(forIdentifier: HKCategoryTypeIdentifier.chestTightnessOrPain)!,
        HKSampleType.categoryType(forIdentifier: HKCategoryTypeIdentifier.rapidPoundingOrFlutteringHeartbeat)!,
        HKSampleType.categoryType(forIdentifier: HKCategoryTypeIdentifier.fainting)!,
        HKSampleType.categoryType(forIdentifier: HKCategoryTypeIdentifier.skippedHeartbeat)!,
        
        //Derm
        HKSampleType.categoryType(forIdentifier: HKCategoryTypeIdentifier.acne)!,
        HKSampleType.categoryType(forIdentifier: HKCategoryTypeIdentifier.drySkin)!,
        HKSampleType.categoryType(forIdentifier: HKCategoryTypeIdentifier.hairLoss)!,
        
        //Female / Gyn
        HKSampleType.categoryType(forIdentifier: HKCategoryTypeIdentifier.hotFlashes)!,
        HKSampleType.categoryType(forIdentifier: HKCategoryTypeIdentifier.breastPain)!,
        HKSampleType.categoryType(forIdentifier: HKCategoryTypeIdentifier.pelvicPain)!,
        HKSampleType.categoryType(forIdentifier: HKCategoryTypeIdentifier.vaginalDryness)!,
        
        //GI/Abdominal
        HKSampleType.categoryType(forIdentifier: HKCategoryTypeIdentifier.abdominalCramps)!,
        HKSampleType.categoryType(forIdentifier: HKCategoryTypeIdentifier.bloating)!,
        HKSampleType.categoryType(forIdentifier: HKCategoryTypeIdentifier.constipation)!,
        HKSampleType.categoryType(forIdentifier: HKCategoryTypeIdentifier.diarrhea)!,
        HKSampleType.categoryType(forIdentifier: HKCategoryTypeIdentifier.heartburn)!,
        HKSampleType.categoryType(forIdentifier: HKCategoryTypeIdentifier.nausea)!,
        HKSampleType.categoryType(forIdentifier: HKCategoryTypeIdentifier.vomiting)!,
        HKSampleType.categoryType(forIdentifier: HKCategoryTypeIdentifier.appetiteChanges)!,
        
        //General
        HKSampleType.categoryType(forIdentifier: HKCategoryTypeIdentifier.chills)!,
        HKSampleType.categoryType(forIdentifier: HKCategoryTypeIdentifier.fatigue)!,
        HKSampleType.categoryType(forIdentifier: HKCategoryTypeIdentifier.fever)!,
        HKSampleType.categoryType(forIdentifier: HKCategoryTypeIdentifier.generalizedBodyAche)!,
        
        //GU
        HKSampleType.categoryType(forIdentifier: HKCategoryTypeIdentifier.bladderIncontinence)!,
        
        //MS
        HKSampleType.categoryType(forIdentifier: HKCategoryTypeIdentifier.lowerBackPain)!,
        
        //Neuro
        HKSampleType.categoryType(forIdentifier: HKCategoryTypeIdentifier.headache)!,
        HKSampleType.categoryType(forIdentifier: HKCategoryTypeIdentifier.dizziness)!,
        HKSampleType.categoryType(forIdentifier: HKCategoryTypeIdentifier.memoryLapse)!,
        
        
        //Psych
        HKSampleType.categoryType(forIdentifier: HKCategoryTypeIdentifier.moodChanges)!,
        
        //Resp
        HKSampleType.categoryType(forIdentifier: HKCategoryTypeIdentifier.shortnessOfBreath)!,
        HKSampleType.categoryType(forIdentifier: HKCategoryTypeIdentifier.coughing)!,
        HKSampleType.categoryType(forIdentifier: HKCategoryTypeIdentifier.wheezing)!,
        
        HKSampleType.categoryType(forIdentifier: HKCategoryTypeIdentifier.lossOfSmell)!,
        HKSampleType.categoryType(forIdentifier: HKCategoryTypeIdentifier.lossOfTaste)!,
        HKSampleType.categoryType(forIdentifier: HKCategoryTypeIdentifier.runnyNose)!,
        HKSampleType.categoryType(forIdentifier: HKCategoryTypeIdentifier.soreThroat)!,
        HKSampleType.categoryType(forIdentifier: HKCategoryTypeIdentifier.sinusCongestion)!,
        
        //Sleep
        HKSampleType.categoryType(forIdentifier: HKCategoryTypeIdentifier.nightSweats)!,
        HKSampleType.categoryType(forIdentifier: HKCategoryTypeIdentifier.sleepChanges)!,
 
        ]

    static let healthKitTypesToWrite: Set<HKSampleType> = [
        HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bloodPressureDiastolic)!,
        HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bloodPressureSystolic)!,
        //HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.oxygenSaturation)!,
        //HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bloodGlucose)!,
        //HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.insulinDelivery)!,
        //HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyTemperature)!,
        //Height & Weight
        //HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.height)!,
        HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyMass)!,
        HKQuantityType.workoutType(),
        //Symptoms
        //CV
        HKSampleType.categoryType(forIdentifier: HKCategoryTypeIdentifier.chestTightnessOrPain)!,
        HKSampleType.categoryType(forIdentifier: HKCategoryTypeIdentifier.rapidPoundingOrFlutteringHeartbeat)!,
        HKSampleType.categoryType(forIdentifier: HKCategoryTypeIdentifier.fainting)!,
        HKSampleType.categoryType(forIdentifier: HKCategoryTypeIdentifier.skippedHeartbeat)!,
        
        //Derm
        HKSampleType.categoryType(forIdentifier: HKCategoryTypeIdentifier.acne)!,
        HKSampleType.categoryType(forIdentifier: HKCategoryTypeIdentifier.drySkin)!,
        HKSampleType.categoryType(forIdentifier: HKCategoryTypeIdentifier.hairLoss)!,
        
        //Female / Gyn
        HKSampleType.categoryType(forIdentifier: HKCategoryTypeIdentifier.hotFlashes)!,
        HKSampleType.categoryType(forIdentifier: HKCategoryTypeIdentifier.breastPain)!,
        HKSampleType.categoryType(forIdentifier: HKCategoryTypeIdentifier.pelvicPain)!,
        HKSampleType.categoryType(forIdentifier: HKCategoryTypeIdentifier.vaginalDryness)!,
        
        //GI/Abdominal
        HKSampleType.categoryType(forIdentifier: HKCategoryTypeIdentifier.abdominalCramps)!,
        HKSampleType.categoryType(forIdentifier: HKCategoryTypeIdentifier.bloating)!,
        HKSampleType.categoryType(forIdentifier: HKCategoryTypeIdentifier.constipation)!,
        HKSampleType.categoryType(forIdentifier: HKCategoryTypeIdentifier.diarrhea)!,
        HKSampleType.categoryType(forIdentifier: HKCategoryTypeIdentifier.heartburn)!,
        HKSampleType.categoryType(forIdentifier: HKCategoryTypeIdentifier.nausea)!,
        HKSampleType.categoryType(forIdentifier: HKCategoryTypeIdentifier.vomiting)!,
        HKSampleType.categoryType(forIdentifier: HKCategoryTypeIdentifier.appetiteChanges)!,
        
        //General
        HKSampleType.categoryType(forIdentifier: HKCategoryTypeIdentifier.chills)!,
        HKSampleType.categoryType(forIdentifier: HKCategoryTypeIdentifier.fatigue)!,
        HKSampleType.categoryType(forIdentifier: HKCategoryTypeIdentifier.fever)!,
        HKSampleType.categoryType(forIdentifier: HKCategoryTypeIdentifier.generalizedBodyAche)!,
        
        //GU
        HKSampleType.categoryType(forIdentifier: HKCategoryTypeIdentifier.bladderIncontinence)!,
        
        //MS
        HKSampleType.categoryType(forIdentifier: HKCategoryTypeIdentifier.lowerBackPain)!,
        
        //Neuro
        HKSampleType.categoryType(forIdentifier: HKCategoryTypeIdentifier.headache)!,
        HKSampleType.categoryType(forIdentifier: HKCategoryTypeIdentifier.dizziness)!,
        HKSampleType.categoryType(forIdentifier: HKCategoryTypeIdentifier.memoryLapse)!,
        
        
        //Psych
        HKSampleType.categoryType(forIdentifier: HKCategoryTypeIdentifier.moodChanges)!,
        
        //Resp
        HKSampleType.categoryType(forIdentifier: HKCategoryTypeIdentifier.shortnessOfBreath)!,
        HKSampleType.categoryType(forIdentifier: HKCategoryTypeIdentifier.coughing)!,
        HKSampleType.categoryType(forIdentifier: HKCategoryTypeIdentifier.wheezing)!,
        
        HKSampleType.categoryType(forIdentifier: HKCategoryTypeIdentifier.lossOfSmell)!,
        HKSampleType.categoryType(forIdentifier: HKCategoryTypeIdentifier.lossOfTaste)!,
        HKSampleType.categoryType(forIdentifier: HKCategoryTypeIdentifier.runnyNose)!,
        HKSampleType.categoryType(forIdentifier: HKCategoryTypeIdentifier.soreThroat)!,
        HKSampleType.categoryType(forIdentifier: HKCategoryTypeIdentifier.sinusCongestion)!,
        
        //Sleep
        HKSampleType.categoryType(forIdentifier: HKCategoryTypeIdentifier.nightSweats)!,
        HKSampleType.categoryType(forIdentifier: HKCategoryTypeIdentifier.sleepChanges)!,
    ]
}

extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()

        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }

    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
}
