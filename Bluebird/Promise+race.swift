//
//  Promise+race.swift
//  Bluebird
//
//  Created by Andrew Barba on 10/1/16.
//  Copyright © 2016 Andrew Barba. All rights reserved.
//

/// Identical to `all`, but does not throw an error for an empty array of Promises
///
/// - parameter promises: promises to resolve
///
/// - returns: Promise
public func race<A>(_ promises: Promise<A>...) -> Promise<A> {
    return race(promises)
}

/// Identical to `all`, but does not throw an error for an empty array of Promises
///
/// - parameter promises: promises to resolve
///
/// - returns: Promise
public func race<A>(_ promises: [Promise<A>]) -> Promise<A> {
    return Promise<A> { resolve, reject in
        promises.forEach {
            $0.addHandlers([
                .resolve(.main, resolve),
                .reject(.main, reject)
            ])
        }
    }
}
