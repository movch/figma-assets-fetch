@propertyWrapper
struct SkipEncode<T> {
   var wrappedValue: T
}

extension SkipEncode: Decodable where T: Decodable {
   init(from decoder: Decoder) throws {
      let container = try decoder.singleValueContainer()
      self.wrappedValue = try container.decode(T.self)
   }
}

extension SkipEncode: Encodable {
   func encode(to encoder: Encoder) throws {
      // nothing to do here
   }
}

extension KeyedEncodingContainer {
   mutating func encode<T>(_ value: SkipEncode<T>, forKey key: K) throws {
      // overload, but do nothing
   }
}
