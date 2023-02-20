//
//  CommonTypes.swift
//

import Foundation

public typealias VoidClosure = () -> Void
public typealias VoidInputClosure<O> = () -> O
public typealias VoidOutputClosure<I> = (I) -> Void
public typealias Closure<I, O> = (I) -> O

public enum ApiError: Error {
    case emptyData
    case generic(Error)
    case graphQL
}
