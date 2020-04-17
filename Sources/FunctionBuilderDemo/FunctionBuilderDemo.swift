import Foundation

@_functionBuilder
public struct StringBuilder {
    public static func buildBlock() -> String {
        return ".empty"
    }
    
    public static func buildBlock(_ item: String) -> String {
        return ".single(\(item))"
    }
    
    public static func buildBlock(_ items: String...) -> String {
        return "[\(items.joined(separator: ", "))]"
    }
    
    ///
    
    public static func buildIf(_ value: String?) -> String {
        return ".if(\(value ?? "nil"))"
    }
    
    public static func buildEither(first value: String) -> String {
        return ".left(\(value)"
    }
    public static func buildEither(second value: String) -> String {
        return ".right(\(value)"
        
    }
    
    ///
    
    public static func buildExpression(_ expression: String) -> String {
        return ".s(\(expression))"
    }
    
    public static func buildExpression(_ expression: Int) -> String {
        return ".i(\(expression))"
    }
    
    public static func buildExpression(_ expression: Float) -> String {
        return ".f(\(expression))"
    }
    
    public static func buildExpression(_ expression: Double) -> String {
        return ".d(\(expression))"
    }
    
    ///
    
    public static func buildDo(_ value: String) -> String {
        return ".do(\(value))"
    }
}
