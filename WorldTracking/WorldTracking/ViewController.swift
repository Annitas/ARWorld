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
        self.sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]
        //world origin is the starting position in the real world
        self.sceneView.session.run(configuration)
        // Do any additional setup after loading the view.
    }

    override var prefersStatusBarHidden: Bool {
            return true
    }

}

