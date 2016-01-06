//
//  ATSmartBezierPath+Smoothing.swift
//  ATSketchKit
//
//  Created by Arnaud Thiercelin on 12/29/15.
//  Copyright © 2015 Arnaud Thiercelin. All rights reserved.
//
// This Catmull-Rom implem was inspired by Joshua Weinberg 
// http://stackoverflow.com/questions/8702696/drawing-smooth-curves-methods-needed/8731493#8731493
// who was inspired by Erica Sadun

import Foundation

extension ATSmartBezierPath {
	
	func smoothPath(granularity: Int) -> UIBezierPath {
		var points = self.points
		if points.count < 4 {
			let newPath = UIBezierPath()
			
			if points.count > 0 {
				for index in 0...points.count - 1 {
					if index == 0 {
						newPath.moveToPoint(points[index])
					} else {
						newPath.addLineToPoint(points[index])
					}
				}
			}
			
			return newPath
		}
		
		// Add control points
		points.insert(points[0], atIndex: 0)
		points.append(points.last!)
		
		let newPath = UIBezierPath()
		newPath.moveToPoint(points[0])
		
		for pointIndex in 1...points.count - 3 {
			let point0 = points[pointIndex - 1]
			let point1 = points[pointIndex]
			let point2 = points[pointIndex + 1]
			let point3 = points[pointIndex + 2]
			
			// now we add n points starting at point1 + dx/dy up until point2 using Catmull-Rom splines
			for index in 1...granularity {
				let t = CGFloat(index) * (1.0 / CGFloat(granularity))
				let tt = CGFloat(t * t)
				let ttt = CGFloat(tt * t)
				
				var intermediatePoint = CGPoint()
				
				let xt = (point2.x - point0.x) * t
				let xtt = (2 * point0.x - 5 * point1.x + 4 * point2.x - point3.x) * tt
				let xttt = (3 * point1.x - point0.x - 3 * point2.x + point3.x) * ttt
				intermediatePoint.x = 0.5 * (2 * point1.x + xt + xtt + xttt )
				let yt = (point2.y - point0.y) * t
				let ytt = (2 * point0.y - 5 * point1.y + 4 * point2.y - point3.y) * tt
				let yttt = (3 * point1.y - point0.y - 3 * point2.y + point3.y) * ttt
				intermediatePoint.y = 0.5 * (2 * point1.y + yt + ytt + yttt)
				newPath.addLineToPoint(intermediatePoint)
			}
			newPath.addLineToPoint(point2)
		}
		newPath.addLineToPoint(points.last!)
		
		return newPath
	}
}