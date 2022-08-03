//
//  ViewController.swift
//  WorldTracking
//
//  Created by Anita Stashevskaya on 19.07.2022.
//

import UIKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    let configuration = ARWorldTrackingConfiguration()
    
    var startingPositionNode: SCNNode?
    var endingPositionNode: SCNNode?
    let cameraRelativePosition = SCNVector3(x: 0, y: 0, z: -0.1)
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let plusButton = UIButton()
        plusButton.setImage(UIImage(named: "plus.png"), for: .normal)
        plusButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        self.view.addSubview(plusButton)
        plusButton.translatesAutoresizingMaskIntoConstraints = false //delete previous
        plusButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        plusButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
        let distanceLabel = UILabel()
        distanceLabel.font = UIFont.boldSystemFont(ofSize: 14)
        distanceLabel.textColor = UIColor.black
        distanceLabel.text = "Distance: "
        self.view.addSubview(distanceLabel)
        distanceLabel.translatesAutoresizingMaskIntoConstraints = false //delete previous
        distanceLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        distanceLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        let xLabel = UILabel()
        xLabel.font = UIFont.boldSystemFont(ofSize: 14)
        xLabel.textColor = UIColor.red
        xLabel.text = "x: "
        self.view.addSubview(xLabel)
        xLabel.translatesAutoresizingMaskIntoConstraints = false //delete previous
        xLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        xLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 6).isActive = true

        let yLabel = UILabel()
        yLabel.font = UIFont.boldSystemFont(ofSize: 14)
        yLabel.textColor = UIColor.green
        yLabel.text = "y: "
        self.view.addSubview(yLabel)
        yLabel.translatesAutoresizingMaskIntoConstraints = false //delete previous
        yLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        yLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 30).isActive = true

        let zLabel = UILabel()
        zLabel.font = UIFont.boldSystemFont(ofSize: 14)
        zLabel.textColor = UIColor.blue
        zLabel.text = "z: "
        self.view.addSubview(zLabel)
        zLabel.translatesAutoresizingMaskIntoConstraints = false //delete previous
        zLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        zLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        
        let centerImageView = UIImageView()
        centerImageView.image = UIImage(named: "centerPlus.png")//попросить плюсик
        //centerImageView.setImage(UIImage(named: "centerPlus.png"))
        centerImageView.contentMode = .scaleAspectFill
        self.view.addSubview(centerImageView)
        centerImageView.translatesAutoresizingMaskIntoConstraints = false //delete previous
        centerImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        centerImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        self.sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]
        configuration.planeDetection = .horizontal
        //world origin is the starting position in the real world
        self.sceneView.session.run(configuration)
        sceneView.autoenablesDefaultLighting = true //shadows
        sceneView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    @objc func buttonAction(sender: UIButton!) {
        print("Button tapped")
        handleTap()
//        addBox()
    }
    
//    func addBox() {
//        let boxNode = SCNNode()
//        boxNode.geometry = SCNBox(width: 0.05, height: 0.05, length: 0.05, chamferRadius: 0.003)
//        boxNode.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "silver.jpeg")
//        boxNode.position = SCNVector3(x: Float.random(in: -0.5 ..< 0.5), y: Float.random(in: -0.5 ..< 0.5), z: Float.random(in: -0.5 ..< 0.5))
//        sceneView.scene.rootNode.addChildNode(boxNode)
//    }

    override var prefersStatusBarHidden: Bool {
            return true
    }
    
//    func createFloor(anchor: ARPlaneAnchor) -> SCNNode {
//        let floor = SCNNode()
//        floor.name = "floor"
//        floor.eulerAngles = SCNVector3(90*3.14/180, 0, 0)
//        floor.geometry = SCNPlane(width: CGFloat(anchor.extent.x), height: CGFloat(anchor.extent.z))
//        floor.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "silver.jpeg")
//        floor.geometry?.firstMaterial?.isDoubleSided = true
//        floor.position = SCNVector3(anchor.center.x, anchor.center.y, anchor.center.z)
//        return floor
//    }
//
//    func removeFloor(named: String) {
//        sceneView.scene.rootNode.enumerateChildNodes{ (node, _) in
//            if node.name == named {
//                node.removeFromParentNode()
//            }
//        }
//    }

    @objc func handleTap() { //sender: UITapGestureRecognizer
//        let tappedView = sender.view as! SCNView
//        let touchLocation = sender.location(in: tappedView)
//        let hitTest = tappedView.hitTest(touchLocation, options: nil)
//        if !hitTest.isEmpty {
//            let result = hitTest.first!
//            let name = result.node.name
//            let geometry = result.node.geometry
//            print("Tapped \(String(describing: name)) with geometry: \(String(describing: geometry))")
//        }
        if startingPositionNode != nil && endingPositionNode != nil {
            startingPositionNode?.removeFromParentNode()
            endingPositionNode?.removeFromParentNode()
            startingPositionNode = nil
            endingPositionNode = nil
        } else if startingPositionNode != nil && endingPositionNode == nil {
            let sphere = SCNNode(geometry: SCNSphere(radius: 0.005))
            sphere.geometry?.firstMaterial?.diffuse.contents = UIColor.purple
            Service.addChildNode(sphere, toNode: sceneView.scene.rootNode, inView: sceneView, cameraRelativePosition: cameraRelativePosition)
            endingPositionNode = sphere//add sphere as ending position
        } else if startingPositionNode == nil && endingPositionNode == nil {
            let sphere = SCNNode(geometry: SCNSphere(radius: 0.005))
            sphere.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "silver.jpeg")
            Service.addChildNode(sphere, toNode: sceneView.scene.rootNode, inView: sceneView, cameraRelativePosition: cameraRelativePosition)
            startingPositionNode = sphere//add sphere as starting position
        }
        
    }
    
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let anchorPlane = anchor as? ARPlaneAnchor else {return}
        print("New Plane Anchor found with extent ", anchorPlane.extent) //extent has xyz values
        //let floor = createFloor(anchor: anchorPlane)
        //node.addChildNode(floor)
    }

    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let anchorPlane = anchor as? ARPlaneAnchor else {return}
        print("New Plane Anchor updated with extent ", anchorPlane.extent)
        //removeFloor(named: "floor")
        //let floor = createFloor(anchor: anchorPlane)
        //node.addChildNode(floor)
    }

}

