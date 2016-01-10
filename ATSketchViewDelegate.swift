//
//  ATSketchViewDelegate.swift
//  ATSketchKit
//
//  Created by Arnaud Thiercelin on 1/10/16.
//  Copyright © 2016 Arnaud Thiercelin. All rights reserved.
//

import Foundation

protocol ATSketchViewDelegate {

	/**
	Asks the delegate if the score received during the recognition means the view should accept the recognition.
	
	- Parameter sketchView: the view in which the drawing was performed
	- Parameter score: the recognizing score. Generally speak, 50.0 is a decent value for it.
	- Returns: a true/false value.
	*/
	func sketchView(sketchView: ATSketchView, shouldAccepterRecognizedPathWithScore score: CGFloat) -> Bool
}