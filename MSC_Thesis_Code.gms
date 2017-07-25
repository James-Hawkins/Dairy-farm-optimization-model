                 Appendix - GAMS Code
SETS
 h herd composition /1*3/
 heifers(h) /1/
 firstparity(h) /2/
 secondparity(h) /3/
 lact(h) /2*3/
 n nutrient properties /TDN, CP, DE, ADF, NDF, Ca, P, Limit /
 c merged index for all uses of land and feed purchased off farm /1*20/
* Subindices
 land(c) subindex for all land uses(crop and non-crop) /1*6/
 crp(land) subindex for all crops grown on farm /1*4/
 ann(crp) subindex for all annual crops /1*3/
 ncland(land) subindex for all non-crop land uses /5*6/
 fd(c) subindex for crops and off farm feed or supplement being fed to cattle
/1*4,7*20/
 alf(crp) subindex for alfalfa crop /4/
 allmkt(crp) /1*3/
 mkt(crp) subindex for crops going to market only /2,3/
 fdmk(crp) subindex for crops going to market and for feed /1*3/
 offs(fd) subindex for off farm feeds /7*20/
 forage(fd) index for all forages /4,1,12,13,14/
 rough(fd) /1,4,12,13,14/
 conc(fd) /7,8,9,10,11,15,16,17,18,20/
 seq(land) index for all land uses that sequester carbon /4*6/
 fat(fd) index for fats fed to cattle /19/
$ontext
List of feeds/crops making up 'c' index (note elements 5 and 6 are empty)
 1 = corn silage
 2 = soybeans
 3 = wheat
 4 = alfalfa hay
 5 = -
 6 = -
 7 = corn ddgs
 8 = oats
 9 = corn silage
 10 = soybean meal
 11 = soybean meal
 12 = alfalfa silage
 13 = grass 1
 14 = grass 2
 15 = corn grain
 16 = corn gluten meal
86
 17 = wheat
 18 = gluten feed
 19 = vegetable oil
 20 = canola meal
$offtext
;
PARAMETERS
* Per hectare crop costs are based on OMAF 2014
 Cc(crp) per hectare cost of crops
 / 1 605
 2 489.8
 3 496.22
 4 473.75
 /
* Upstream feed emissions intensity estimates from Adom et al (2012)
 Upstream(offs)
 / 7 910
 8 850
 9 390
 10 460
 11 460
 12 170
 13 320
 14 330
 15 390
 16 390
 17 430
 18 390
 19 460
 20 548
 /
* Per hectare estimates of soil N2O (Little et al, 2008)
 SoilN2O(crp) Nitrous oxide emissions for crops 1 through 4
 / 1 4.08
 2 0.343
 3 2.126
 4 0.31
 /
* Rotational constraints
 maxrotn(crp)
 / 1 .75
 2 .5
87
 3 .5
 4 .75
 /
 minrotn(crp)
 /1 .1
 2 .1
 3 .1
 4 .15
 /
* Crop Yields, based on OMAF (2014a)
 BaseYield(crp) per hectare annual yield for crops 1 through 4 (in metric tons)
 / 1 41.94
 2 3.06
 3 5.19
 4 5.52
 /
* Nutrient requirements, based on OMAF (2014a)
 Nreq(crp) per hectare N requirement for crops 1 through 4 (in kg)
 / 1 140
 2 0
 3 100
 4 0
 /
 Preq(crp) per hectare P requirement for crops 1 through 4 (in kg)
 / 1 20
 2 20
 3 20
 4 40
 /
 Kreq(crp) per hectare K requirement for crops 1 through 4 (in kg)
 / 1 50
 2 40
 3 40
 4 30
 /
* Crop Prices, based on OMAF (2014b)
 Pcs(allmkt) market price for crops sold (crops 1 through 3) in $ per metric ton of dry matter
 /1 50
 2 435.5
 3 205.7
 /
