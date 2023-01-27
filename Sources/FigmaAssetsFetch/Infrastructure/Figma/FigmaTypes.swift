// https://github.com/quicktype/figma-types
//
// To parse the JSON, add this file to your project and do:
//
//   let fileResponse = try FileResponse(json)
//   let commentsResponse = try CommentsResponse(json)
//   let commentRequest = try CommentRequest(json)
//   let projectsResponse = try ProjectsResponse(json)
//   let projectFilesResponse = try ProjectFilesResponse(json)

import Foundation

public struct FigmaImages: Codable {
    let images: [String: String]
}

/// GET /v1/files/:key
///
/// > Description
///
/// Returns the document refered to by :key as a JSON object. The file key can be parsed from
/// any Figma file url: https://www.figma.com/file/:key/:title. The "document" attribute
/// contains a Node of type DOCUMENT.
///
/// The "components" key contains a mapping from node IDs to component metadata. This is to
/// help you determine which components each instance comes from. Currently the only piece of
/// metadata available on components is the name of the component, but more properties will
/// be forthcoming.
///
/// > Path parameters
///
/// key String
/// File to export JSON from
public struct FileResponse: Codable {
    /// The root node within the document
    public let document: DocumentClass
    public let schemaVersion: Double
    public let styles: [String: Style]
}

/// GET /v1/files/:key/nodes
///
/// > Description
///
/// Returns the nodes referenced to by :ids as a JSON object. The nodes are retrieved from the Figma file referenced to by :key.
///
public struct FileNodesResponse: Codable {
    public let nodes: [String: FileResponse]
    public let name: String
}

// MARK: - Style

public struct Style: Codable {
    let key, name: String
    let styleType: StyleType
    let styleDescription: String

    enum CodingKeys: String, CodingKey {
        case key, name, styleType
        case styleDescription = "description"
    }
}

public enum StyleType: String, Codable {
    case fill = "FILL"
    case text = "TEXT"
}

/// A node that can have instances created of it that share the same properties
/// A description of a master component. Helps you identify which component
/// instances are attached to
public struct Component: Codable {
    /// Bounding box of the node in absolute space coordinates
    public let absoluteBoundingBox: Rect
    /// Background color of the node
    public let backgroundColor: FigmaColor
    /// How this node blends with nodes behind it in the scene
    /// (see blend mode section for more details)
    public let blendMode: BlendMode
    /// An array of nodes that are direct children of this node
    public let children: [FigmaDocument]
    /// Does this node clip content outside of its bounds?
    public let clipsContent: Bool
    /// Horizontal and vertical layout constraints for node
    public let constraints: LayoutConstraint
    /// The description of the component as entered in the editor
    public let description: String
    /// An array of effects attached to this node
    /// (see effects section for more details)
    public let effects: [Effect]
    /// An array of export settings representing images to export from node
    public let exportSettings: [ExportSetting]
    /// a string uniquely identifying this node within the document
    public let id: String
    /// Does this node mask sibling nodes in front of it?
    public let isMask: Bool
    /// An array of layout grids attached to this node (see layout grids section
    /// for more details). GROUP nodes do not have this attribute
    public let layoutGrids: [LayoutGrid]
    /// The name of the component
    public let name: String
    /// Opacity of the node
    public let opacity: Double?
    /// Keep height and width constrained to same ratio
    public let preserveRatio: Bool
    /// Node ID of node to transition to in prototyping
    public let transitionNodeID: String?
    /// the type of the node, refer to table below for details
    public let type: NodeType
    /// whether or not the node is visible on the canvas
    public let visible: Bool?
}

/// Bounding box of the node in absolute space coordinates
///
/// A rectangle that expresses a bounding box in absolute coordinates
public struct Rect: Codable {
    /// Height of the rectangle
    public let height: Double
    /// Width of the rectangle
    public let width: Double
    /// X coordinate of top left corner of the rectangle
    public let x: Double
    /// Y coordinate of top left corner of the rectangle
    public let y: Double
}

