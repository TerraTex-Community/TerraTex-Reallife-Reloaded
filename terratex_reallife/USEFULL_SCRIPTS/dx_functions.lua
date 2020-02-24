function dxDrawTextWithShadow( shadowaroundsize,shadowcolor, text,  left, top , right, bottom, color,scale, font, alignX, alignY,clip, wordBreak, postGUI,colorCoded, subPixelPositioning,fRotation, fRotationCenterX, fRotationCenterY )
    local shadow=0.5
    while(shadow<=shadowaroundsize)do
    --top
        dxDrawText( text,  left-shadow, top-shadow , right-shadow, bottom-shadow, shadowcolor,scale, font, alignX, alignY,clip, wordBreak, postGUI,colorCoded, subPixelPositioning,fRotation, fRotationCenterX, fRotationCenterY)
        dxDrawText( text,  left, top-shadow , right, bottom-shadow, shadowcolor,scale, font, alignX, alignY,clip, wordBreak, postGUI,colorCoded, subPixelPositioning,fRotation, fRotationCenterX, fRotationCenterY)
        dxDrawText( text,  left+shadow, top-shadow , right+shadow, bottom-shadow, shadowcolor,scale, font, alignX, alignY,clip, wordBreak, postGUI,colorCoded, subPixelPositioning,fRotation, fRotationCenterX, fRotationCenterY)
    --center
        dxDrawText( text,  left-shadow, top , right-shadow, bottom, shadowcolor,scale, font, alignX, alignY,clip, wordBreak, postGUI,colorCoded, subPixelPositioning,fRotation, fRotationCenterX, fRotationCenterY)
        dxDrawText( text,  left+shadow, top , right+shadow, bottom, shadowcolor,scale, font, alignX, alignY,clip, wordBreak, postGUI,colorCoded, subPixelPositioning,fRotation, fRotationCenterX, fRotationCenterY)
    --bottom
        dxDrawText( text,  left-shadow, top+shadow , right-shadow, bottom+shadow, shadowcolor,scale, font, alignX, alignY,clip, wordBreak, postGUI,colorCoded, subPixelPositioning,fRotation, fRotationCenterX, fRotationCenterY)
        dxDrawText( text,  left, top+shadow , right, bottom+shadow, shadowcolor,scale, font, alignX, alignY,clip, wordBreak, postGUI,colorCoded, subPixelPositioning,fRotation, fRotationCenterX, fRotationCenterY)
        dxDrawText( text,  left+shadow, top+shadow , right+shadow, bottom+shadow, shadowcolor,scale, font, alignX, alignY,clip, wordBreak, postGUI,colorCoded, subPixelPositioning,fRotation, fRotationCenterX, fRotationCenterY)
        shadow=shadow+0.5
    end

    dxDrawText( text,  left, top , right, bottom, color,scale, font, alignX, alignY,clip, wordBreak, postGUI,colorCoded, subPixelPositioning,fRotation, fRotationCenterX, fRotationCenterY)
end
