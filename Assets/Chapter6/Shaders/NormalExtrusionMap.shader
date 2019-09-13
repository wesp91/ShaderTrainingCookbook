﻿Shader "CookbookShaders/Chapter6/NormalExtrusionMap"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _ExtrusionTex ("Extrusion Map", 2D) = "white" {}
        _Amount ("Extrusion Amount", Range(-0.0001, 0.0001)) = 0
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Standard vertex:vertFunction

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        
        struct Input
        {
            float2 uv_MainTex;
        };

        sampler2D _MainTex;
        sampler2D _ExtrusionTex;
        float _Amount;


        void vertFunction(inout appdata_full v)
        {
            float4 tex = tex2Dlod(_ExtrusionTex, float4(v.texcoord.xy, 0, 0));
            float extrusion = tex.r * 2 - 1;
            v.vertex.xyz += v.normal * _Amount * extrusion;
        }

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            float4 tex = tex2D(_ExtrusionTex, IN.uv_MainTex);
            float extrusion = abs(tex.r * 2 - 1);

            o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb;
            o.Albedo = lerp(o.Albedo.rgb, float3(0,0,0), extrusion * _Amount / 0.0001 * 1.1);
        }
        ENDCG
    }
    FallBack "Diffuse"
}
