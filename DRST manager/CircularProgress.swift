//
//  CircularProgress.swift
//  DRST manager
//
//  Created by 김승호 on 31/07/2019.
//  Copyright © 2019 Seungho Kim. All rights reserved.
//

import UIKit

class CircularProgress: UIView {
  var progress: CGFloat = 0
  
  public init() {
    super.init(frame: CGRect(x: 0, y: 0, width: 320, height: 320))
    self.progress = 0
  }
  
  public init(_ progress: CGFloat) {
    super.init(frame: CGRect(x: 0, y: 0, width: 320, height: 320))
    self.progress = progress
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.progress = 0
  }
  
  public override func draw(_ rect: CGRect) {
    guard let context = UIGraphicsGetCurrentContext() else { return }
    context.setLineWidth(15.0)
    context.setLineCap(.round)
    context.setStrokeColor(UIColor.systemBlue.cgColor)
    context.addArc(center: CGPoint(x: 160, y: 160), radius: 120, startAngle: deg2rad(-90), endAngle: deg2rad(360 * progress - 90), clockwise: false)
    context.strokePath()
  }
  
  func deg2rad(_ number: CGFloat) -> CGFloat {
    return number * .pi / 180
  }
  
  public func update(progress: CGFloat) {
    self.progress = progress
    self.setNeedsDisplay()
  }
}
