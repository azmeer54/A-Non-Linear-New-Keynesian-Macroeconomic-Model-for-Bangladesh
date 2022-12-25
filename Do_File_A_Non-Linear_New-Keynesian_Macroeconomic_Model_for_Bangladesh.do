// Parameterization of Equations for "A Non-Linear New-Keynesaian Macoreconomics Model for Bangladesh" 
// Here, Y = ln Y 

set more off

clear all 

// Estimating Paramaters of New-Keynesian IS Curve. 
use "https://github.com/azmeer54/A-Non-Linear-New-Keynesian-Macroeconomic-Model-for-Bangladesh/blob/main/Data_A_Non-Linear_New-Keynesian_Macroeconnomic_Model_for_Bangladesh/is_curve.dta?raw=true"

tsset 

constraint 1 [Y]u1 = 0 // Imposed Constraint 

varsoc Y f_Y l_r // lag is 1 

sspace (u1 L.u1, state noconstant) (Y f_Y l_r u1, noconstant ) , constraints(1) method(hybrid) covstate(unstructured) // VAR(1) Model 

constraint 11 [Y]u11 = 1

sspace (u11 L.u11, state noconstant) (D.Y u11, noconstant ) , constraints(11) method(hybrid) covstate(unstructured) // AR(1) Model 

clear all 

// Estimating Paramaters of New-Keynesian PC Curve. 
use "https://github.com/azmeer54/A-Non-Linear-New-Keynesian-Macroeconomic-Model-for-Bangladesh/blob/main/Data_A_Non-Linear_New-Keynesian_Macroeconnomic_Model_for_Bangladesh/pc_curve.dta?raw=true"

tsset 

constraint 3 [pi]u3 = 0

varsoc pi Y f_pi // lag is 1 

sspace (u3 L.u3, noconstant state) (pi Y f_pi u3, noconstant ) , constraints(3) method(hybrid) covstate(unstructured) // VAR(1) Model 

constraint 31 [pi]u31 = 1

sspace (u31 L.u31, noconstant state) (D.pi u31, noconstant ) , constraints(31) method(hybrid) covstate(unstructured) // AR(1) Model 

clear all 

// Estimating Paramaters of MP Rule. 
use "https://github.com/azmeer54/A-Non-Linear-New-Keynesian-Macroeconomic-Model-for-Bangladesh/blob/main/Data_A_Non-Linear_New-Keynesian_Macroeconnomic_Model_for_Bangladesh/mp_curve.dta?raw=true"

tsset 

constraint 2 [r]u2 = 0

varsoc r f_Y f_pi // lag is 1 

sspace (u2 L.u2, noconstant state) (r f_pi f_Y u2, noconstant ) , constraints(2) method(hybrid) covstate(unstructured) // VAR(1) Model 


constraint 21 [r]u21 = 1

sspace (u21 L.u21, noconstant state) (D.r u21, noerror ) , constraints(21) method(hybrid) covstate(unstructured) // AR(1) Model 

clear all 

// Estimating Paramaters of Open Economy Block.  
use "https://github.com/azmeer54/A-Non-Linear-New-Keynesian-Macroeconomic-Model-for-Bangladesh/blob/main/Data_A_Non-Linear_New-Keynesian_Macroeconnomic_Model_for_Bangladesh/bp_curve.dta?raw=true"

tsset 
varsoc f_pi t piw e // lag is 1 

constraint 4 [f_pi]u4 = 0

sspace (u4 L.u4, noconstant state) (f_pi t piw e, noconstant ) , constraints(4) method(hybrid) covstate(unstructured) // VAR(1) Model 


constraint 41 [piw]u41 = 1

sspace (u41 L.u41, state noconstant) (D.piw u41, noerror), constraints(41) // AR(1) Model 


constraint 42 [e]u42 = 1

sspace (u42 L.u42, state noconstant) (D.e u42, noerror), constraints(42) // AR(1) Model 

clear all 
