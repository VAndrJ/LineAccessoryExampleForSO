//
//  TestView.swift
//  TestLayout
//
//  Created by VAndrJ on 3/11/18.
//  Copyright © 2018 VAndrJ. All rights reserved.
//

import UIKit

class TestView: UIView {
    @objc dynamic var multiplier: CGFloat = 0 {
        didSet {
            assert((0...1) ~= multiplier, "Multiplier must be in 0...1 range")
            animateMultiplier()
        }
    }
    var testLayer: TestViewLayer {
        return self.layer as! TestViewLayer
    }
    var animationDuration: TimeInterval = 0.5

    private func animateMultiplier() {
        let animation = CABasicAnimation(keyPath: "multiplier")
        animation.fromValue = testLayer.multiplier
        animation.toValue = multiplier
        animation.duration = animationDuration
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        self.layer.add(animation, forKey: "multiplier")
        testLayer.multiplier = multiplier
    }

    override class var layerClass: AnyClass {
        return TestViewLayer.self
    }
}

class TestViewLayer: CALayer {
    override class func needsDisplay(forKey key: String) -> Bool {
        if key == "multiplier" {
            return true
        }
        return super.needsDisplay(forKey: key)
    }

    @objc dynamic var multiplier: CGFloat = 0

    override func draw(in ctx: CGContext) {
        super.draw(in: ctx)
        UIGraphicsPushContext(ctx)
        // Set line color
        UIColor.gray.setStroke()
        let path = UIBezierPath()
        let lineWidth: CGFloat = min(bounds.height / 3, bounds.width / 3)
        path.lineWidth = lineWidth
        path.lineCapStyle = .round
        path.lineJoinStyle = .round
        path.move(to: .init(x: bounds.minX + lineWidth, y: bounds.minY + lineWidth))
        path.addLine(to: .init(x: bounds.midX, y: (bounds.maxY - 2 * lineWidth) * multiplier + lineWidth))
        path.addLine(to: .init(x: bounds.maxX - lineWidth, y: bounds.minY + lineWidth))
        path.stroke()
        UIGraphicsPopContext()
    }
}
