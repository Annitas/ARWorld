//
//  ViewController.swift
//  WorldTracking
//
//  Created by Anita Stashevskaya on 19.07.2022.
//

import UIKit
import ARKit

class ViewController: UIViewController {

    @IBOutlet var sceneView: ARSCNView!
    let configuration = ARWorldTrackingConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let plusButton = UIButton()
        //plusButton.frame = CGRect(x: self.view.frame.size.width/2 - 12, y: self.view.frame.size.height-60, width: 35, height: 35)
        plusButton.setImage(UIImage(named: "plus.png"), for: .normal)
        plusButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        self.view.addSubview(plusButton)
        
        plusButton.translatesAutoresizingMaskIntoConstraints = false //delete previous
        //let topAnchor = plusButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 80)
        let bottomAnchor = plusButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 280)
        let leftAnchor = plusButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: -15)
        //let rightAnchor = plusButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 40)
        let heightAnchor = plusButton.heightAnchor.constraint(equalTo: view.heightAnchor, constant: 35)
        let widthAnchor = plusButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: 35)
        NSLayoutConstraint.activate([bottomAnchor, leftAnchor, heightAnchor, widthAnchor])
        
        
        
        self.sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]
        //world origin is the starting position in the real world
        self.sceneView.session.run(configuration)
        //plusButton.widthAnchor.constraint(equalToConstant: 35).isActive = true
        //plusButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        // Do any additional setup after loading the view.
    }
    
    @objc func buttonAction(sender: UIButton!) {
      print("Button tapped")
    }

    override var prefersStatusBarHidden: Bool {
            return true
    }

}

