// DO NOT EDIT.
// swift-format-ignore-file
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: run.proto
//
// For information on using the generated types, please see the documentation:
//   https://github.com/apple/swift-protobuf/

import Foundation
import SwiftProtobuf

// If the compiler emits an error on this type, it is because this file
// was generated by a version of the `protoc` Swift plug-in that is
// incompatible with the version of SwiftProtobuf to which you are linking.
// Please ensure that you are building against the same version of the API
// that was used to generate this file.
fileprivate struct _GeneratedWithProtocGenSwiftVersion: SwiftProtobuf.ProtobufAPIVersionCheck {
  struct _2: SwiftProtobuf.ProtobufAPIVersion_2 {}
  typealias Version = _2
}

public struct FunctionParams {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  public var name: String = String()

  public var success: Bool = false

  public var data: Data = Data()

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}
}

public struct Result {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  public var success: Bool = false

  public var result: Data = Data()

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}
}

#if swift(>=5.5) && canImport(_Concurrency)
extension FunctionParams: @unchecked Sendable {}
extension Result: @unchecked Sendable {}
#endif  // swift(>=5.5) && canImport(_Concurrency)

// MARK: - Code below here is support for the SwiftProtobuf runtime.

extension FunctionParams: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = "FunctionParams"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "name"),
    2: .same(proto: "success"),
    3: .same(proto: "data"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularStringField(value: &self.name) }()
      case 2: try { try decoder.decodeSingularBoolField(value: &self.success) }()
      case 3: try { try decoder.decodeSingularBytesField(value: &self.data) }()
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.name.isEmpty {
      try visitor.visitSingularStringField(value: self.name, fieldNumber: 1)
    }
    if self.success != false {
      try visitor.visitSingularBoolField(value: self.success, fieldNumber: 2)
    }
    if !self.data.isEmpty {
      try visitor.visitSingularBytesField(value: self.data, fieldNumber: 3)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: FunctionParams, rhs: FunctionParams) -> Bool {
    if lhs.name != rhs.name {return false}
    if lhs.success != rhs.success {return false}
    if lhs.data != rhs.data {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Result: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = "Result"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "success"),
    2: .same(proto: "result"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularBoolField(value: &self.success) }()
      case 2: try { try decoder.decodeSingularBytesField(value: &self.result) }()
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if self.success != false {
      try visitor.visitSingularBoolField(value: self.success, fieldNumber: 1)
    }
    if !self.result.isEmpty {
      try visitor.visitSingularBytesField(value: self.result, fieldNumber: 2)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: Result, rhs: Result) -> Bool {
    if lhs.success != rhs.success {return false}
    if lhs.result != rhs.result {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}
