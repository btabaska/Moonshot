//
//  ContentView.swift
//  Moonshot
//
//  Created by Brandon Tabaska on 6/22/20.
//  Copyright © 2020 Brandon Tabaska. All rights reserved.
//

import SwiftUI

let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
let missions: [Mission] = Bundle.main.decode("missions.json")

struct ContentView: View {
    var body: some View {
        NavigationView {
            List(missions) { mission in
                NavigationLink(destination:
                    MissionView(mission: mission,
                                astronauts: astronauts)) {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)
                    
                    VStack(alignment: .leading) {
                        Text(mission.displayName)
                            .font(.headline)
                        Text(mission.formattedLaunchDate)
                    }
                }
            }
        .navigationBarTitle("Moonshot")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
