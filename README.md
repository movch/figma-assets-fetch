# Figma Assets Fetch

A macOS command-line utility for template-based code generation from Figma assets. Unlike other similar utilities it follows the *conventions-over-configurations* principle, which requires less effort in development and usage.

## What can it do?

It can obtain colors information from the specially prepared frame in Figma document and render it to provided code template.

## How it works?

### Figma part

**Conventions**:

1. Your Figma document should contain frame called `Colors`;
1. This frame should contain the ellipses filled with every color from your design theme;
1. Every color should have a style with some name (colors without styles will be ignored by script);
1. You can use whitespaces in your color style name any other symbols will be ignored.

### Template part

We use (Stencil)[https://github.com/stencilproject/Stencil] as template engine, so any Stencil-compatible markup will be valid. All colors obtained from Figma, are being passed to template as array of objects. Every object looks like this:

    struct ColorObjectModel {
        /// Name that was imported from Figma as is
        let name: String
        
        /// `name` converted to camel case
        let camelCaseName: String
        
        /// Hex value of color
        let hexColor: String
        
        /// RGBA value of color
        var figmaColor: FigmaColor
    }

Example template:

    import UIKit

    enum Color: Int {
    {% for color in colors %}
        case {{ color.camelCaseName }}
    {% endfor %}

        public func color(_ color: ThemeColor) -> UIColor {
            switch color {
            {% for color in colors %}
            case .{{ color.camelCaseName }}:
                return UIColor(red: {{ color.figmaColor.r }}, green: {{ color.figmaColor.g }}, blue: {{ color.figmaColor.b }}, alpha: {{ color.figmaColor.a }})
            {% endfor %}
            }
        }
    }

### Command line utility part

To run the utility you need to pass several parameters, please refer to example below:

    figma-assets-fetch \
        colors \
        --figma-token $FIGMA_TOKEN \ #Figma API token obtained from your account page in Figma
        --templates-directory "$TEMPLATES_DIR" \ #Path to directory with Stencil templates
        --figma-file-id $FIGMA_FILE_ID \ #File identifier of your Figma document, can be extracted from the URL
        --template-name Colors.swift.stencil \ #File name of the Stencil template to use
        --output "$OUT_FILE_PATH" #Where to save generated file

## Building

The utility was written in Swift for macOS. Just clone the repository and build it with the latest version of Xcode.