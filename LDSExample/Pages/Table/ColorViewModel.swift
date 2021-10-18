//
//  ColorViewModel.swift
//  LDSExample
//
//  Created by GGsrvg on 18.10.2021.
//

import UIKit.UIColor
import LDS

final class ColorViewModel {
    
    typealias SectionItemType = SectionItem<Void, UIColor, Void>
    
    private var colors: [UIColor] = [
        .init(rgb: 0xff0000),
        .init(rgb: 0xff4000),
        .init(rgb: 0xff8000),
        .init(rgb: 0xffbf00),
        .init(rgb: 0xffff00),
        .init(rgb: 0xbfff00),
        .init(rgb: 0x80ff00),
        .init(rgb: 0x40ff00),
        .init(rgb: 0x00ff00),
        .init(rgb: 0x00ff40),
        .init(rgb: 0x00ff80),
        .init(rgb: 0x00ffbf),
        .init(rgb: 0x00ffff),
        .init(rgb: 0x00bfff),
        .init(rgb: 0x0080ff),
        .init(rgb: 0x0040ff),
        .init(rgb: 0x0000ff),
        .init(rgb: 0x4000ff),
        .init(rgb: 0x8000ff),
        .init(rgb: 0xbf00ff),
        .init(rgb: 0xff00ff),
        .init(rgb: 0xff00bf),
        .init(rgb: 0xff0080),
        .init(rgb: 0xff0040),
    ]
    
    let observable: LDS.ObservableDataSource<SectionItemType> = .init()
    private lazy var section: SectionItemType = .init(header: (), rows: self.colors, footer: ())
    
    init() {
        self.colors = self.colors.shuffled()
        self.observable.set([section])
    }
    
    func sort() {
        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + .milliseconds(300), execute: {
            for i in 0..<(self.section.rows.count) {
                for j in 1..<(self.section.rows.count - i) {
                    let jValue = self.section.rows[j]
                    let temp = self.section.rows[j - 1]

                    if jValue.hue < temp.hue {
                        DispatchQueue.main.sync {
                            self.section.replaceRow(jValue, at: j - 1)
                            self.section.replaceRow(temp, at: j)
                        }
                    }
                }
            }
        })
    }
    
}