* Feed prices, based on AAFC (2014)
 Pb(offs) market prices for off farm feed purchases ($ per metric ton of dry matter)
88
 /
 7 282
 8 322
 9 250
 10 500
 11 500
 12 85
 13 170
 14 170
 15 250
 16 594
 17 290
 18 218
 19 50
 20 475
 /
*Energy requirements are calculated according to IPCC (2006)
* Energy for maintenance
NEm(h) Net energy requirements for maintenance (Kcal per day)
 /
 1 42
 2 49.7
 3 49.7
 /
* Energy for growth
NEg(h) Net energy requirements for gain (Kcal per day)
 /
 1 9
 2 0
 3 0
 /
* Energy for lactation
NEl(h) Net energy requirements for lactation
 /
 1 0
 2 76.804
 3 88.620
 /
* Number of animals in each cohort, based on DFO (2012)
Qa(h) Number of animals in cohort
 /1 50
 2 50
 3 50
89
 /
* Protein retained for gain, based on IPCC (2006)
PRgain(h)
 / 1 .05
 2 0
 3 0
 /
* Energy coefficients for farm field work
Efuel(crp)
 / 1 3.29
 2 1.72
 3 1.34
 4 0.81
 /
* Energy coefficients for herbicide production
Eherb(crp)
 / 1 0.0
 2 0.12
 3 0.12
 4 0.24
 /
* Milk yields, Based (loosely) on DFO website
DailyYield(h)
 / 1 0
 2 26
 3 30
 /
;
* Nutrient Properties of feeds, based on NRC 2001
TABLE NutProp(fd,n)
 TDN CP DE ADF NDF Ca P Limit
 1 0.688 0.088 1.91 0.280 0.450 0.012 0.0026 1.00
 2 0.572 0.174 1.84 0.369 0.466 0.000 0.000 0.00
 3 0.599 0.12 1.43 0.376 0.599 0.000 0.000 0.00
 4 0.567 0.228 1.22 0.352 0.432 0.016 0.0031 1.00
 7 0.795 0.297 1.97 0.197 0.388 0.002 0.0083 0.20
 8 0.785 0.132 0.00 0.146 0.3 0.001 0.004 0.50
 9 0.850 0.094 2.09 0.034 0.095 0.004 0.003 1.00
 10 0.814 0.538 2.21 0.062 0.098 0.040 0.007 0.20
 11 0.885 0.463 2.38 0.104 0.217 0.040 0.0066 0.20
 12 0.547 0.178 1.38 0.395 0.509 0.016 0.0031 0
 13 0.563 0.265 0.00 0.458 0.25 0.006 0.0023 0
 14 0.557 0.128 0.00 0.403 0.607 0.006 0.0029 0
 15 0.850 0.094 2.09 0.034 0.095 0.004 0.003 0
 16 0.844 0.65 2.38 0.082 0.111 0.001 0.006 0.20
90
 17 0.866 0.142 1.86 0.044 0.134 0.001 0.0043 0.50
 18 0.741 0.238 1.73 0.121 0.355 0.001 0.01 0.15
 19 1.841 0.000 5.65 0.000 0.000 0.004 0.004 0.03
 20 0.699 0.378 0.00 0.205 0.298 0.006 0.0031 0.10
$ontext
 1 = corn silage
 2 = soybean silage
 3 = wheat silage
 4 = alfalfa
 7 = corn ddgs
 8 = oats
 9 = corn grain
 10 = soybean meal
 11 = soybean meal
 12 = alfalfa hay
 13 = grass
 14 = grass
 15 = corn grain
 16 = corn gluten meal
 17 = wheat
 18 = gluten feed
 19 = vegetable oil
 20 = canola meal
$offtext
SCALARS
* IPCC (2006) value for methane producing capacity
 Bo /.24/
*Based on DFO (2012)
 Pm per hectoliter price of milk /73.5/
* Default value for ash (IPCC, 2006)
 Ash /8/
