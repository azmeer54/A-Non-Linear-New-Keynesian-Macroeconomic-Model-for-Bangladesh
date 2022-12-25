/*
 * This file estimates the New Keynesian model of Md. Azmeer Rahman Sorder (2022) for research monograph titled. 
 * Codes for the monograph titled "A Non-Linear New-Keynesian Macroeconomic Model for Bangladesh". Here y = ln Y 
*/

% The Endogeneous Variables

var	y ${y}$ (long_name='Real GDP (Natural Log)')
    	r ${r}$ (long_name='Real Interest Rate')
    	pih ${pih}$ (long_name='Domestic Inflation')                                       
	piw ${piw}$ (long_name='World Inflation')   
    	ttau ${ttau}$ (long_name='Terms of Trade')           
	e ${e}$ (long_name='Real Effective Exchange Rate') 
    	ry rpih rr 
        ;

% The Exogenous Variables

varexo eps_y eps_pih eps_r eps_piw eps_e;

% Parameter decleration

parameters R_1_IS R_2_IS R_1_PC R_2_PC R_1_MP R_2_MP R_1_O R_2_O R_3_O rho_y rho_pih rho_r rho_piw rho_e ;

% Calibrating Parameters 

R_1_IS = 0.9962581 ;    % Author's calibration
R_2_IS = -0.0003882 ;     % Author's calibration
R_1_PC = 0.3401221 ;      % Author's calibration
R_2_PC = 0.3014055 ;       % Author's calibration
R_1_MP = -0.2469938 ;       % Author's calibration
R_2_MP =  0.5920829 ;       % Author's calibration
R_1_O = 2.76374 ;       % Author's calibration
R_2_O = -.0682651 ;        % Author's calibration
R_3_O = .1088855;       % Author's calibration
rho_y = 0.0283223 ;       % Author's calibration
rho_pih = 0.3175549 ;      % Author's calibration
rho_r = 0.8766662 ;       % Author's calibration
rho_piw =  0.5029374 ;      % Author's calibration
rho_e = 0.8453699 ;        % Author's calibration

% Declaring the Model 

model(linear);

% New-Keynesian IS curve
[name ='New-Keynesian IS curve']
y = R_1_IS * y(+1) + R_2_IS * r(-1) + ry ;                                        

% New-Keynesian Phillips Curve
[name ='New-Keynesian Phillips Curve']
pih = R_1_PC * y + R_2_PC * pih(+1) + rpih ;                   

% Monetary Policy Rule 
[name ='Monetary Policy Rule']
r = R_1_MP * pih(+1) + R_2_MP * y(+1) + rr ;            

% Open Economy 
[name ='Open Economy Equation']
pih(+1) = R_1_O * ttau + R_2_O * piw + R_3_O * e ;   

% shock processes
% Output Shock 
[name ='Real GDP Shock']
ry = rho_y * ry(-1) + eps_y;                                                       

% Price Shock
[name ='Domestic Price Shock']
rpih = rho_pih * rpih(-1) + eps_pih;                                               

% Real Interest Rate Shock 
[name ='Real Interest Rate Shock']
rr = rho_r * rr(-1) + eps_r;                                          

% World Price Shock  
[name ='World Price Shock']
piw = rho_piw * piw(-1) + eps_piw; 

% Real Exchange Rate Shock 
[name ='Real Exchange Rate Shock']
e = rho_e * e(-1) + eps_e; 
end;

shocks;
var eps_y=1;       % 1 percent increase in y
var eps_pih=1;      % 1 percent increase in pih 
var eps_r=1;        % 1 percent increase in r
var eps_piw=1;        % 1 percent increase in piw
var eps_e=1;       % 1 percent increase in e 
end;

estimated_params;
R_1_IS, , 0.9959597, 0.9965564; 
R_2_IS, , -0.0008365, 0.0000602; 
R_1_PC, , 0.1710628, 0.5091814; 
R_2_PC, , -0.0365945, 0.6394054; 
R_1_MP, , -0.7364556, 0.242468;  
R_2_MP, , 0.3432667, 0.840899;  
R_1_O, , -0.2877892, 5.815269;  
R_2_O, , -0.3525952, 0.2160649; 
R_3_O, , 0.0275427, 0.1902283; 
rho_y, , 0.0183076, 0.038337; 
rho_pih, , -4.055771, 4.690881; 
rho_r, , -1261.174, 1262.927; 
rho_piw, , -781.8764, 782.8822; 
rho_e, , -1261.234, 1262.924; 
end;

estimated_params_init(use_calibration);
end;
 
check; 
steady; 
resid; 
stoch_simul(order=1, IRF=35) y r pih ttau;
