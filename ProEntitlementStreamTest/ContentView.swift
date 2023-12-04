//
//  ContentView.swift
//  ProEntitlementStreamTest
//
//  Created by Jon Duenas on 12/4/23.
//

import Dependencies
import DependenciesMacros
import SwiftUI

// Expansion of this macro will show a public initializer available
@DependencyClient
public struct ProEntitlementStream {
    public var entitlement: () -> AsyncStream<Bool> = { .never }
}

extension ProEntitlementStream: DependencyKey {
    public static let liveValue = ProEntitlementStream {
        .finished
    }
}

class Model {
    private var proStream: ProEntitlementStream

    init(proStream: ProEntitlementStream) {
        self.proStream = proStream
    }
}

struct ContentView: View {
    let model: Model

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

// This preview fails to build: 'ProEntitlementStream' cannot be constructed because it has no accessible initializers
#Preview {
    ContentView(model: Model(proStream: ProEntitlementStream(entitlement: {
            AsyncStream<Bool>.never
        })
    ))
}

// This preview works fine
struct ContentView_PreviewProvider: PreviewProvider {
    static var previews: some View {
        ContentView(model: Model(proStream: ProEntitlementStream(entitlement: {
                AsyncStream<Bool>.never
            })
        ))
    }
}
