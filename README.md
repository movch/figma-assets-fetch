# figma-assets-fetch

A macOS command-line utility for template-based code generation from Figma assets. Unlike other similar utilities it follows the *conventions-over-configurations* principle, which requires less effort in development and usage.

## What can it do?

- It can perform template based code generation from Figma frame with colors;
- It can generate `*.xcassets` file with color set obtained from Figma frame.

## Getting Started

### Figma part
1. Prepare your color palette in a separate frame in your Figma file. It should contain a certain number of ellipses, each of which must be filled with the appropriate color. See the [example file](https://www.figma.com/file/1z5n1txr0nz7qMVzcS3Oif/figma-assets-fetch-palette-example?node-id=0%3A1).
![Figma palette example](img/figma-palette-example.png)

1. Every color you use in your palette should have a style with some name. Alternatively you can set the name of the ellipse filled with that color (if the style is not set, the utility will parse color name from the ellipse name).
![Creating style name in Figma](img/creating-style-name-in-figma.png)

### Template part
The template file is just a [Stencil](https://github.com/stencilproject/Stencil) template. All colors obtained from Figma, are being passed to template as an array of objects. Refer to [NamedColor](https://github.com/movch/figma-asset-fetch/blob/main/FigmaAssetsFetch/Domain/Entities/NamedColor.swift) to gain understanding about such objects content.

Example template:

    import UIKit

    public enum Color {
    {% for color in colors %}
        case {{ color.name.camelCased }}
    {% endfor %}

        public var colorValue: UIColor {
            switch color {
            {% for color in colors %}
            case .{{ color.name.camelCased }}:
                return UIColor(
                    red: {{ color.value.r }},
                    green: {{ color.value.g }},
                    blue: {{ color.value.b }},
                    alpha: {{ color.value.a }}
                )
            {% endfor %}
            }
        }
    }

### Commands reference
To run the utility you need to pass several parameters, use `figma-assets-fetch help` for detail description of parameters, or refer to the examples below.

#### `colors-code-gen` command
This command is used for template-based code generation of colors obtained from Figma file.

    figma-assets-fetch \
        colors-code-gen \
        --figma-token $FIGMA_TOKEN \ #Figma API token
        --templates-directory "$TEMPLATES_DIR" \ #Path to directory with Stencil templates
        --figma-file-id $FIGMA_FILE_ID \ #File identifier of your Figma document
        --template-name Colors.swift.stencil \ #File name of the Stencil template to use
        --colors-node-id $FIGMA_COLOR_NODE \ #Figma frame node id that contains color palete
        --output "$OUT_FILE_PATH" #Where to save generated file

#### `colors-xc-assets` command
This command is used to generate `*.xcassets` file with colors from Figma.

    figma-assets-fetch \
            colors-xc-assets \
            --figma-token $FIGMA_TOKEN \ #Figma API token
            --figma-file-id $FIGMA_FILE_ID \ #File identifier of your Figma document
            --colors-node-id $FIGMA_COLOR_NODE \ #Figma frame node id that contains color palete
            --asset-name $XCASSET_FILENAME \ #Optional. Name of the result *.xcassets file. Default is 'Colors'.
            --dark-color-style-name-prefix "Dark/" \ #Optional. Dark color style name prefix.
            --dark-colors-node-id $FIGMA_DARK_COLOR_NODE \ #Figma node identifier that contains a collection of ellipses with dark colors.
            --output "$OUT_FILE_PATH" #Where to save generated file

It is also possible to specify another Figma file for dark colors, use `--dark-colors-figma-file-id` parameter for it.

## F.A.Q

### What is `figma-token`?
You can generate your access token on the Figma account settings page.

![](img/figma-personal-access-token.png)

### What is `figma-file-id`?
It can be parsed from the Figma file URL. For example, your Figma file URL is `https://www.figma.com/file/lzXbn6LsYv5kesGqDcsOAl/FigmaAssetsFetch-Palette-Example?node-id=0%3A1` then `figma-file-id` will be `lzXbn6LsYv5kesGqDcsOAl`.

### What is `colors-node-id`?
It can be parsed from the Figma file URL. For example, your Figma file URL is `https://www.figma.com/file/lzXbn6LsYv5kesGqDcsOAl/FigmaAssetsFetch-Palette-Example?node-id=0%3A1` then `colors-node-id` will be `0:1` (this is a decoded version of the URL encoded `0%3A1` string, you can use any online decoder/encoder ([like this](https://meyerweb.com/eric/tools/dencoder/)) to get it).

## Building
The utility is written in Swift for macOS. Just clone the repository and build the project with the latest version of Xcode.
