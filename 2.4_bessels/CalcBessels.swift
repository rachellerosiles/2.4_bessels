//
//  CalcBessels.swift
//  2.4_bessels
//
//  Created by PHYS 440 Rachelle on 2/3/24.
//

import Foundation
import Observation

@Observable class CalcBessels {
    
    func calcJ0(xValue: Double) -> Double {
        return sin(xValue)/xValue
    }
    
    func calcJ1(xValue: Double) -> Double {
        return sin(xValue)/pow(xValue, 2)
    }
    
    func calcDown(x: Double, order: Int) {
        
    }
    
}
