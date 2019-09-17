// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "CookbookShaders/Chapter7/Multiply"
{
    Properties
    {
        _Color ("Main Color", Color) = (1,0,0,1)
        _MainTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            //#include "UnityCG.cginc"

            half4 _Color;
            sampler2D _MainTex;

            struct vertInput
            {
                float4 pos : POSITION;
                float2 texcoord : TEXCOORD0;
            };

            struct vertOutput
            {
                float4 pos : SV_POSITION;
                float2 texcoord : TEXCOORD0;
            };

            vertOutput vert (vertInput input)
            {
                vertOutput o;
                o.pos = UnityObjectToClipPos(input.pos);
                o.texcoord = input.texcoord;
                return o;
            }

            fixed4 frag (vertOutput i) : COLOR
            {
                half4 mainColor = tex2D(_MainTex, i.texcoord);
                return mainColor * _Color;
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}
