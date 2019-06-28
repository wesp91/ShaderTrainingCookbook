Shader "CookbookShaders/Chapter3/RadiusShader"
{
    Properties
    {
        _MainTex ("Main Texture", 2D) = "white" {}
        _Center ("Center", Vector) = (200, 0, 200, 0)
        _Radius ("Radius", Float) = 100
        _RadiusColor ("Radius Color", Color) = (1,0,0,1)
        _RadiusWidth ("Radius Width", Float) = 10
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Standard fullforwardshadows

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0


        struct Input
        {
            float2 uv_MainTex;
            float3 worldPos;
        };

        sampler2D _MainTex;
        fixed3 _Center;
        float _Radius;
        fixed4 _RadiusColor;
        float _RadiusWidth;

        // Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
        // See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
        // #pragma instancing_options assumeuniformscaling
        UNITY_INSTANCING_BUFFER_START(Props)
            // put more per-instance properties here
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            float d = distance(_Center, IN.worldPos);

            if((d > _Radius) && d < (_Radius + _RadiusWidth))
                o.Albedo = _RadiusColor.rgb;
            else
                o.Albedo = tex2D(_MainTex, IN.uv_MainTex);
        }
        ENDCG
    }
    FallBack "Diffuse"
}
