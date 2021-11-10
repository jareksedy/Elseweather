//
//  IndexView.swift
//  Elseweather
//
//  Created by Jarek Šedý on 29.09.2021.
//

import SwiftUI

struct IndexView: View {
    var caption: String
    var value: String
    var units: String?
    var body: some View {
        Group {
            HStack {
                VStack(alignment: .leading) {
                    Text("\(caption)")
                        .kerning(-0.25)
                        .textStyle(SmallMonospaced())
                        .lineLimit(1)
                    
                    Divider(1)
                        .padding(.bottom, 2)
                    
                    Text("\(value) \(units ?? "")")
                        .kerning(-0.25)
                        .textStyle(SmallMonospaced())
                        .lineLimit(1)
                }
            }
        }
    }
}
