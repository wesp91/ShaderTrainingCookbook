Shader "CookbookShaders/Chapter6/Snow"
{
    Properties
    {
        _Color ("Color", Color) = (1.0,1.0,1.0,1.0)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Bump ("Bump", 2D) = "bump" {}
        _Snow ("Snow", Range(-1,1)) = 0
        _SnowColor ("Snow Color", Color) = (1.0,1.0,1.0,1.0)
        _SnowDirection ("Snow Direction", Vector) = (0,1,0)
        _SnowDepth ("Depth of Snow", Range(0,1)) = 0
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        #pragma surface surf Standard vertex:vert
        #pragma target 3.0

        sampler2D _MainTex;
        float4 _Color;
        sampler2D _Bump;
        float _Snow;
        float4 _SnowColor;
        float4 _SnowDirection;
        float _SnowDepth;

        struct Input
        {
            float2 uv_MainTex;
            float2 uv_Bump;
            float3 worldNormal;
            INTERNAL_DATA
        };
        
        

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            half4 c = tex2D(_MainTex, IN.uv_MainTex);

            o.Normal = UnpackNormal(tex2D(_Bump, IN.uv_Bump));
            if(dot(WorldNormalVector(IN, o.Normal), _SnowDirection.xyz) >= _Snow)
            {
                o.Albedo = _SnowColor.rgb;
            }
            else
            {
                o.Albedo = c.rgb * _Color;
            }
            o.Alpha = 1;
        }

        void vert(inout appdata_full v)
        {
            float4 sn = mul(UNITY_MATRIX_IT_MV, _SnowDirection);

            if(dot(v.normal, sn.xyz) >= _Snow)
            {
                v.vertex.xyz += (sn.xyz + v.normal) * _SnowDepth * _Snow;
            }
        }
        ENDCG
    }
    FallBack "Diffuse"
}