*Fertilizer prices (OFIMP, 2012; Wilson 2014)
 Pn per kg cost of N fertilizer /1.78/
 Pp per kg cost of P fertilizer /2.67/
 Pk per kg cost of K fertilizer /1.7/
* (Fixed) Farm Characteristics
 At total number of hectares of land available /150/
* NMAN3 Software (OMAF)
 ManNcont manure N content /.0043/
 ManPcont manure P content /.001/
 ManKcont manure K content /.0027/
;
91
POSITIVE VARIABLES
Qf(h,c) amount of crop c being fed to the animal
*Ration Variables
 GE(h) gross energy intake
 DMI(h) dry matter intake
 CP(h) crude protein intake
 ADF(h) acid detergent fibre intake
 NDF(h) neutral detergent fibre intake
 roughage(h) roughage intake
 concentrate(h) concentrate intake
 TDN(h) total digestible nutrients of ration
 REM(h) ratio of net energy available in diet for maintenance to digestible energy
consumed
 SumCrop total crop land on farm
 MCF methane conversion factor
 REG(h) ratio of net energy available in diet for gain to digestible energy consumed
Variable
 DietTDN(h) total digestible nutrients of ration
 ForageDMI(h) total forage intake of the animal
 ForageNDF(h) forage NDF intake of the animal
 Calcium(h) calcium intake of the animal
 Phosphorous(h) phosphorous intake of the animal
* Objective function variables
Variable Profit
Positive Variables
 Rev total revenue
 Costs total costs
 TotalDairyCosts define total costs related to dairy operation
 TotalCropCosts define total costs related to crop operation
 FdCosts define total feed costs
 ManCosts define total manure management costs
 OthrCosts define other dairy costs
 CrpCosts define costs of maintaining crop land
 FertCosts define total costs related to fertilizers
 RegCosts define regulatory costs
*Manure Variables
 mapp(crp) manure applied specifically on each individual crop
 ManUsed Total manure used on cropland
 Nexcr(h) N excreted by the animal
 man1 manure produced by heifers
 man2 manure produced by first parity cows
 man3 manure produced by second parity cows
 man total amount of manure produced
92
* Land and Nutrient Variables
 A(land) Hectares of land devoted to all possible types of land
 Ac(land) Hectares of land devoted to each crop
 Anc(land) Hectares of land devoted to non crop uses
 tNfert total N fertilizer used
 tPfert total P fertilizer used
 tKfert total K fertilizer used
 Nfert(crp) amount of N fertilizer used on crop c
 Pfert(crp) amount of P fertilizer used on crop c
 Kfert(crp) amount of K fertilizer used on crop c
 Napp(crp) amount of N required and applied on crop c
 Papp(crp) amount of P required and applied on crop c
 Kapp(crp) amount of K required and applied on crop c
*Production Variables
Positive Variable Yield(crp) crop yield
Variable Qc(crp) Amount of crops produced
 Qcf(crp) Amount of crops going to feed
 Qcs(crp) Amount of crops going to market
 Qofp(offs) Amount of off farm purchases made
 Qofb(offs) Amount of off-farm feed purchased
 Qfd(fd) Amount of all types of feed
 DailyMilkYield(h) milk yield of the animal
 Qm hectoliters of milk produced
