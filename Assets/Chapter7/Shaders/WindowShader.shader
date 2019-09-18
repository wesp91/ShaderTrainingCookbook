Shader "CookbookShaders/Chapter7/WindowShader"
{
    Properties
    {
        _MainTex ("Main Texture (RGB)", 2D) = "white" {}
        _Color ("Color", Color) = (1,1,1,1)
        _BumpMap ("Noise Tex", 2D) = "bump" {}
        _Magnitude ("Magnitude", Range(0,1)) = 0.05
    }

    SubShader
    {
        Tags { 
            "Queue"="Transparent" 
            "IgnoreProjector" = "True"
            "RenderType" = "Opaque"
        }

        GrabPass { }

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"
            sampler2D _GrabTexture;

            sampler2D _MainTex;
            fixed4 _Color;
            sampler2D _BumpMap;
            float _Magnitude;

            struct VertInput
            {
                float4 vertex : POSITION;
                float2 texcoord : TEXCOORD0;
            };

            struct VertOutput
            {
                float4 vertex : POSITION;
                float2 texcoord : TEXCOORD0;
                float4 uvGrab : TEXCOORD1;
            };

            VertOutput vert (VertInput v)
            {
                VertOutput o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.texcoord = v.texcoord;
                o.uvGrab = ComputeGrabScreenPos(o.vertex);
                return o;
            }

            fixed4 frag (VertOutput i) : COLOR
            {
                float4 mainColor = tex2D(_MainTex, i.texcoord);
                half4 bump = tex2D(_BumpMap, i.texcoord); 
                half2 distortion = UnpackNormal(bump).rg;

                i.uvGrab.xy += distortion * _Magnitude;

                float4 c = tex2Dproj(_GrabTexture, UNITY_PROJ_COORD(i.uvGrab));
                return c * mainColor * _Color;
            }
            ENDCG
        }
    }
}