/// Background color of the node
///
/// An RGBA color
///
/// Background color of the canvas
///
/// Solid color of the paint
///
/// Color attached to corresponding position
///
/// Color of the grid
public struct FigmaColor: Codable {
    /// Alpha channel value, between 0 and 1
    public var a: Double
    /// Blue channel value, between 0 and 1
    public var b: Double
    /// Green channel value, between 0 and 1
    public var g: Double
    /// Red channel value, between 0 and 1
    public var r: Double
}

/// How this node blends with nodes behind it in the scene
/// (see blend mode section for more details)
///
/// Enum describing how layer blends with layers below
/// This type is a string enum with the following possible values
public enum BlendMode: String, Codable {
    case color = "COLOR"
    case colorBurn = "COLOR_BURN"
    case colorDodge = "COLOR_DODGE"
    case darken = "DARKEN"
    case difference = "DIFFERENCE"
    case exclusion = "EXCLUSION"
    case hardLight = "HARD_LIGHT"
    case hue = "HUE"
    case lighten = "LIGHTEN"
    case linearBurn = "LINEAR_BURN"
    case linearDodge = "LINEAR_DODGE"
    case luminosity = "LUMINOSITY"
    case multiply = "MULTIPLY"
    case normal = "NORMAL"
    case overlay = "OVERLAY"
    case passThrough = "PASS_THROUGH"
    case saturation = "SATURATION"
    case screen = "SCREEN"
    case softLight = "SOFT_LIGHT"
}

/// Node Properties
/// The root node
///
/// The root node within the document
///
/// Represents a single page
///
/// A node of fixed size containing other nodes
///
/// A logical grouping of nodes
///
/// A vector network, consisting of vertices and edges
///
/// A group that has a boolean operation applied to it
///
/// A regular star shape
///
/// A straight line
///
/// An ellipse
///
/// A regular n-sided polygon
///
/// A rectangle
///
/// A text box
///
/// A rectangular region of the canvas that can be exported
///
/// A node that can have instances created of it that share the same properties
/// A description of a master component. Helps you identify which component
/// instances are attached to
///
/// An instance of a component, changes to the component result in the same
/// changes applied to the instance
public struct FigmaDocument: Codable {
    /// An array of canvases attached to the document
    ///
    /// An array of top level layers on the canvas
    ///
    /// An array of nodes that are direct children of this node
    ///
    /// An array of nodes that are being boolean operated on
    public let children: [FigmaDocument]?
    /// a string uniquely identifying this node within the document
    public let id: String
    /// the name given to the node by the user in the tool.
    ///
    /// The name of the component
    public let name: String
    /// the type of the node, refer to table below for details
    public let type: NodeType
    /// whether or not the node is visible on the canvas
    public let visible: Bool?
    /// Background color of the canvas
    ///
    /// Background color of the node
    public let backgroundColor: FigmaColor?
    /// An array of export settings representing images to export from the canvas
    ///
    /// An array of export settings representing images to export from node
    ///
    /// An array of export settings representing images to export from this node
    public let exportSettings: [ExportSetting]?
    /// Bounding box of the node in absolute space coordinates
    public let absoluteBoundingBox: Rect?
    /// How this node blends with nodes behind it in the scene
    /// (see blend mode section for more details)
    public let blendMode: BlendMode?
    /// Does this node clip content outside of its bounds?
    public let clipsContent: Bool?
    /// Horizontal and vertical layout constraints for node
    public let constraints: LayoutConstraint?
    /// An array of effects attached to this node
    /// (see effects section for more details)
    public let effects: [Effect]?
    /// Does this node mask sibling nodes in front of it?
    public let isMask: Bool?
    /// An array of layout grids attached to this node (see layout grids section
    /// for more details). GROUP nodes do not have this attribute
    public let layoutGrids: [LayoutGrid]?
    /// Opacity of the node
    public let opacity: Double?
    /// Keep height and width constrained to same ratio
    public let preserveRatio: Bool?
    /// Node ID of node to transition to in prototyping
    public let transitionNodeID: String?
    /// An array of fill paints applied to the node
    public let fills: [Paint]?
    /// Where stroke is drawn relative to the vector outline as a string enum
    /// "INSIDE": draw stroke inside the shape boundary
    /// "OUTSIDE": draw stroke outside the shape boundary
    /// "CENTER": draw stroke centered along the shape boundary
    public let strokeAlign: StrokeAlign?
    /// An array of stroke paints applied to the node
    public let strokes: [Paint]?
    /// The weight of strokes on the node
    public let strokeWeight: Double?
    /// Radius of each corner of the rectangle
    public let cornerRadius: Double?
    /// Text contained within text box
    public let characters: String?
    /// Array with same number of elements as characeters in text box,
    /// each element is a reference to the styleOverrideTable defined
    /// below and maps to the corresponding character in the characters
    /// field. Elements with value 0 have the default type style
    public let characterStyleOverrides: [Double]?
    /// Style of text including font family and weight (see type style
    /// section for more information)
    public let style: TypeStyle?
    public let styles: [String: String]?
    /// The description of the component as entered in the editor
    public let description: String?
    /// ID of component that this instance came from, refers to components
    /// table (see endpoints section below)
    public let componentID: String?

