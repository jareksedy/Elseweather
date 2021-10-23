//
//  LocationAccessMessageView.swift
//  Elseweather
//
//  Created by Jarek Šedý on 24.10.2021.
//

import SwiftUI

struct LocationAccessMessageView: View {
    var body: some View {
        Text("Grant access to your location →".uppercased())
            .textStyle(SmallMonospaced())
            .opacity(disabledButtonOpacity)
    }
}

struct LocationAccessMessageView_Previews: PreviewProvider {
    static var previews: some View {
        LocationAccessMessageView().preferredColorScheme(.dark)
    }
}
