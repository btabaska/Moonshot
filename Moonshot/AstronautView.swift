//
//  AstronautView.swift
//  Moonshot
//
//  Created by Brandon Tabaska on 6/25/20.
//  Copyright © 2020 Brandon Tabaska. All rights reserved.
//

import SwiftUI
struct AstronautView: View {
    let astronaut: Astronaut
    
    struct CrewMission {
        let displayname: String
        let mission: Mission
    }
    
    let missions: [CrewMission]
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)
                    
                    Text(self.astronaut.description)
                        .padding()
                        .layoutPriority(1)
                    
                    ForEach(self.missions, id: \.displayname ) {
                        CrewMission in
                        VStack {
                            Text(CrewMission.mission.displayName)
                        }
                    }
                }
            }
        }
        .navigationBarTitle(Text(astronaut.name),
                            displayMode: .inline)
    }
    init(astronaut: Astronaut, missions: [Mission]) {
        self.astronaut = astronaut
        print(self.astronaut.id)
        
        var matches = [CrewMission]()
        
        for mission in missions {
            for crew in mission.crew {
                if self.astronaut.id == crew.name {
                    print(mission.displayName)
                    matches.append(CrewMission(displayname: mission.displayName, mission: mission))
                }
            }
            
        }
        for match in matches {
            print(match)
            print("\n")
        }
        self.missions = matches
    
        
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    static let mission: [Mission] = Bundle.main.decode("missions.json")
    static var previews: some View {
        AstronautView(astronaut: astronauts[0], missions: mission)
    }
}