    enum CodingKeys: String, CodingKey {
        case children, id, name, type, visible, backgroundColor, exportSettings, absoluteBoundingBox, blendMode,
             clipsContent, constraints, effects, isMask, layoutGrids, opacity, preserveRatio, transitionNodeID, fills,
             strokeAlign, strokes, strokeWeight, cornerRadius, characters, characterStyleOverrides, style, styles,
             description
        case componentID = "componentId"
    }
}

/// Horizontal and vertical layout constraints for node
///
/// Layout constraint relative to containing Frame
public struct LayoutConstraint: Codable {
    /// Horizontal constraint as an enum
    /// "LEFT": Node is laid out relative to left of the containing frame
    /// "RIGHT": Node is laid out relative to right of the containing frame
    /// "CENTER": Node is horizontally centered relative to containing frame
    /// "LEFT_RIGHT": Both left and right of node are constrained relative to containing frame
    /// (node stretches with frame)
    /// "SCALE": Node scales horizontally with containing frame
    public let horizontal: Horizontal
    /// Vertical constraint as an enum
    /// "TOP": Node is laid out relative to top of the containing frame
    /// "BOTTOM": Node is laid out relative to bottom of the containing frame
    /// "CENTER": Node is vertically centered relative to containing frame
    /// "TOP_BOTTOM": Both top and bottom of node are constrained relative to containing frame
    /// (node stretches with frame)
    /// "SCALE": Node scales vertically with containing frame
    public let vertical: Vertical
}

/// Horizontal constraint as an enum
/// "LEFT": Node is laid out relative to left of the containing frame
/// "RIGHT": Node is laid out relative to right of the containing frame
/// "CENTER": Node is horizontally centered relative to containing frame
/// "LEFT_RIGHT": Both left and right of node are constrained relative to containing frame
/// (node stretches with frame)
/// "SCALE": Node scales horizontally with containing frame
public enum Horizontal: String, Codable {
    case center = "CENTER"
    case horizontalLEFT = "LEFT"
    case horizontalRIGHT = "RIGHT"
    case leftRight = "LEFT_RIGHT"
    case scale = "SCALE"
}

/// Vertical constraint as an enum
/// "TOP": Node is laid out relative to top of the containing frame
/// "BOTTOM": Node is laid out relative to bottom of the containing frame
/// "CENTER": Node is vertically centered relative to containing frame
/// "TOP_BOTTOM": Both top and bottom of node are constrained relative to containing frame
/// (node stretches with frame)
/// "SCALE": Node scales vertically with containing frame
public enum Vertical: String, Codable {
    case bottom = "BOTTOM"
    case center = "CENTER"
    case scale = "SCALE"
    case top = "TOP"
    case topBottom = "TOP_BOTTOM"
}

/// An array of effects attached to this node
/// (see effects section for more details)
///
/// A visual effect such as a shadow or blur
public struct Effect: Codable {
    /// Enum describing how layer blends with layers below
    /// This type is a string enum with the following possible values
    public let blendMode: BlendMode?
    /// An RGBA color
    public let color: FigmaColor?
    /// A 2d vector
    public let offset: Vector2?
    /// Radius of the blur effect (applies to shadows as well)
    public let radius: Double
    /// Type of effect as a string enum
    public let type: EffectType
    /// Is the effect active?
    public let visible: Bool?
}

