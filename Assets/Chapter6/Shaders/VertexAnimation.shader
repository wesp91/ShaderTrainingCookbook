﻿Shader "CookbookShaders/Chapter6/VertexAnimation"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _TintAmount ("Tint Amount", Range(0,1)) = 0.5
        _ColorA ("Color A", Color) = (1,1,1,1)
        _ColorB ("Color B", Color) = (1,1,1,1)
        _Speed ("Wave Speed", Range(0.1,80)) = 5
        _Frequency ("Wave Frequency", Range(0,5)) = 2
        _Amplitude ("Wave Amplitude", Range(-1,10)) = 1
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Lambert vertex:vert

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        sampler2D _MainTex;
        float _TintAmount;
        fixed4 _ColorA;
        fixed4 _ColorB;
        float _Speed;
        float _Frequency;
        float _Amplitude;
        float _OffsetVal;


        struct Input
        {
            float2 uv_MainTex;
            float3 vertColor;
        };

        

        // Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
        // See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
        // #pragma instancing_options assumeuniformscaling
        UNITY_INSTANCING_BUFFER_START(Props)
            // put more per-instance properties here
        UNITY_INSTANCING_BUFFER_END(Props)


        void vert(inout appdata_full v, out Input o)
        {
            UNITY_INITIALIZE_OUTPUT(Input, o);

            float time = _Time * _Speed;
            float waveValueA = _Amplitude * sin(time + v.vertex.x * _Frequency);

            v.vertex.xyz = float3(v.vertex.x, v.vertex.y + waveValueA, v.vertex.z);
            v.normal = normalize(float3(v.vertex.x + waveValueA, v.vertex.y, v.vertex.z));
            o.vertColor = float3(waveValueA, waveValueA, waveValueA);
        }

        void surf (Input IN, inout SurfaceOutput o)
        {
            half4 c = tex2D(_MainTex, IN.uv_MainTex);
            float3 tintColor = lerp(_ColorA, _ColorB, IN.vertColor).rgb;
            o.Albedo = c.rgb * (tintColor * _TintAmount);
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
