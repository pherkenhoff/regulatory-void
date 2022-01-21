
*************************************************
***TABLES OA.8 and OA.9: POLLUTION INTENSITIES***
*************************************************

	capture drop sample*
	capture est drop _all
	
	capture erase ".\results\table_OA8.csv"
	capture erase ".\results\table_OA9.csv"
	
	
	
	foreach n in TC {
		foreach k in pt so2 no2  {

				reghdfe rel_share ${pollution_`k'} ${AYcontrols_`n'}, absorb(year_iso3code) vce(cluster i.IO2007_num)
					est store regr_`k'_nointeract
					estfe regr_`k'_nointeract, labels(year_iso3code "Country-Year FE")
				
			foreach m in EPSI HLT EPI  {

				reghdfe rel_share ${pollution_`k'}  c.${pollution_`k'}#c.${`m'} ${AYcontrols_`n'} ${disp} ${Antras_Chor} ${HO_interact_all_nocou_`n'} ${credit_interact_nocou} ${labormarket_interact_nocou} ${contract_interact_nocou} ${interm_interact}, absorb(year_iso3code) vce(cluster i.IO2007_num)
					est store regr_`k'_`m'_contr
					estfe regr_`k'_`m'_contr, labels(year_iso3code "Country-Year FE")
					est restore regr_`k'_`m'_contr
					margins, post dydx(${pollution_`k'}) at((p5) ${`m'}) at((p10) ${`m'}) at( (p20) ${`m'}) at( (p30) ${`m'}) at( (p40) ${`m'}) at( (p50) ${`m'}) at( (p60) ${`m'}) at( (p70) ${`m'}) at( (p80) ${`m'}) at( (p90) ${`m'})
					est store marg_`k'_`m'_contr
					
				}
			}	
		}				
		
		
		di r(indicate_fe)
		
				esttab regr_* using ".\results\table_OA8.csv", replace scsv ///
					cells(b(fmt(a) star) se(par(( )) fmt(a))) order(ln_kg* c.ln_kg_*#*) drop(0.sigma_median_dummy) /// 
					stats(N_clust r2_a N, fmt(a) labels("IO2007 Industry Clusters" "Adj. R2" "Observations")) /// 
					obslast starlevels(* 0.10 ** 0.05 *** 0.01) collabels(none) title("Dependent Variable: Intrafirm Import Share") ///
					mlabels("PT,-" "PT,EPSI" "PT,HLT" "PT,EPI" "SO2,-" "SO2,EPSI" "SO2,HLT" "SO2,EPI" "NO2,-" "NO2,EPSI" "NO2,HLT" "NO2,EPI", lhs(Intensity Definition: Total Cost, Pollutant, Environmental Index:)) ///
					label interact(" X ") noomit indicate(`r(indicate_fe)')
				
				esttab marg* using ".\results\table_OA9.csv", replace scsv ///
					cells(b(fmt(a) star) se(par(( )) fmt(a))) ///
					noobs starlevels(* 0.10 ** 0.05 *** 0.01) collabels(none) label ///
					mlabels("PT,EPSI" "PT,HLT" "PT,EPI" "SO2,EPSI" "SO2,HLT" "SO2,EPI" "NO2,EPSI" "NO2,HLT" "NO2,EPI", lhs(Pollutant, ENVI:)) 	
	