/// A 2d vector
///
/// This field contains three vectors, each of which are a position in
/// normalized object space (normalized object space is if the top left
/// corner of the bounding box of the object is (0, 0) and the bottom
/// right is (1,1)). The first position corresponds to the start of the
/// gradient (value 0 for the purposes of calculating gradient stops),
/// the second position is the end of the gradient (value 1), and the
/// third handle position determines the width of the gradient (only
/// relevant for non-linear gradients).
///
/// 2d vector offset within the frame.
public struct Vector2: Codable {
    /// X coordinate of the vector
    public let x: Double
    /// Y coordinate of the vector
    public let y: Double
}

/// Type of effect as a string enum
public enum EffectType: String, Codable {
    case backgroundBlur = "BACKGROUND_BLUR"
    case dropShadow = "DROP_SHADOW"
    case innerShadow = "INNER_SHADOW"
    case layerBlur = "LAYER_BLUR"
}

/// An array of export settings representing images to export from node
///
/// Format and size to export an asset at
///
/// An array of export settings representing images to export from this node
///
/// An array of export settings representing images to export from the canvas
public struct ExportSetting: Codable {
    /// Constraint that determines sizing of exported asset
    public let constraint: Constraint
    /// Image type, string enum
    public let format: Format
    /// File suffix to append to all filenames
    public let suffix: String
}

/// Constraint that determines sizing of exported asset
///
/// Sizing constraint for exports
public struct Constraint: Codable {
    /// Type of constraint to apply; string enum with potential values below
    /// "SCALE": Scale by value
    /// "WIDTH": Scale proportionally and set width to value
    /// "HEIGHT": Scale proportionally and set height to value
    public let type: ConstraintType
    /// See type property for effect of this field
    public let value: Double
}

/// Type of constraint to apply; string enum with potential values below
/// "SCALE": Scale by value
/// "WIDTH": Scale proportionally and set width to value
/// "HEIGHT": Scale proportionally and set height to value
public enum ConstraintType: String, Codable {
    case height = "HEIGHT"
    case scale = "SCALE"
    case width = "WIDTH"
}

/// Image type, string enum
public enum Format: String, Codable {
    case jpg = "JPG"
    case png = "PNG"
    case svg = "SVG"
}

/// An array of fill paints applied to the node
///
/// A solid color, gradient, or image texture that can be applied as fills or strokes
///
/// An array of stroke paints applied to the node
///
/// Paints applied to characters
public struct Paint: Codable {
    /// Solid color of the paint
    public let color: FigmaColor?
    /// This field contains three vectors, each of which are a position in
    /// normalized object space (normalized object space is if the top left
    /// corner of the bounding box of the object is (0, 0) and the bottom
    /// right is (1,1)). The first position corresponds to the start of the
    /// gradient (value 0 for the purposes of calculating gradient stops),
    /// the second position is the end of the gradient (value 1), and the
    /// third handle position determines the width of the gradient (only
    /// relevant for non-linear gradients).
    public let gradientHandlePositions: [Vector2]?
    /// Positions of key points along the gradient axis with the colors
    /// anchored there. Colors along the gradient are interpolated smoothly
    /// between neighboring gradient stops.
    public let gradientStops: [ColorStop]?
    /// Overall opacity of paint (colors within the paint can also have opacity
    /// values which would blend with this)
    public let opacity: Double?
    /// Image scaling mode
    public let scaleMode: String?
    /// Type of paint as a string enum
    public let type: FillType
    /// Is the paint enabled?
    public let visible: Bool?
}

/// Positions of key points along the gradient axis with the colors
/// anchored there. Colors along the gradient are interpolated smoothly
/// between neighboring gradient stops.
///
/// A position color pair representing a gradient stop
public struct ColorStop: Codable {
    /// Color attached to corresponding position
    public let color: FigmaColor
    /// Value between 0 and 1 representing position along gradient axis
    public let position: Double
}

/// Type of paint as a string enum
public enum FillType: String, Codable {
    case emoji = "EMOJI"
    case gradientAngular = "GRADIENT_ANGULAR"
    case gradientDiamond = "GRADIENT_DIAMOND"
    case gradientLinear = "GRADIENT_LINEAR"
    case gradientRadial = "GRADIENT_RADIAL"
    case image = "IMAGE"
    case solid = "SOLID"
}

