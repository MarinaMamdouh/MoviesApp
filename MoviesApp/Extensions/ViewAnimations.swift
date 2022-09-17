//
//  ViewAnimations.swift
//  MoviesApp
//
//  Created by Marina on 17/09/2022.
//

import UIKit

extension UIView{
    
    // Default Entry Animation ( fade in and animation from top y shift )
    func entryAnimation(){
        entryAnimation(withDuration: 0.7, delay: 0.2)
    }
    
    // Entry Animation with custom param duration, delay but default y value shift
    func entryAnimation(withDuration:Double, delay:Double){
        entryAnimation(withDuration: withDuration, delay: delay, yShift: 50)
    }
    
    // Entry Animation with custom param duration, delay and y value shift
    func entryAnimation(withDuration:Double, delay:Double , yShift:Double){
        // shift the view center to the top by yshift
        self.center.y -= yShift
        // make the view fully transparent(hidden)
        self.alpha = 0
        UIView.animate(withDuration: withDuration, delay: delay, options: [.curveEaseOut, .transitionFlipFromBottom]) {
            // bring the alpha to its normal and return the view center to its original state
            self.alpha = 1
            self.center.y += yShift
        } completion: { sucess in
            
        }
    }
    
    
}
