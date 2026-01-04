state\_73\_old

A: DUMMY.FOAM

1\. ComputeDerivatives filter

\-	scalars: p

\-	output vector type: vorticity

\-	output tensor type: Strain

\-	Representation : Surface



2\. Calculator filter (Vorticity magnitude) 

sqrt(Vorticity\_X\*Vorticity\_X + Vorticity\_Y\*Vorticity\_Y + Vorticity\_Z\*Vorticity\_Z)

\-	Attribute type: Cell data

\-	Result Array Name Vorticity\_mag

\-	Representation : Surface

\-	coloring: U, magnitude



3\. Calculator filter (StrainNorm Squared) 

2\*(Strain\_0\*Strain\_0 + Strain\_4\*Strain\_4 + Strain\_8\*Strain\_8 + 2\*(0.25\*(Strain\_1 + Strain\_3)\*(Strain\_1 + Strain\_3) + 0.25\*(Strain\_2 + Strain\_6)\*(Strain\_2 + Strain\_6) + 0.25\*(Strain\_5 + Strain\_7)\*(Strain\_5 + Strain\_7))) 

\-	Attribute type: Cell data

\-	Result Array Name StrainNorm Squared

\-	Representation : Surface

\-	coloring :p



4\. Calculator filter Omega Criterion

(Vorticity\_mag\*Vorticity\_mag)/(Vorticity\_mag\*Vorticity\_mag + StrainNormSquared + 1e-12) 

\-	Attribute type: Cell data

\-	Result Array Name OmegaCriterion

\-	Representation : Surface

\-	coloring: Omega Criterion



5\. CellData to point data filter

\-	coloring : omega criterion



6\. clips

clip origin; (95 65.9501 1.2) normal 	1 0 0

clip origin; (130 93.2783 1.2) normal 	1 0 0

clip origin; (112.5 75 1.2) normal	0 1 0

clip origin; (112.5 101.932 1.2) normal 0 1 0



7\. Resample to Image

467 342 32



8 Threshold filter

\-	scalars: OmegaCriterion

\-	min: 0.6

\-	max: 0.97041



9\. Threshold filter

\-	scalars: Vorticity\_mag

\-	min: 0.1

\-	max: 10

\-	coloring: vorticity (PLOT THIS)





10\. Histogram

\-	vorticity\_mag



11\. Plot data over time

\-	filed Assoc: points



**B: ON SAME DUMMY.FOAM**

1\. clips

clip origin; (90 65.9501 1.2) normal 	1 0 0

clip origin; (130 86.5081 1.2) normal 	1 0 0

clip origin; (110 74 1.2) normal	0 1 0

clip origin; (110 105 1.2) normal 0 1 0



2\. StreamTracer

\-	Vectors: U

\-	Resolution: 50

\-	Through culverts



**C: STL**

\-	load stl

\-	slice middle

\-	line width: 1.5

\-	point size: 2



