/// An array of layout grids attached to this node (see layout grids section
/// for more details). GROUP nodes do not have this attribute
///
/// Guides to align and place objects within a frame
public struct LayoutGrid: Codable {
    /// Positioning of grid as a string enum
    /// "MIN": Grid starts at the left or top of the frame
    /// "MAX": Grid starts at the right or bottom of the frame
    /// "CENTER": Grid is center aligned
    public let alignment: Alignment
    /// Color of the grid
    public let color: FigmaColor
    /// Number of columns or rows
    public let count: Double
    /// Spacing in between columns and rows
    public let gutterSize: Double
    /// Spacing before the first column or row
    public let offset: Double
    /// Orientation of the grid as a string enum
    /// "COLUMNS": Vertical grid
    /// "ROWS": Horizontal grid
    /// "GRID": Square grid
    public let pattern: Pattern
    /// Width of column grid or height of row grid or square grid spacing
    public let sectionSize: Double
    /// Is the grid currently visible?
    public let visible: Bool?
}

/// Positioning of grid as a string enum
/// "MIN": Grid starts at the left or top of the frame
/// "MAX": Grid starts at the right or bottom of the frame
/// "CENTER": Grid is center aligned
public enum Alignment: String, Codable {
    case center = "CENTER"
    case max = "MAX"
    case min = "MIN"
}

/// Orientation of the grid as a string enum
/// "COLUMNS": Vertical grid
/// "ROWS": Horizontal grid
/// "GRID": Square grid
public enum Pattern: String, Codable {
    case columns = "COLUMNS"
    case grid = "GRID"
    case rows = "ROWS"
}

/// Where stroke is drawn relative to the vector outline as a string enum
/// "INSIDE": draw stroke inside the shape boundary
/// "OUTSIDE": draw stroke outside the shape boundary
/// "CENTER": draw stroke centered along the shape boundary
public enum StrokeAlign: String, Codable {
    case center = "CENTER"
    case inside = "INSIDE"
    case outside = "OUTSIDE"
}

/// Style of text including font family and weight (see type style
/// section for more information)
///
/// Metadata for character formatting
///
/// Map from ID to TypeStyle for looking up style overrides
public struct TypeStyle: Codable {
    /// Paints applied to characters
    public let fills: [Paint]?
    /// Font family of text (standard name)
    public let fontFamily: String
    /// PostScript font name
    public let fontPostScriptName: String?
    /// Font size in px
    public let fontSize: Double
    /// Numeric font weight
    public let fontWeight: Double
    /// Is text italicized?
    public let italic: Bool?
    /// Space between characters in px
    public let letterSpacing: Double
    /// Line height as a percentage of normal line height
    public let lineHeightPercent: Double
    /// Line height in px
    public let lineHeightPx: Double
    /// Horizontal text alignment as string enum
    public let textAlignHorizontal: TextAlignHorizontal
    /// Vertical text alignment as string enum
    public let textAlignVertical: TextAlignVertical
}

/// Horizontal text alignment as string enum
public enum TextAlignHorizontal: String, Codable {
    case center = "CENTER"
    case justified = "JUSTIFIED"
    case textAlignHorizontalLEFT = "LEFT"
    case textAlignHorizontalRIGHT = "RIGHT"
}

/// Vertical text alignment as string enum
public enum TextAlignVertical: String, Codable {
    case bottom = "BOTTOM"
    case center = "CENTER"
    case top = "TOP"
}

/// the type of the node, refer to table below for details
public enum NodeType: String, Codable {
    case boolean = "BOOLEAN"
    case canvas = "CANVAS"
    case component = "COMPONENT"
    case document = "DOCUMENT"
    case ellipse = "ELLIPSE"
    case frame = "FRAME"
    case group = "GROUP"
    case instance = "INSTANCE"
    case line = "LINE"
    case rectangle = "RECTANGLE"
    case regularPolygon = "REGULAR_POLYGON"
    case slice = "SLICE"
    case star = "STAR"
    case text = "TEXT"
    case vector = "VECTOR"
    case booleanOperation = "BOOLEAN_OPERATION"
}

