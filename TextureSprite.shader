Shader "ShaderEffectBook/TextureSprite" {
	Properties {
		_MainTex("Main Texture",2D) = "white"{}

		_TexWidth("sheet width",float) = 0.0
		_CellAmount("Cell Amount",float) = 0.0
		_Speed("speed",Range(0.01,32)) = 10

		//_timeValue("timeVal")
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		#pragma surface surf Lambert

		sampler2D _MainTex;
		float _TexWidth;
		float _CellAmount;
		float _Speed;
		

		struct Input{
			fixed2 uv_MainTex;
		};

		void surf(Input IN,inout SurfaceOutput o){
			float2 spriteUV = IN.uv_MainTex;

			float cellPixelWidth = _TexWidth/_CellAmount;
			float cellUVPercentage = cellPixelWidth/_TexWidth;

			float timeVal = fmod(_Time.y * _Speed,_CellAmount);
			timeVal = ceil(timeVal);
			//float timeVal = _timeValue;
			float xValue = spriteUV.x;
			xValue += cellUVPercentage * timeVal * _CellAmount;
			xValue *= cellUVPercentage;

			spriteUV = float2(xValue,spriteUV.y);

			half4 c = tex2D(_MainTex,spriteUV);
			o.Albedo = c.rgb;
			o.Alpha = c.a;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