* Greenhouse Gas Variables
PRlactation(h) protein retained for lactation
Cseq(alf) C sequestered from alfalfa
VS volatile solids produced
PI(h) protein intake of the animal
* GHG Emissions
Variable SumSoilN2O sum of soil N2O from crops produced on the farm
EntericCH4 enteric methane emissions
MM manure methane emissions
MN2O manure nitrous oxide emissions
tCseq C sequestration from land use change on the farm
FarmEnergyCO2
USEmissions upstream emissions from feed production
Ems energy emissions from manure spreading
Emilking energy emissions from milking
Effw energy emissions from farm field work
Efah energy emissions from fertilizer and herbicide manufacturing
Variable TotalGHGs total GHG emissions
;
93
* Declarations of variable bounds (required to avoid divide by zero, and other errors)
DietTDN.l(h) = .001 ;
Qc.l(fdmk) = 100;
man.lo = 3;
REM.lo(h) = .01 ;
REG.lo(h) = .01 ;
DMI.lo(h) = .01;
EQUATIONS
* Objective Function
 Objective define objective function
 Revenue define revenue
 Cost define cost
 TotalDairyCost define total dairy cost
 TotalCropCost define total crop cost
 FeedCosts costs for purchasing feed
 ManureManagementCosts define cost of manure management
 OtherDairyCosts define costs for all other categories of dairy production costs
 CropCosts define costs for maintaining crop land
 FertilizerCosts define costs for purchase of fertilizer
 RegulatoryCosts define fees paid to regulators
* Identities
 CropProduction(crp) define quantity of crops produced
 MilkProduction define quantity of milk produced
 ManureProduction1(heifers) define amount of manure produced
 ManureProduction2(firstparity) define amount of manure produced
 ManureProduction3(secondparity) define amount of manure produced
 TotalManure sum of manure produced on farm
 ManureFate define fate of manure
 ManureExport ensure that manure produced is applied on farm
 FeedFate define fate of crops produced on farm
 CropLand define land allocation on the farm
 NonCropLand define land allocation on the farm
 LandFate set total land allocated to crops to amount of land on the farm
 rotation(crp) crop rotation constraint
 rotation2(crp) crop rotation constraint 2
 CropFate1(fdmk) define fate of crops used as feed and sold
 CropFate2(alf) define fate of alfalfa on the farm
 Nrequirements(crp) define N requirements for crops
 Prequirements(crp) define P requirements for crops
 Krequirements(crp) define K requirements for crops
 Napplication(crp) define amount of N applied
 Papplication(crp) define amount of P applied from all sources
94
 Kapplication(crp) define amount of K applied from all sources
 TotalNFertilizer define total N fertilizer used on farm
 TotalPFertilizer define total P fertilizer used on farm
 TotalKFertilizer define total K fertilizer used on farm
 TotalDigestibleNutrients(h) determine TDN of rations
 DryMatterIntake(h) determine DMI of the rations
 CrudeProteinIntake(h) determine CP of the rations
 NeutralDetergentFibreIntake(h) determine NDF of the rations
 AcidDetergentFibreIntake(h) determine ADF of the rations
 CalciumIntake(h) determine Calcium intake of the rations
 PhosphorousIntake(h) determine Phosphorous intake of the rations
 ForageIntake(h) determine forage intake of the rations
 ForageNDFIntake(h) determine forage NDF intake of the rations
 RoughageIntake(h) determine roughage intake of the rations
 ConcentrateIntake(h) determine concentrate intake of the rations
 EnergyRequirement_Lactating(lact) ensure cows receive required energy
 EnergyRequirement_Heifers(heifers) ensure heifers receive required energy
 ProteinRequirement2(h) ensure protein requirements
 FibreRequirement1(h) ensure fibre requirements
 FibreRequirement2(h) ensure fibre requirements
 FibreRequirement3(h) ensure fibre requirements
 FibreRequirement4(h) ensure fibre requirements
 CalciumRequirement(h) ensure calcium requirements
 PhosphorousRequirement(h) ensure phosphorous requirements
 Limit1(fd,h) upper bounds of feeds in rations
 ForageRequirement1(h) ensure forage requirements
 ForageRequirement2(h) ensure forage requirements
 ForageNDFRequirement(h) ensure forage NDF requirements
 NetToDigestibleEnergyMaintenance(h) calculate REM
 NetToDigestibleEnergyGain(h) calculate REG
 GrossEnergyCalculation(h) calculate GE
 TotalEntericMethane calculate enteric methane
 VolatileSolids calculate volatile solids
 ManureMethane calculate manure methane
 ManureFactor define methane conversion factor (MCF)
 ProteinIntake(h) determine protein intake
 ProteinForLactation(h) determine protein retained for lactation
 NExcretion(h) determine N excretion
 ManureN2O determine manure nitrous oxide emissions
 TotalSoilN2O determine soils N2O from farm soils
 CarbonSequestered4 Determine cabon sequestered through land use change on the farm
 TotalGHGEmissions Sum of GHG emissions
 ManureEmissions Energy related emissions from manure spreading
 MilkingEmissions Energy related emissions from milking
 FarmFieldWorkEmissions Energy related emissions from farm field work
 FertilizerandHerbicideEmissions Energy related emissions from manufacturing of inputs
