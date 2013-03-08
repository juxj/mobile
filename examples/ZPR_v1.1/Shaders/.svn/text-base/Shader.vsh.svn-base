//
//  Shader.vsh
//  ZPR
//
//  Created by Neo Lin on 5/27/11.
//  Copyright 2011 Break Media. All rights reserved.
//

attribute vec4 position;
attribute vec4 color;

varying vec4 colorVarying;

uniform float translate;

void main()
{
    gl_Position = position;
    gl_Position.y += sin(translate) / 2.0;

    colorVarying = color;
}
