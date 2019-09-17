// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "CookbookShaders/Chapter7/GrabPass"
{
    SubShader
    {
        Tags { "Queue"="Transparent" }

        GrabPass { }

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"
            sampler2D _GrabTexture;

            struct VertInput
            {
                float4 vertex : POSITION;
            };

            struct VertOutput
            {
                float4 vertex : POSITION;
                float4 uvGrab : TEXCOORD1;
            };

            VertOutput vert (VertInput v)
            {
                VertOutput o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uvGrab = ComputeGrabScreenPos(o.vertex);
                return o;
            }

            fixed4 frag (VertOutput i) : COLOR
            {
                float4 c = tex2Dproj(_GrabTexture, UNITY_PROJ_COORD(i.uvGrab));
                return c + half4(0.5,0,0,0);
            }
            ENDCG
        }
    }
}
