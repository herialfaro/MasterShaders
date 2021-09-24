//01
Shader "Custom/SolidColor"
{
	//02
	Properties
	{
		_Color("Main Color", Color) = (1,1,1,1)
	}

	//03
	Subshader
	{
		//04
		Pass
		{
			//05
			CGPROGRAM
			//PRAGMAS
			#pragma vertex vertexShader
			#pragma fragment fragmentShader
			
			uniform fixed4 _Color;
			//VERTEX INPUT
			struct vertexInput
			{
				fixed4 vertex : POSITION; //object-space
			};
			//VERTEX OUTPUT
			struct vertexOutput
			{
				fixed4 position : SV_POSITION; //projection-space
				fixed4 color : COLOR; //pixel color
			};
			//VERTEX SHADER
			vertexOutput vertexShader(vertexInput i)
			{
				vertexOutput o;
				//o.position = UnityObjectToClipPos(i.vertex); // desde local-space a projection-space
				float x = i.vertex.x;
				float y = i.vertex.y;
				float z = i.vertex.z;
				float w = 1;

				i.vertex = float4(x,y,z,w);

				o.position = mul(unity_ObjectToWorld, i.vertex);
				o.position = mul(UNITY_MATRIX_V, o.position);
				o.position = mul(UNITY_MATRIX_P, o.position);
				o.color = _Color; //color de pixel dinamico
				return o;
			}

			//FRAGMENT SHADER
			// fixed4 fragmentShader(vertexOutput o) : SV_TARGET
			// {
			// 	return o.color;
			// }

			struct pixelOutput
			{
				fixed4 pixel : SV_TARGET;
			};

			pixelOutput fragmentShader(vertexOutput o)
			{
				pixelOutput p;
				p.pixel = o.color;
				return p;
			}

			ENDCG
		}
	}
	//06
	Fallback "Mobile/VertexLit"
}