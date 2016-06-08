// paint fix and reflection by Ren712
// car_refgrun.fx
//
//
// Badly converted from:
//
//      ShaderX2 – Shader Programming Tips and Tricks with DirectX 9
//      http://developer.amd.com/media/gpu_assets/ShaderX2_LayeredCarPaintShader.pdf
//
//      Chris Oat           Natalya Tatarchuk       John Isidoro
//      ATI Research        ATI Research            ATI Research
//

//some additional variables for the reflection
//for reflection factor look for brightnessFactor in piel shader

float sSparkleSize = 0.5;
float bumpSize = 1;

float2 uvMul = float2(1,1);
float2 uvMov = float2(0,0.25);

float brightnessFactor = 0.20;
float transFactor = 0.55;
float alphaFactor = 0.75;

float minZviewAngleFade = 0.6;
float sNormZ = 3;
float sRefFlan = 0.2;
float sAdd = 0.1;  
float sMul = 1.1; 
float sCutoff : CUTOFF = 0.16;         // 0 - 1
float sPower : POWER  = 2;            // 1 - 5
float sNorFac = 1;

float gFilmDepth = 0.05; // 0-0.25
float gFilmIntensity = 0.005;
float3 sSkyColorTop = float3(0,0,0);
float3 sSkyColorBott = float3(0,0,0);
float sSkyLightIntensity = 0;

//---------------------------------------------------------------------
// Car paint settings
//---------------------------------------------------------------------
texture sReflectionTexture;
texture sRandomTexture;
texture sFringeTexture;

//---------------------------------------------------------------------
// Include some common stuff
//---------------------------------------------------------------------
#include "mta-helper.fx"

//------------------------------------------------------------------------------------------
// Samplers for the textures
//------------------------------------------------------------------------------------------
sampler Sampler0 = sampler_state
{
    Texture         = (gTexture0);
    MinFilter       = Linear;
    MagFilter       = Linear;
    MipFilter       = Linear;
};

sampler3D RandomSampler = sampler_state
{
    Texture = (sRandomTexture); 
    MAGFILTER = LINEAR;
    MINFILTER = LINEAR;
    MIPFILTER = POINT;
    MIPMAPLODBIAS = 0.000000;
};

sampler2D ReflectionSampler = sampler_state
{
    Texture = (sReflectionTexture);	
    AddressU = Mirror;
    AddressV = Mirror;
    MinFilter = Linear;
    MagFilter = Linear;
    MipFilter = Linear;
};

sampler2D gFringeMapSampler = sampler_state 
{
    Texture = (sFringeTexture);
    MinFilter = Linear;
    MipFilter = Linear;
    MagFilter = Linear;
    AddressU  = Clamp;
    AddressV  = Clamp;
};

//---------------------------------------------------------------------
// Structure of data sent to the vertex shader
//---------------------------------------------------------------------
struct VSInput
{
    float4 Position : POSITION; 
    float3 Normal : NORMAL0;
    float4 Diffuse : COLOR0;
    float2 TexCoord : TEXCOORD0;
    float3 View : TEXCOORD1;
};

//---------------------------------------------------------------------
// Structure of data sent to the pixel shader ( from the vertex shader )
//---------------------------------------------------------------------
struct PSInput
{
    float4 Position : POSITION;
    float4 Diffuse : COLOR0;
    float4 Specular : COLOR1;   
    float2 TexCoord : TEXCOORD0;
    float3 Tangent : TEXCOORD1;
    float3 Binormal : TEXCOORD2;
    float3 Normal : TEXCOORD3;
    float3 View : TEXCOORD4;
    float3 SparkleTex : TEXCOORD5;
    float3 FilmDepth : TEXCOORD6;
};

//////////////////////////////////////////////////////////////////////////
// Function to Index this texture - use in vertex or pixel shaders ///////
//////////////////////////////////////////////////////////////////////////

float calc_view_depth(float NDotV,float Thickness)
{
    return (Thickness / NDotV);
}

