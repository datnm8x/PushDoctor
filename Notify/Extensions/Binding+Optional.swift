//
//  Binding+Optional.swift
//  Notify
//
//  Created by William McGinty on 7/25/20.
//

import Foundation
import SwiftUI

func OptionalBinding<T>(_ binding: Binding<T?>, _ defaultValue: T) -> Binding<T> {
    return Binding<T>(get: {
        return binding.wrappedValue ?? defaultValue
    }, set: {
        binding.wrappedValue = $0
    })
}

func ??<T> (left: Binding<T?>, right: T) -> Binding<T> {
    return OptionalBinding(left, right)
}
