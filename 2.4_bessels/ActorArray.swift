//
//  ActorArray.swift
//  Regular-Bessel-Function-Observation
//

import Foundation

actor ActorArray {
    var myResults :[(direction: String, xValue: Double, order: Int, start: Int, besselValue: Double)] = []


    func appendArrays(arrayToAppend: [(direction: String, xValue: Double, order: Int, start: Int, besselValue: Double)]) -> [(direction: String, xValue: Double, order: Int, start: Int, besselValue: Double)] {
        myResults = arrayToAppend
        return myResults
    }
    
    func returnActorArray() -> [(direction: String, xValue: Double, order: Int, start: Int, besselValue: Double)] {
        return myResults
    }
}
