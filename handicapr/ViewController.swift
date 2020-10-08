//
//  ViewController.swift
//  handicapr
//
//  Created by Jered Leisey on 10/7/20.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
	
	let DATA_KEY_JERED = "data_key_jered"
	let DATA_KEY_JEFF = "data_key_jeff"
	
	@IBOutlet weak var jeredR1: UILabel!
	@IBOutlet weak var jeredR2: UILabel!
	@IBOutlet weak var jeredR3: UILabel!
	@IBOutlet weak var jeredHC: UILabel!
	@IBOutlet weak var jeffR1: UILabel!
	@IBOutlet weak var jeffR2: UILabel!
	@IBOutlet weak var jeffR3: UILabel!
	@IBOutlet weak var jeffHC: UILabel!
	@IBOutlet weak var jeredNewScore: UITextField!
	@IBOutlet weak var jeffNewScore: UITextField!
	
	var jeredScoreSet: [String] = []
	var jeffScoreSet: [String] = []
	
	override func viewDidLoad() {
		super.viewDidLoad()
		if let jeredLoadedScores = UserDefaults.standard.stringArray(forKey: DATA_KEY_JERED) {
			jeredScoreSet.append(contentsOf: jeredLoadedScores)
		}
		
		if let jeffLoadedScores = UserDefaults.standard.stringArray(forKey: DATA_KEY_JEFF) {
			jeffScoreSet.append(contentsOf: jeffLoadedScores)
		}
		
		if !jeredScoreSet.isEmpty {
			jeredR1.text = jeredScoreSet[0]
			jeredR2.text = jeredScoreSet[1]
			jeredR3.text = jeredScoreSet[2]
		}
		
		if !jeffScoreSet.isEmpty {
			jeffR1.text = jeffScoreSet[0]
			jeffR2.text = jeffScoreSet[1]
			jeffR3.text = jeffScoreSet[2]
		}
		
		// Do any additional setup after loading the view.
		jeredNewScore.delegate = self
		jeffNewScore.delegate = self
		calcHandicap()
	}

	@IBAction func addScoreClicked(_ sender: UIButton) {
		jeredR1.text = jeredR2.text
		jeredR2.text = jeredR3.text
		jeredR3.text = jeredNewScore.text
		jeredNewScore.text = ""
		
		jeffR1.text = jeffR2.text
		jeffR2.text = jeffR3.text
		jeffR3.text = jeffNewScore.text
		jeffNewScore.text = ""
		
		calcHandicap()
		
		jeredScoreSet.removeAll()
		jeffScoreSet.removeAll()
		jeredScoreSet.append(jeredR1.text!)
		jeredScoreSet.append(jeredR2.text!)
		jeredScoreSet.append(jeredR3.text!)
		jeffScoreSet.append(jeffR1.text!)
		jeffScoreSet.append(jeffR2.text!)
		jeffScoreSet.append(jeffR3.text!)
		UserDefaults.standard.set(jeredScoreSet, forKey: DATA_KEY_JERED)
		UserDefaults.standard.set(jeffScoreSet, forKey: DATA_KEY_JEFF)
	}
	
	func calcHandicap() {
		let jerScores = [Int(jeredR1.text!), Int(jeredR2.text!), Int(jeredR3.text!)]
		let jeffScores = [Int(jeffR1.text!), Int(jeffR2.text!), Int(jeffR3.text!)]
		let jerHC = ((jerScores[0]! + jerScores[1]! + jerScores[2]!) / 3)
		let jefHC = ((jeffScores[0]! + jeffScores[1]! + jeffScores[2]!) / 3)
		
		jeredHC.text = String(jerHC)
		jeffHC.text = String(jefHC)
	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		view.endEditing(true)
	}
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		view.endEditing(true)
		return false
	}
	

}

