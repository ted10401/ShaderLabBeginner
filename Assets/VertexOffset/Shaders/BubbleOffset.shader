Shader "Custom/BubbleOffset"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_Offset ("Offset", Float) = 0
		_SinSpeed ("Sin Speed", Float) = 1
		_SinWave ("Sin Wave", Float) = 1
		_CosSpeed ("Cos Speed", Float) = 1
		_CosWave ("Cos Wave", Float) = 1
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
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
				float4 normal : NORMAL;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;
			float _Offset;
			float _SinSpeed;
			float _SinWave;
			float _CosSpeed;
			float _CosWave;
			
			v2f vert (appdata v)
			{
				v2f o;
				v.vertex.xyz += _Offset * v.normal * (sin((v.vertex.x + _Time.y * _SinSpeed) * _SinWave) + cos((v.vertex.z + _Time.y * _CosSpeed) * _CosWave));
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);

				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				fixed4 col = tex2D(_MainTex, i.uv);
				return col;
			}
			ENDCG
		}
	}

	Fallback "Diffuse"
}
