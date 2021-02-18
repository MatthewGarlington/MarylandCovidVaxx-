//
//  LottieView.swift
//  CovidVaccMD
//
//  Created by Matthew Garlington on 2/18/21.
//

import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
    typealias UIViewType = UIView
    // Let the fileName be chosen upon call
    
    var filename: String
    
    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView {
        
        let view = UIView(frame: .zero)
        
        let animationView = AnimationView()
        // Add the Lottie animation
        let animation = Animation.named(filename)
        animationView.animation = animation
        // Set the Aspect Ratio
        animationView.contentMode = .scaleAspectFit
        // Play the Lottie Animation
        animationView.play()
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        
        // Add the animation view as a subview of View
        
        view.addSubview(animationView)
        
        // Set Constraints
        
        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
            
        
        ])
        
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<LottieView>) {
        
    }
    

}

