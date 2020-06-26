//
//  MissionView.swift
//  Moonshot
//
//  Created by Brandon Tabaska on 6/25/20.
//  Copyright © 2020 Brandon Tabaska. All rights reserved.
//

import Foundation
import SwiftUI

struct MissionView: View {
    
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    
    let mission: Mission
    let astronauts: [CrewMember]
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(self.mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geometry.size.width * 0.7)
                        .padding(.top)
                    
                    Text(self.mission.formattedLaunchDate)
                    
                    Text(self.mission.description)
                        .padding()
                        .layoutPriority(1)
                    
                    ForEach(self.astronauts, id: \.role) {
                        CrewMember in
                        NavigationLink(destination: AstronautView(astronaut: CrewMember.astronaut, missions: missions)) {
                            HStack {
                                Image(CrewMember.astronaut.id)
                                    .resizable()
                                    .frame(width: 83, height: 60)
                                    .clipShape(Capsule())
                                    .overlay(Capsule().stroke(Color.primary, lineWidth: 1))
                                
                                VStack(alignment: .leading) {
                                    Text(CrewMember.astronaut.name)
                                        .font(.headline)
                                    
                                    Text(CrewMember.role)
                                        .foregroundColor(.secondary)
                                }
                                Spacer()
                                    
                            }
                            .padding(.horizontal)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    
                    Spacer(minLength: 25)
                }
            }
        }
        .navigationBarTitle(Text(mission.displayName), displayMode: .inline)
    }
    
    init(mission: Mission, astronauts: [Astronaut]) {
        self.mission = mission
        
        var matches = [CrewMember]()
        
        for member in mission.crew {
            if let match = astronauts.first(where: {$0.id == member.name}) {
                matches.append(CrewMember(role: member.role, astronaut: match))
            } else {
                fatalError("Missing \(member)")
            }
        }
        
        self.astronauts = matches
        for match in matches {
            print(match)
        }
    }
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")

    static var previews: some View {
        MissionView(mission: missions[0], astronauts: astronauts)
    }
}
