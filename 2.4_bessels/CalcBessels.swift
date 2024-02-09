//
//  CalcBessels.swift
//  2.4_bessels
//
//  Created by PHYS 440 Rachelle on 2/3/24.
//

import Foundation
import Observation

@Observable class BesselFunctionCalculator {
    
    //vars for quick use in calculating relative difference
    var downDouble = 0.0
    var upDouble = 0.0
    
    /* Calculate Bessel functions using downward recursion */
    /// calculateDownwardRecursion
    /// - Parameters:
    ///   - xValue: x
    ///   - order: Order of Bessel Function
    ///   - start: Starting Order
    ///               2l
    ///     J       (x)  =   ------ J  (x)   -  J        (x)
    ///      l - 1              x       l             l + 1
    ///
    ///
    func calculateDownwardRecursion (xValue: Double, order: Int, start: Int) async -> (direction: String, xValue: Double, order: Int, start: Int, besselValue: Double)
    {
        var scale = await calculateFirstBessel(xValue: xValue) /* jSub0 which we know. Used for scaling/normalizing the downward recursion */
        
        var jSubl = Array(repeating: 0.0, count: start + 2) /* jSubl is an array that holds the various orders of the Bessel Function, array of zeros here */
        
        
        jSubl[start+1] = 1.0                   // start with "guess" guess for the largest J value
        jSubl[start] = 1.0                      // start with "guess" guess for the second largest
        
        for index in (1...start).reversed(){
            
            jSubl[index-1] = ((2.0*(Double(index))+1)/xValue)*jSubl[index] - jSubl[index+1]
        }
        
        scale = (scale)/jSubl[0]      /* scale the result */
        
        let downwardBessel = jSubl[order]*(scale)
        downDouble = downwardBessel
        
        return((direction: "Downward", xValue: xValue, order: order, start: start, besselValue: downwardBessel))
    }


    /* Calculate Bessel functions using upward recursion */
    /// calculateUpwardRecursion
    /// - Parameters:
    ///   - xValue: x
    ///   - order: Order of Bessel Function
    ///                2l
    ///     J          (x)  =   ------  J  (x)  -  J       (x)
    ///       l + 1              x        l            l - 1
    ///
    ///
    func calculateUpwardRecursion (xValue: Double, order: Int) async -> (direction: String, xValue: Double, order: Int, start: Int, besselValue: Double)
    {
        var firstBessel = 0.0  /* temporary placeholders through the upward recursion */
        var secondBessel = 0.0 /* temporary placeholders through the upward recursion */
        var thirdBessel = 0.0; /* holds final Bessel Function result */
        
        
        firstBessel = await calculateFirstBessel(xValue: xValue)                    /* start with lowest order */
        if (order == 0) {
            thirdBessel = firstBessel
        }
        else {
            
            secondBessel = await calculateSecondBessel(xValue: xValue)
            for index in (1..<order)             /* loop for order of function */
            {
                thirdBessel = ((2.0*(Double(index))+1)/xValue)*secondBessel - firstBessel       // recursion relation
                firstBessel = secondBessel
                secondBessel = thirdBessel
            }
        }
        
        let upwardBessel = thirdBessel
        
        upDouble = upwardBessel
        
        return((direction: "Upward", xValue: xValue, order: order, start: 0, besselValue: upwardBessel))
    }



    /// calculateFirstBessel
    /// - Parameter xValue: x
    /// - Returns: first Bessel Function
    //
    //    J   (x) = sin(x)/x
    //      0
    func calculateFirstBessel (xValue: Double) async -> Double{
        
        let j_0 = sin(xValue)/xValue
        return j_0
        
    }


    /// calculateSecondBessel
    /// - Parameter xValue: x
    /// - Returns: second Bessel Function
    //                    
    //      sin(x) - cos(x)
    //    J   ---      ---
    //     1     2
    //        x        x
    //
    func calculateSecondBessel (xValue: Double) async -> Double{
        
        let j_1 = sin(xValue)/pow(xValue, 2) - cos(xValue)/xValue
        return j_1
        
    }
    
    
}