//------------------------------------------------------------------------------------------
// VertexShaderFunction
//  1. Read from VS structure
//  2. Process
//  3. Write to PS structure
//------------------------------------------------------------------------------------------
PSInput VertexShaderFunction(VSInput VS)
{
    PSInput PS = (PSInput)0;
	
    float4 worldPosition = mul ( VS.Position, gWorld );
    float4 viewPosition  = mul ( worldPosition, gView );
    PS.Position  = mul ( viewPosition, gProjection );
 
    PS.View =  gCameraPosition - worldPosition;
	
    // Fake tangent and binormal
    float3 Tangent = VS.Normal.yxz;
    Tangent.xz = VS.TexCoord.xy;
    float3 Binormal =normalize( cross(Tangent, VS.Normal) );
    Tangent = normalize( cross(Binormal, VS.Normal) );

    // Transfer some stuff
    PS.Tangent = normalize(mul(Tangent, gWorldInverseTranspose).xyz);
    PS.Binormal = normalize(mul(Binormal, gWorldInverseTranspose).xyz);
    PS.Normal = normalize( mul(VS.Normal, (float3x3)gWorld) );

    PS.SparkleTex.x = fmod( VS.Position.x, 10 ) * 4.0/sSparkleSize;
    PS.SparkleTex.y = fmod( VS.Position.y, 10 ) * 4.0/sSparkleSize;
    PS.SparkleTex.z = fmod( VS.Position.z, 10 ) * 4.0/sSparkleSize; 
	
    float3 ViewNormal = normalize( mul(VS.Normal, (float3x3)gWorldView) );	
    float4 posNorm = float4(VS.Position.xyz,1);
    posNorm.xyz += float3(ViewNormal.xy * sNorFac * 0.25, ViewNormal.z * sNorFac);	

    float4 pPos = mul(posNorm, gWorldViewProjection); 
    float projectedX = (0.5 * (pPos.x/pPos.w)) * uvMul.x + 0.5 + uvMov.x;
    float projectedY = (0.5 * (pPos.y/pPos.w)) * uvMul.y + 0.5 + uvMov.y;
    PS.TexCoord = float2(projectedX,projectedY);	

    // compute the view depth for the thin film
    float3 Nn = mul(VS.Normal,gWorldInverseTranspose).xyz;	
    float3 Vn = normalize(PS.View);
    float vdn = dot(Vn,Nn);
    float viewdepth = calc_view_depth(vdn,gFilmDepth.x);
    PS.FilmDepth.xy = viewdepth.xx;	
	
    // Calc lighting
    PS.Diffuse = MTACalcGTAVehicleDiffuse( PS.Normal, VS.Diffuse );

    // Normal Z vector for sky light 
    float worldNormalZ = mul(VS.Normal,(float3x3)gWorld).z;
    float skyTopmask = pow(worldNormalZ,5);
    PS.Specular.rgb = (skyTopmask * sSkyColorTop + saturate(worldNormalZ-skyTopmask)* sSkyColorBott );
    PS.Specular.rgb *= gGlobalAmbient.xyz;
    PS.Specular.a = pow(worldNormalZ,sNormZ);
    PS.FilmDepth.z = saturate(PS.Specular.a);
    if (gCameraDirection.z < minZviewAngleFade) 
	{ PS.Specular.a = PS.FilmDepth.z * saturate(( 1 /(1 + minZviewAngleFade))*(1 + gCameraDirection.z)); 
      PS.Specular.a = pow(PS.Specular.a,3);
	}

    return PS;
}

