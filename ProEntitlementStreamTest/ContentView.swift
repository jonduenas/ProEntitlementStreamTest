//
//  ContentView.swift
//  ProEntitlementStreamTest
//
//  Created by Jon Duenas on 12/4/23.
//

import Dependencies
import DependenciesMacros
import SwiftUI

extension DependencyValues {
    public var proEntitlementStream: ProEntitlementStream {
        get { self[ProEntitlementStream.self] }
        set { self[ProEntitlementStream.self] = newValue }
    }
}

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
    @Dependency(\.proEntitlementStream) private var proStream
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

#Preview {
    ContentView(model: withDependencies {
        $0.proEntitlementStream = ProEntitlementStream(entitlement: {
            AsyncStream<Bool>.never
        })
    } operation: {
        Model()
    })
}
