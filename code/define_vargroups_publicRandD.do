global ECSP_TC "waste_int_ln_totalcost_2"
global ECSP_TS "waste_int_ln_ind_sales"
global ECSP_PR "waste_int_ln_payroll"	

global EPSI "EPSI"
global EPI "EPI"
global HLT "HLT"

global AYcontrols_TC "lus_randd_intensity_0005_AC2013 skill_int_ln_totalcost_2 othermach_int_ln_totalcost_2 building_int_ln_totalcost_2 auto_int_ln_totalcost_2 computer_int_ln_totalcost_2 contractibility"
global AYcontrols_TS "lus_randd_intensity_0005_AC2013 skill_int_ln_ind_sales othermach_int_ln_ind_sales building_int_ln_ind_sales auto_int_ln_ind_sales computer_int_ln_ind_sales contractibility"
global AYcontrols_PR "lus_randd_intensity_0005_AC2013 skill_int_ln_payroll othermach_int_ln_payroll building_int_ln_payroll auto_int_ln_payroll computer_int_ln_payroll contractibility"

global AYcontrols_agg_TC "lus_randd_intensity_0005_AC2013 skill_int_ln_totalcost_2 capital_int_ln_totalcost_2 contractibility"
global AYcontrols_agg_TS "lus_randd_intensity_0005_AC2013 skill_int_ln_ind_sales capital_int_ln_ind_sales contractibility"
global AYcontrols_agg_PR "lus_randd_intensity_0005_AC2013 skill_int_ln_payroll capital_int_ln_payroll contractibility"

global disp "disp1_2005"

global Antras_Chor "c.DUse_TUse#i.sigma_median_dummy i.sigma_median_dummy"
global sigma "sigma"
global BJRS "value_added_share input_importance BJRSinterm"

global HO_interact_TC "c.skill_int_ln_totalcost_2#c.skill_ab_ln skill_ab_ln c.capital_int_ln_totalcost_2#c.cap_ab_ln cap_ab_ln"
global HO_interact_TS "c.skill_int_ln_ind_sales#c.skill_ab_ln skill_ab_ln c.capital_int_ln_ind_sales#c.cap_ab_ln cap_ab_ln"
global HO_interact_PR "c.skill_int_ln_payroll#c.skill_ab_ln skill_ab_ln c.capital_int_ln_payroll#c.cap_ab_ln cap_ab_ln"

global HO_interact_nocou_TC "c.skill_int_ln_totalcost_2#c.skill_ab_ln c.capital_int_ln_totalcost_2#c.cap_ab_ln"
global HO_interact_nocou_TS "c.skill_int_ln_ind_sales#c.skill_ab_ln c.capital_int_ln_ind_sales#c.cap_ab_ln"
global HO_interact_nocou_PR "c.skill_int_ln_payroll#c.skill_ab_ln c.capital_int_ln_payroll#c.cap_ab_ln"

global HO_interact_all_TC "c.skill_int_ln_totalcost_2#c.skill_ab_ln skill_ab_ln c.othermach_int_ln_totalcost_2#c.cap_ab_ln c.building_int_ln_totalcost_2#c.cap_ab_ln c.auto_int_ln_totalcost_2#c.cap_ab_ln c.computer_int_ln_totalcost_2#c.cap_ab_ln cap_ab_ln"

global HO_interact_all_nocou_TC "c.skill_int_ln_totalcost_2#c.skill_ab_ln c.othermach_int_ln_totalcost_2#c.cap_ab_ln c.building_int_ln_totalcost_2#c.cap_ab_ln c.auto_int_ln_totalcost_2#c.cap_ab_ln c.computer_int_ln_totalcost_2#c.cap_ab_ln"
global HO_interact_all_nocou_TS "c.skill_int_ln_ind_sales#c.skill_ab_ln c.othermach_int_ln_ind_sales#c.cap_ab_ln c.building_int_ln_ind_sales#c.cap_ab_ln c.auto_int_ln_ind_sales#c.cap_ab_ln c.computer_int_ln_ind_sales#c.cap_ab_ln"
global HO_interact_all_nocou_PR "c.skill_int_ln_payroll#c.skill_ab_ln c.othermach_int_ln_payroll#c.cap_ab_ln c.building_int_ln_payroll#c.cap_ab_ln c.auto_int_ln_payroll#c.cap_ab_ln c.computer_int_ln_payroll#c.cap_ab_ln"


global credit_interact "ext_dep tang c.private_credit#c.ext_dep c.private_credit#c.tang private_credit"
global labormarket_interact "c.sales_vol#c.flex sales_vol flex"

global credit_interact_nocou "ext_dep tang c.ext_dep#c.private_credit c.tang#c.private_credit"
global labormarket_interact_nocou "sales_vol c.sales_vol#c.flex"

global credit_interact_noind "c.ext_dep#c.private_credit c.tang#c.private_credit private_credit"
global labormarket_interact_noind "c.sales_vol#c.flex flex"

global contract_interact "c.contractibility#c.ruleoflaw ruleoflaw"
global contract_interact_nocou "c.contractibility#c.ruleoflaw"

global interm_interact "BJRSinterm c.BJRSinterm#c.ruleoflaw"
global interm_interact_noind "c.BJRSinterm#c.ruleoflaw"

global pollution_pt "ln_kg_pt_t"
global pollution_so2 "ln_kg_so2_t"
global pollution_no2 "ln_kg_no2_t"




	
	