//
//  Promise+Then.swift
//  Bluebird
//
//  Created by Andrew Barba on 10/1/16.
//  Copyright © 2016 Andrew Barba. All rights reserved.
//

extension Promise {

    /// Perform an operation on a Promise once it resolves. The chain will then resolve to the Promise returned from the handler
    ///
    /// - parameter queue:   dispatch queue to run the handler on
    /// - parameter handler: block to run when Promise resolved, returns a Promsie that mutates the Promise chain
    ///
    /// - returns: Promise
    public func then<A>(on queue: DispatchQueue = .main, _ handler: @escaping (Result) throws -> Promise<A>) -> Promise<A> {
        return Promise<A> { resolve, reject in
            addHandler(on: queue, {
                do {
                    try handler($0).addHandler(resolve, reject)
                } catch {
                    return reject(error)
                }
            }, {
                reject($0)
            })
        }
    }

    /// Perform an operation on a Promise once it resolves. The chain will then resolve to the Promise returned from the handler
    ///
    /// - parameter queue:   dispatch queue to run the handler on
    /// - parameter handler: block to run when Promise resolved, returns a Promsie that mutates the Promise chain
    ///
    /// - returns: Promise
    public func then<A>(on queue: DispatchQueue = .main, _ handler: @escaping (Result) throws -> A) -> Promise<A> {
        return then(on: queue) {
            try Promise<A>(resolve: handler($0))
        }
    }

    /// Perform an operation on a Promise once it resolves. The chain will then resolve to the Promise returned from the handler
    ///
    /// - parameter queue:   dispatch queue to run the handler on
    /// - parameter handler: block to run when Promise resolved, returns a Promsie that mutates the Promise chain
    ///
    /// - returns: Promise
    @discardableResult
    public func then(on queue: DispatchQueue = .main, _ handler: @escaping (Result) throws -> Void) -> Promise<Void>{
        return self.then(on: queue) {
            try Promise<Void>(resolve: handler($0))
        }
    }
}