95
 EnergyEmissions Sum of energy emissions
 OffFarmEmissions Upstream emissions from feed production
 EmissionConstraint GHG restriction
;
* OBJECTIVE FUNCTION
Objective .. Profit =E= Rev - Costs ;
Revenue .. Rev =E= Qm*Pm +
Sum((allmkt),Qcs(allmkt)*Pcs(allmkt)) ;
Cost .. Costs =E= TotalDairyCosts + TotalCropCosts + RegCosts;
TotalDairyCost .. TotalDairyCosts =E= FdCosts + OthrCosts ;
TotalCropCost .. TotalCropCosts =E= CrpCosts + FertCosts + ManCosts ;
FeedCosts .. FdCosts =E= Sum((offs),Qofb(offs)*Pb(offs));
OtherDairyCosts .. OthrCosts =E= 12.36*Qm ;
ManureManagementCosts .. ManCosts =E= .00532*ManUsed ;
CropCosts .. CrpCosts =E= Sum((crp),Ac(crp)*Cc(crp)) ;
FertilizerCosts .. FertCosts =E= tNfert*Pn + tPfert*Pp + tKfert*Pk ;
RegulatoryCosts .. RegCosts =E= 0 ;
*** IDENTITIES
* Crop land must sum to total land area
CropLand .. SumCrop =E= Sum((crp),Ac(crp)) ;
NonCropLand .. 0 =E= Sum((ncland),Ac(ncland)) ;
LandFate .. At =E= SumCrop ;
* Upper and lower bounds for crop rotation
rotation(crp) .. maxrotn(crp)*SumCrop =G= Ac(crp);
rotation2(crp) .. minrotn(crp)*SumCrop =L= Ac(crp);
* Production functions for crops, milk, and manure
cropproduction(crp) .. Qc(crp) =E= Ac(crp)*BaseYield(crp) ;
milkproduction .. Qm =E= 7981 ;
ManureProduction1(heifers) .. man1 =E= Qa(heifers)*(DMI(heifers)*4.158-
480*.0246) ;
ManureProduction2(firstparity) .. man2 =E= Qa(firstparity)*(DMI(firstparity)*2.63
+ 9.4) ;
ManureProduction3(secondparity) .. man3 =E=
Qa(secondparity)*(DMI(secondparity)*2.63 + 9.4) ;
TotalManure .. man =E= (man1 + man2 + man3) ;
* Manure not applied on land is exported
96
ManureFate .. ManUsed =E= Sum((crp),mapp(crp)) ;
ManureExport .. man - ManUsed =E= 0 ;
* Define fate of crops grown on farm (i.e. to feed or to market)
CropFate1(fdmk) .. Qc(fdmk) =E= Qcs(fdmk) +
(Sum((h),Qa(h)*Qf(h,fdmk)*365)/1000);
CropFate2(alf) .. Qc(alf) =E= Sum((h),Qa(h)*Qf(h,alf)*365)/1000;
FeedFate(offs) .. Qofb(offs) =E= Sum((h),Qa(h)*Qf(h,offs)*365)/1000;
* Determine total nutrient requirements
Napplication(crp) .. Napp(crp) =E= Ac(crp)*Nreq(crp) ;
Papplication(crp) .. Papp(crp) =E= Ac(crp)*Preq(crp) ;
Kapplication(crp) .. Kapp(crp) =E= Ac(crp)*Kreq(crp) ;
* Determine source of nutrients
Nrequirements(crp) .. Napp(crp) =E= mapp(crp)*ManNcont + Nfert(crp) ;
Prequirements(crp) .. Papp(crp) =E= mapp(crp)*ManPcont + Pfert(crp) ;
Krequirements(crp) .. Kapp(crp) =E= mapp(crp)*ManKcont + Kfert(crp) ;
* Tally the sum of each type of fertilizer required to meet crop nutrients
TotalNFertilizer .. tNFert =E= Sum((crp),Nfert(crp)) ;
TotalPFertilizer .. tPFert =E= Sum((crp),Pfert(crp)) ;
TotalKFertilizer .. tKFert =E= Sum((crp),Kfert(crp)) ;
*** DEFINE NUTRIENT PROPERTIES OF THE RATION
TotalDigestibleNutrients(h) .. DietTDN(h) =E=
(Sum((fd),(Qf(h,fd)/DMI(h))*NutProp(fd,"TDN")))*100 ;
DryMatterIntake(h) .. DMI(h) =E= Sum((fd),Qf(h,fd)) ;
CrudeProteinIntake(h) .. CP(h) =E= Sum((fd),Qf(h,fd)*NutProp(fd,"CP"));
AcidDetergentFibreIntake(h) .. ADF(h) =E=
Sum((fd),Qf(h,fd)*NutProp(fd,"ADF"));
NeutralDetergentFibreIntake(h) .. NDF(h) =E=
Sum((fd),Qf(h,fd)*NutProp(fd,"NDF"));
ForageIntake(h) .. ForageDMI(h) =E= Sum((forage),Qf(h,forage));
ForageNDFIntake(h) .. ForageNDF(h) =E=
Sum((forage),Qf(h,forage)*NutProp(forage,"NDF"));
CalciumIntake(h) .. Calcium(h) =E= Sum((fd),Qf(h,fd)*NutProp(fd,"Ca"));
PhosphorousIntake(h) .. Phosphorous(h) =E= Sum((fd),Qf(h,fd)*NutProp(fd,"P"));
RoughageIntake(h) .. roughage(h) =E= Sum((rough),Qf(h,rough));
ConcentrateIntake(h) .. concentrate(h) =E= Sum((conc),Qf(h,conc));
*** DEFINE NUTRIENT REQUIREMENTS FOR ANIMALS
EnergyRequirement_Lactating(lact) .. (NEm(lact)+ NEg(lact)+ NEl(lact))*.2388459
=E= DMI(lact)*(.0245*DietTDN(lact)-.12);
97
EnergyRequirement_Heifers(heifers) .. 22.5 =E=
(.04409*DietTDN(heifers)*1.01 -.45)*DMI(heifers);
ProteinRequirement2(h) .. .2*DMI(h) =G= CP(h);
FibreRequirement1(h) .. DMI(h)*0.17 =L= ADF(h);
FibreRequirement2(h) .. DMI(h)*0.25 =L= NDF(h);
FibreRequirement3(h) .. DMI(h)*0.27 =G= ADF(h);
FibreRequirement4(h) .. DMI(h)*0.35 =G= NDF(h);
ForageRequirement1(h) .. .5*DMI(h) =G= ForageDMI(h);
ForageRequirement2(h) .. 0.2*DMI(h) =L= ForageDMI(h);
ForageNDFRequirement(h) .. 0.20*DMI(h) =L= ForageNDF(h);
Limit1(fd,h) .. Qf(h,fd) =L= NutProp(fd,"Limit")*DMI(h) ;
CalciumRequirement(h) .. Sum(fd,Qf(h,fd)*NutProp(fd,"Ca")) =G= .003*DMI(h)
;
PhosphorousRequirement(h) .. Sum(fd,Qf(h,fd)*NutProp(fd,"P")) =G=
.003*DMI(h) ;
*** EMISSIONS ESTIMATION PROCEDURE (determined by the ration)
* Enteric Methane
TotalEntericMethane .. EntericCH4/25 =E= (1/55.58)*Sum( (h),
Qa(h)*365*(2.16 + 0.493*DMI(h) - 1.36*ADF(h) + 1.97*NDF(h)));
* Manure Methane
NetToDigestibleEnergyMaintenance(h) .. REM(h) =E= 1.123 -
(0.004092*DietTDN(h)) + (0.00001126*DietTDN(h)*DietTDN(h)) - (25.4/DietTDN(h));
NetTodigestibleEnergyGain(h) .. REG(h) =E= 1.164 -
(0.005160*DietTDN(h)) + (0.00001308*DietTDN(h)*DietTDN(h)) - (37.4/DietTDN(h));
GrossEnergyCalculation(h) .. GE(h) =E= (((NEm(h) + NEl(h))/REM(h)) +
(NEg(h)/REG(h)))*100/DietTDN(h);
VolatileSolids(h) .. VS(h) =E= (GE(h)*(1-(DietTDN(h)/100)) +
0.04*GE(h))*.92/18.45 ;
ManureFactor .. MCF =E= .18;
ManureMethane .. MM/25 =E=
Sum((h),365*Qa(h)*VS(h)*Bo*MCF*0.67);
* Manure Nitrous Oxide
ProteinIntake(h) .. PI(h) =E= (GE(h)*CP(h)/DMI(h))/18.45;
ProteinForLactation(h) .. PRlactation(h) =E= DailyYield(h)*0.035;
NExcretion(h) .. Nexcr(h) =E= (PI(h)/6.25) - (PRlactation(h)/6.38) -
(PRgain(h)/6.25);
ManureN2O .. MN2O/298 =E= 365*Sum((h),Qa(h)*Nexcr(h)*(.005
+ .4*.01)) ;
* Soil Nitrous Oxide (a function of ration)
98
* Note: this distinguishes between emissions from crops used in the rations, and those sold
TotalSoilN2O .. SumSoilN2O/298 =E=
Sum((alf),SoilN2O(alf)*Ac(alf)) +
Sum(fdmk,Ac(fdmk)*SoilN2O(fdmk)*((Sum((h),Qa(h)*Qf(h,fdmk)*365)/1000)/Qc(fdmk))) ;
* Carbon Sequestration from land use change (assumes original land allocation has 15% of
farmland allocated to alfalfa)
CarbonSequestered4 .. tCseq =E=
1*(44/12)*10*3691*0.0238*((Sum(seq,Ac(seq))/150)-.15)*150 ;
* GHG Summation
* Energy Emissions
EnergyEmissions .. FarmEnergyCO2 =E= Ems + Emilking + Effw +
Efah ;
ManureEmissions .. Ems =E= .266*ManUsed*.0248*70 ;
MilkingEmissions .. Emilking =E= 968*100*.2 ;
FarmFieldWorkEmissions .. Effw =E=
Sum((crp),Ac(crp)*Efuel(crp))*70 ;
FertilizerandHerbicideEmissions .. Efah =E=
Sum(crp,Eherb(crp)*Ac(crp))*5.8 + 3.59*tNfert + .569*tPfert;
OffFarmEmissions .. USEmissions =E=
Sum((offs),Upstream(offs)*Sum((h),Qa(h)*Qf(h,offs)*365)/1000);
TotalGHGEmissions .. TotalGHGs =E= EntericCH4 + MM + MN2O
+ SumSoilN2O + USEmissions + FarmEnergyCO2 - tCseq;
EmissionConstraint .. TotalGHGs =G= 1 ;
MODEL DAIRYFARM /ALL/;
Solve DAIRYFARM Maximizing Profit using NLP;