//------------------------------------------------------------------------------------------
// PixelShaderFunction
//  1. Read from PS structure
//  2. Process
//  3. Return pixel color
//------------------------------------------------------------------------------------------
float4 PixelShaderFunction(PSInput PS) : COLOR0
{
    //reflection variable here

    // Some settings for something or another
    float microflakePerturbation = 1.00;
    float normalPerturbation = 1.00;
    float microflakePerturbationA = 0.10;

    // Get the surface normal
    float3 vNormal = PS.Normal;

    // Micro-flakes normal map is a high frequency normalized
    // vector noise map which is repeated across the surface.
    // Fetching the value from it for each pixel allows us to
    // compute perturbed normal for the surface to simulate
    // appearance of micro-flakes suspended in the coat of paint:
    float3 vFlakesNormal = tex3D(RandomSampler, PS.SparkleTex).rgb;

    // Don't forget to bias and scale to shift color into [-1.0, 1.0] range:
    vFlakesNormal = 2 * vFlakesNormal - 1.0;

    // This shader simulates two layers of micro-flakes suspended in
    // the coat of paint. To compute the surface normal for the first layer,
    // the following formula is used:
    // Np1 = ( a * Np + b * N ) / || a * Np + b * N || where a << b
    //
    float3 vNp1 = microflakePerturbationA * vFlakesNormal + normalPerturbation * vNormal ;

    // To compute the surface normal for the second layer of micro-flakes, which
    // is shifted with respect to the first layer of micro-flakes, we use this formula:
    // Np2 = ( c * Np + d * N ) / || c * Np + d * N || where c == d
    float3 vNp2 = microflakePerturbation * (( vFlakesNormal + 1.0)/2) ;

    // The view vector (which is currently in world space) needs to be normalized.
    // This vector is normalized in the pixel shader to ensure higher precision of
    // the resulting view vector. For this highly detailed visual effect normalizing
    // the view vector in the vertex shader and simply interpolating it is insufficient
    // and produces artifacts.

    float3 vView = normalize(PS.View);
    // Transform the surface normal into world space (in order to compute reflection
    // vector to perform environment map look-up):
    float3x3 mTangentToWorld = transpose( float3x3( PS.Tangent,PS.Binormal, PS.Normal ) );
    float3 vNormalWorld = normalize( mul( mTangentToWorld, vNormal ));
       
    // Compute reflection vector resulted from the clear coat of paint on the metallic
    // surface:
	
    float fNdotV = saturate(dot( vNormalWorld, vView ));

    // reflection lookup coords
    float2 vReflection = float2(PS.TexCoord.x,PS.TexCoord.y);
	
    // Hack in some bumpyness
    vReflection.x += vNp2.x * (0.1 * bumpSize) - (0.1 * bumpSize);
    vReflection.y += vNp2.y * (0.05 * bumpSize) - (0.05 * bumpSize);
	
    float4 envMap = tex2D( ReflectionSampler, vReflection );
    float lum = (envMap.r + envMap.g + envMap.b)/3;
    float adj = saturate( lum - sCutoff );
    adj = adj / (1.01 - sCutoff);
    envMap += sAdd+1.0; 
    envMap = (envMap * adj);
    envMap = pow(envMap, sPower+2); 
    envMap *= sMul;

    // Sample fringe map:
    float3 fringeCol = (float3)tex2D(gFringeMapSampler, PS.FilmDepth.xy)* PS.FilmDepth.z;

    // Brighten the environment map sampling result:
    envMap.rgb *= brightnessFactor;	 
	
    envMap.a =1;	
    float4 first = float4((envMap.rgb+ 0.5 * PS.Specular.rgb * sSkyLightIntensity),PS.Specular.a);
    float4 second = float4(1.2 * (PS.Specular.rgb),1.2 * sSkyLightIntensity * PS.FilmDepth.z);

    envMap = lerp(first,second,1-PS.Specular.a);
    float fEnvContribution = 1.0 - 0.5 *fNdotV; 
    float4 finalColor = ((envMap)*(fEnvContribution));
    float4 Color = finalColor;
    Color.rgba += float4(fringeCol,gFilmIntensity* PS.FilmDepth.z) * gFilmIntensity;
    Color.a *= transFactor;
    Color.a *= PS.Diffuse.a;
    return saturate(Color);

}


//------------------------------------------------------------------------------------------
// Techniques
//------------------------------------------------------------------------------------------
technique car_reflect_paint_v2
{
    pass P0
    {
        DepthBias = -0.0003;
        AlphaRef = 1;
        AlphaBlendEnable = TRUE;
        VertexShader = compile vs_2_0 VertexShaderFunction();
        PixelShader  = compile ps_2_0 PixelShaderFunction();
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