/// Node Properties
/// The root node
///
/// The root node within the document
public struct DocumentClass: Codable {
    /// An array of canvases attached to the document
    public let children: [FigmaDocument]
    /// a string uniquely identifying this node within the document
    public let id: String
    /// the name given to the node by the user in the tool.
    public let name: String
    /// the type of the node, refer to table below for details
    public let type: NodeType
    /// whether or not the node is visible on the canvas
    public let visible: Bool?
}

/// GET /v1/files/:key/comments
///
/// > Description
/// A list of comments left on the file.
///
/// > Path parameters
/// key String
/// File to get comments from
public struct CommentsResponse: Codable {
    public let comments: [Comment]
}

/// A comment or reply left by a user
public struct Comment: Codable {
    public let clientMeta: ClientMeta
    /// The time at which the comment was left
    public let createdAt: String
    /// The file in which the comment lives
    public let fileKey: String
    /// Unique identifier for comment
    public let id: String
    /// (MISSING IN DOCS)
    /// The content of the comment
    public let message: String
    /// Only set for top level comments. The number displayed with the
    /// comment in the UI
    public let orderID: Double
    /// If present, the id of the comment to which this is the reply
    public let parentID: String
    /// If set, when the comment was resolved
    public let resolvedAt: String?
    /// The user who left the comment
    public let user: User

    enum CodingKeys: String, CodingKey {
        case clientMeta = "client_meta"
        case createdAt = "created_at"
        case fileKey = "file_key"
        case id, message
        case orderID = "order_id"
        case parentID = "parent_id"
        case resolvedAt = "resolved_at"
        case user
    }
}

/// A 2d vector
///
/// This field contains three vectors, each of which are a position in
/// normalized object space (normalized object space is if the top left
/// corner of the bounding box of the object is (0, 0) and the bottom
/// right is (1,1)). The first position corresponds to the start of the
/// gradient (value 0 for the purposes of calculating gradient stops),
/// the second position is the end of the gradient (value 1), and the
/// third handle position determines the width of the gradient (only
/// relevant for non-linear gradients).
///
/// 2d vector offset within the frame.
///
/// A relative offset within a frame
public struct ClientMeta: Codable {
    /// X coordinate of the vector
    public let x: Double?
    /// Y coordinate of the vector
    public let y: Double?
    /// Unique id specifying the frame.
    public let nodeID: [String]?
    /// 2d vector offset within the frame.
    public let nodeOffset: Vector2?

    enum CodingKeys: String, CodingKey {
        case x, y
        case nodeID = "node_id"
        case nodeOffset = "node_offset"
    }
}

/// The user who left the comment
///
/// A description of a user
public struct User: Codable {
    public let handle, imgURL: String

    enum CodingKeys: String, CodingKey {
        case handle
        case imgURL = "img_url"
    }
}

/// POST /v1/files/:key/comments
///
/// > Description
/// Posts a new comment on the file.
///
/// > Path parameters
/// key String
/// File to get comments from
///
/// > Body parameters
/// message String
/// The text contents of the comment to post
///
/// client_meta Vector2 | FrameOffset
/// The position of where to place the comment. This can either be an absolute canvas
/// position or the relative position within a frame.
///
/// > Return value
/// The Comment that was successfully posted
///
/// > Error codes
/// 404 The specified file was not found
public struct CommentRequest: Codable {
    public let clientMeta: ClientMeta
    public let message: String

    enum CodingKeys: String, CodingKey {
        case clientMeta = "client_meta"
        case message
    }
}

/// GET /v1/teams/:team_id/projects
///
/// > Description
/// Lists the projects for a specified team. Note that this will only return projects visible
/// to the authenticated user or owner of the developer token.
///
/// > Path parameters
/// team_id String
/// Id of the team to list projects from
public struct ProjectsResponse: Codable {
    public let projects: [Project]
}

public struct Project: Codable {
    public let id: Double
    public let name: String
}

/// GET /v1/projects/:project_id/files
///
/// > Description
/// List the files in a given project.
///
/// > Path parameters
/// project_id String
/// Id of the project to list files from
public struct ProjectFilesResponse: Codable {
    public let files: [File]
}

