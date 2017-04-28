clc;
% clear all;
close all;
% a=[71	72	85	103	105	110	115	125	139	149	174	208	226	244	257	271	287;
% 245	251	236	226	256	219	215	224	242	248	256	248	252	255	248	271	295;
% 80	83	72	74	86	93	111	114	130	144	149	189	199	215	217	212	217;
% 104	111	91	88	69	75	96	114	114	119	147	141	130	122	140	152	186;
% 211	209	225	213	191	186	191	203	177	175	188	207	229	205	209	184	163;
% 314	318	333	320	319	272	287	408	423	353	400	374	405	368	324	273	280;
% 70	60	58	49	48	47	48	61	68	80	89	84	88	100	106	109	100;
% 72	75	75	74	72	72	73	71	72	68	80	91	78	74	88	97	99;
% 193	181	156	149	154	139	125	130	138	156	182	178	211	214	221	234	231;
% 143	126	122	97	86	80	105	133	133	137	161	156	161	158	148	153	148;
% 119	109	120	132	133	156	156	170	182	196	232	219	215	210	215	225	228;
% 247	224	248	252	237	244	230	253	232	232	275	291	283	300	339	315	351;
% 
% ];
aqia=[AQI;AQIS1];
a=aqia';
y=pdist(a,'cityblock');
yc=squareform(y);
z=linkage(y);
[h,t]=dendrogram(z,0);
T=cluster(z,'maxclust',3);
for i=1:3
tm=find(T==i);
tm=reshape(tm,1,length(tm));
fprintf;
end 