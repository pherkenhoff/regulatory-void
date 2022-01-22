******************************************************
***************** REPLICATION FILES: *****************
**** The International Organization of Production ****
*************** in the Regulatory Void ***************
***** Philipp Herkenhoff and Sebastian Krautheim *****
******************************************************

clear all
set more off
set varabbrev off

cd "...\regulatory-void"

**build dataset
use ".\data\Regulatory_Void_07_10.dta", clear

append using ".\data\Regulatory_Void_11_14.dta"


**R&D data from AC2013
do ".\code\define_vargroups_publicRandD.do"
	
***R&D data from Compustat // data missing for confidentiality reasons
* do ".\define_vargroups.do" 	
	
*************
*** PAPER ***
*************

do ".\code\table_1_2_3_A1_OA12.do"

***********************
*** ONLINE APPENDIX ***
***********************

*** EPI

do ".\code\table_OA1OA2.do"

*** AGGREGATED CAPITAL INTENSITY

do ".\code\table_OA3OA4.do"

*** ALTERNATIVE INTENSITY DEFINITIONS

do ".\code\table_OA5OA6OA7.do"

*** POLLUTION

do ".\code\table_OA8OA9.do"

*** CROSS-COUNTRY DIMENSION

do ".\code\table_OA10OA11.do"