public struct File: Codable {
    public let key: String
    /// utc date in iso8601
    public let lastModified: String
    public let name, thumbnailURL: String

    enum CodingKeys: String, CodingKey {
        case key
        case lastModified = "last_modified"
        case name
        case thumbnailURL = "thumbnail_url"
    }
}

// MARK: Convenience initializers

public extension FileResponse {
    init(data: Data) throws {
        self = try JSONDecoder().decode(FileResponse.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try jsonData(), encoding: encoding)
    }
}

public extension Component {
    init(data: Data) throws {
        self = try JSONDecoder().decode(Component.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try jsonData(), encoding: encoding)
    }
}

public extension Rect {
    init(data: Data) throws {
        self = try JSONDecoder().decode(Rect.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try jsonData(), encoding: encoding)
    }
}

public extension FigmaColor {
    init(data: Data) throws {
        self = try JSONDecoder().decode(FigmaColor.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try jsonData(), encoding: encoding)
    }
}

public extension FigmaDocument {
    init(data: Data) throws {
        self = try JSONDecoder().decode(FigmaDocument.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try jsonData(), encoding: encoding)
    }
}

public extension LayoutConstraint {
    init(data: Data) throws {
        self = try JSONDecoder().decode(LayoutConstraint.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try jsonData(), encoding: encoding)
    }
}

public extension Effect {
    init(data: Data) throws {
        self = try JSONDecoder().decode(Effect.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try jsonData(), encoding: encoding)
    }
}

public extension Vector2 {
    init(data: Data) throws {
        self = try JSONDecoder().decode(Vector2.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try jsonData(), encoding: encoding)
    }
}

public extension ExportSetting {
    init(data: Data) throws {
        self = try JSONDecoder().decode(ExportSetting.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try jsonData(), encoding: encoding)
    }
}

public extension Constraint {
    init(data: Data) throws {
        self = try JSONDecoder().decode(Constraint.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try jsonData(), encoding: encoding)
    }
}

public extension Paint {
    init(data: Data) throws {
        self = try JSONDecoder().decode(Paint.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try jsonData(), encoding: encoding)
    }
}

public extension ColorStop {
    init(data: Data) throws {
        self = try JSONDecoder().decode(ColorStop.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try jsonData(), encoding: encoding)
    }
}

public extension LayoutGrid {
    init(data: Data) throws {
        self = try JSONDecoder().decode(LayoutGrid.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try jsonData(), encoding: encoding)
    }
}

public extension TypeStyle {
    init(data: Data) throws {
        self = try JSONDecoder().decode(TypeStyle.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try jsonData(), encoding: encoding)
    }
}

public extension DocumentClass {
    init(data: Data) throws {
        self = try JSONDecoder().decode(DocumentClass.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try jsonData(), encoding: encoding)
    }
}

public extension CommentsResponse {
    init(data: Data) throws {
        self = try JSONDecoder().decode(CommentsResponse.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try jsonData(), encoding: encoding)
    }
}

public extension Comment {
    init(data: Data) throws {
        self = try JSONDecoder().decode(Comment.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try jsonData(), encoding: encoding)
    }
}

public extension ClientMeta {
    init(data: Data) throws {
        self = try JSONDecoder().decode(ClientMeta.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try jsonData(), encoding: encoding)
    }
}

public extension User {
    init(data: Data) throws {
        self = try JSONDecoder().decode(User.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try jsonData(), encoding: encoding)
    }
}

public extension CommentRequest {
    init(data: Data) throws {
        self = try JSONDecoder().decode(CommentRequest.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try jsonData(), encoding: encoding)
    }
}

public extension ProjectsResponse {
    init(data: Data) throws {
        self = try JSONDecoder().decode(ProjectsResponse.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try jsonData(), encoding: encoding)
    }
}

public extension Project {
    init(data: Data) throws {
        self = try JSONDecoder().decode(Project.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try jsonData(), encoding: encoding)
    }
}

public extension ProjectFilesResponse {
    init(data: Data) throws {
        self = try JSONDecoder().decode(ProjectFilesResponse.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try jsonData(), encoding: encoding)
    }
}

public extension File {
    init(data: Data) throws {
        self = try JSONDecoder().decode(File.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try jsonData(), encoding: encoding)
    }
}
