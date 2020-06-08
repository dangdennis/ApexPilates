//
//  Theme.swift
//  Apex Pilates
//
//  Created by Dennis Dang on 5/2/20.
//  Copyright © 2020 dlab. All rights reserved.
//

import SwiftUI

public struct H1: ViewModifier {
    public func body(content: Content) -> some View {
        content
            .font(Font.system(size: Sizes.h1Point, weight: .bold, design: .default))
            .foregroundColor(Colors.textHeaderPrimary)
    }
}

extension View {
    public func h1() -> some View {
        self.modifier(H1())
    }
}


public struct H2: ViewModifier {
    public func body(content: Content) -> some View {
        content
            .font(Font.system(size: Sizes.h2Point, weight: .bold, design: .default))
            .foregroundColor(Colors.textHeaderPrimary)
    }
}

extension View {
    public func h2() -> some View {
        self.modifier(H2())
    }
}


public struct H3: ViewModifier {
    public func body(content: Content) -> some View {
        content
            .font(Font.system(size: Sizes.h3Point, weight: .bold, design: .default))
            .foregroundColor(Colors.textHeaderPrimary)
    }
}

extension View {
    public func h3() -> some View {
        self.modifier(H3())
    }
}

public struct H4: ViewModifier {
    public func body(content: Content) -> some View {
        content
            .font(Font.system(size: Sizes.h4Point, weight: .bold, design: .default))
            .foregroundColor(Colors.textHeaderPrimary)
    }
}

extension View {
    public func h4() -> some View {
        self.modifier(H4())
    }
}

public struct BorderButton: ViewModifier {
    public func body(content: Content) -> some View {
        content
            .foregroundColor(Colors.textParagraph)
            .padding(.vertical, Sizes.paddingButtonVertical)
            .padding(.horizontal, Sizes.paddingButtonHorizontal)
            .background(Color.clear)
            .overlay(
                RoundedRectangle(cornerRadius: Sizes.cornerRadius)
                    .stroke(Colors.borderButtonSecondary, lineWidth: 2)
            )
            .shadow(color: Colors.shadowButtonPrimary, radius: 4, x: 0, y: 4)
    }
}

extension View {
    public func borderButton() -> some View {
        self.modifier(BorderButton())
    }
}

public struct PrimaryButton: ViewModifier {
    public func body(content: Content) -> some View {
        content
            .foregroundColor(Colors.textButtonPrimary)
            .padding(.vertical, Sizes.paddingButtonVertical)
            .padding(.horizontal, Sizes.paddingButtonHorizontal)
            .background(Colors.buttonPrimaryBackground)
            .cornerRadius(Sizes.cornerRadius)
            .shadow(color: Colors.shadowButtonPrimary, radius: 12, x: 0, y: 0)
    }
}

extension View {
    public func primaryButton() -> some View {
        self.modifier(PrimaryButton())
    }
}

public struct BlockQuote: ViewModifier {
    
    public enum BorderStyle {
        case Primary
        case Success
        case Warning
        case Error
    }
    
    public var style: BorderStyle
    
    private var borderColor: Color {
        switch self.style {
            case .Primary:
                return Colors.buttonPrimaryBackground
            case .Success:
                return Colors.success
            case .Warning:
                return Colors.warning
            case .Error:
                return Colors.error
        }
    }
    
    public func body(content: Content) -> some View {
        content
            .padding(.leading, 12)
            .overlay(
                LeftBorder(width: 4)
                    .foregroundColor(borderColor)
            )
    }

        
}

extension View {
    public func blockQuote(style: BlockQuote.BorderStyle) -> some View {
        self.modifier(BlockQuote(style: style))
    }
}

struct LeftBorder: Shape {

    var width: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let x:CGFloat = rect.minX + (width/2.0)
        let y:CGFloat = rect.minY
        let height: CGFloat = rect.height

        return Path(CGRect(x: x, y: y, width: width, height: height))
    }
}

public struct Paragraph: ViewModifier {
    public func body(content: Content) -> some View {
        content
            .font(Font.system(size: Sizes.paragraphPoint, weight: .regular, design: .default))
            .foregroundColor(Colors.textParagraph)
    }
}

extension View {
    public func paragraph() -> some View {
        self.modifier(Paragraph())
    }
}

public struct SecondaryText: ViewModifier {
    public func body(content: Content) -> some View {
        content
            .foregroundColor(Colors.textHeaderSecondary)
    }
}

extension View {
    public func textSecondary() -> some View {
        self.modifier(SecondaryText())
    }
}
