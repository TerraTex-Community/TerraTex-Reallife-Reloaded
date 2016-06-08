//
// Example shader - block_world.fx
//


//---------------------------------------------------------------------
// Block world settings
//---------------------------------------------------------------------
float sRes : RES = 0.125;
float4 sColorize : COLORIZE;


//---------------------------------------------------------------------
// Include some common stuff
//---------------------------------------------------------------------
#include "mta-helper.fx"


//---------------------------------------------------------------------
// Sampler for the main texture
//---------------------------------------------------------------------
sampler Sampler0 = sampler_state
{
    Texture         = (gTexture0);
    MinFilter       = Linear;
    MagFilter       = Linear;
    MipFilter       = Linear;
};

//---------------------------------------------------------------------
// Structure of data sent to the pixel shader ( from the vertex shader )
//---------------------------------------------------------------------
struct PSInput
{
    float4 Position : POSITION0;
    float4 Diffuse : COLOR0;
    float2 TexCoord: TEXCOORD0;
};


//------------------------------------------------------------------------------------------
// PixelShaderFunction
//  1. Read from PS structure
//  2. Process
//  3. Return pixel color
//------------------------------------------------------------------------------------------
float4 PixelShaderFunction2(PSInput PS) : COLOR0
{
    // Remove lower bits in texture coords
    float2 uv = PS.TexCoord - fmod(PS.TexCoord, sRes);
	float4 texel = tex2D(Sampler0, uv);

    // Use full precision for sampling the alpha
	float alpha = tex2D(Sampler0, PS.TexCoord).a;

    // Modulate texture with lighting and colorization value
    float4 finalColor = texel * PS.Diffuse * sColorize;
    finalColor.a = alpha * PS.Diffuse.a;

    return finalColor;
}


//------------------------------------------------------------------------------------------
// Techniques
//------------------------------------------------------------------------------------------
technique blocky
{
    pass P0
    {
        PixelShader  = compile ps_2_0 PixelShaderFunction2();
    }
}

// Fallback
technique fallback
{
    pass P0
    {
        // Just draw normally
    }
}
