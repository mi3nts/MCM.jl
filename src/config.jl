config = Dict()


# generate global constant default values
config["temp"] = 298.15  # Kelvin
config["M"] = 2.55E+19
config["N2"] = 0.79*config["M"]
config["O2"] = 0.2095*config["M"]
config["ttime"] = 5.0  # I think this is in seconds???

# NOTE: NOT SURE WHAT TOP PUT FOR THESE VALS
config["H2O"] = 1.0*config["M"]
config["NO"] = 1.0*config["M"]   # <--- Not sure about this one either
config["NO3"] = 1.0*config["M"]   # <--- Not sure about this one either
config["HO2"] = 1.0*config["M"]  # <-- this one's probably determined in our ReactionSystem
config["RO2"] = 1.0*config["M"] # <-- Not sure what to do with this



# generic rate coefficients
config["KRO2NO"] = 2.7E-12*exp(360/config["temp"])
config["KRO2HO2"] = 2.91E-13*exp(1300/config["temp"])
config["KAPHO2"] = 5.2E-13*exp(980/config["temp"])
config["KAPNO"] = 7.5E-12*exp(290/config["temp"])
config["KRO2NO3"] = 2.3E-12
config["KNO3AL"] = 1.44E-12*exp(-1862/config["temp"])
config["KDEC"] = 1.00E+06
config["KROPRIM"] = 2.50E-14*exp(-300/config["temp"])
config["KROSEC"] = 2.50E-14*exp(-300/config["temp"])
config["KCH3O2"] = 1.03E-13*exp(365/config["temp"])
config["K298CH3O2"] = 3.5E-13
config["K14ISOM1"] = 3.00E7*exp(-5300/config["temp"])

# complex reactions
config["KD0"] = 1.10E-05*config["M"]*exp(10100/config["temp"])
config["KDI"] = 1.90E17*exp(-14100/config["temp"])
config["KRD"] = config["KD0"]/config["KDI"]
config["FCD"] = 0.30
config["NCD"] = 0.75-1.27*(log10(config["FCD"]))
config["FD"] = 10^(log10(config["FCD"])/(1+(log10(config["KRD"])/config["NCD"])^2))
config["KBPAN"] = (config["KD0"]*config["KDI"])*config["FD"]/(config["KD0"]+config["KDI"])
config["KC0"] = 3.28E-28*config["M"]*(config["temp"]/300)^-6.87
config["KCI"] = 1.125E-11*(config["temp"]/300)^-1.105
config["KRC"] = config["KC0"]/config["KCI"]
config["FCC"] = 0.30
config["NC"] = 0.75-1.27*(log10(config["FCC"]))
config["FC"] = 10^(log10(config["FCC"])/(1+(log10(config["KRC"])/config["NC"])^2))
config["KFPAN"] = (config["KC0"]*config["KCI"])*config["FC"]/(config["KC0"]+config["KCI"])
config["K10"] = 1.0E-31*config["M"]*(config["temp"]/300)^-1.6
config["K1I"] = 5.0E-11*(config["temp"]/300)^-0.3
config["KR1"] = config["K10"]/config["K1I"]
config["FC1"] = 0.85
config["NC1"] = 0.75-1.27*(log10(config["FC1"]))
config["F1"] = 10^(log10(config["FC1"])/(1+(log10(config["KR1"])/config["NC1"])^2))
config["KMT01"] = (config["K10"]*config["K1I"])*config["F1"]/(config["K10"]+config["K1I"])
config["K20"] = 1.3E-31*config["M"]*(config["temp"]/300)^-1.5
config["K2I"] = 2.3E-11*(config["temp"]/300)^0.24
config["KR2"] = config["K20"]/config["K2I"]
config["FC2"] = 0.6
config["NC2"] = 0.75-1.27*(log10(config["FC2"]))
config["F2"] = 10^(log10(config["FC2"])/(1+(log10(config["KR2"])/config["NC2"])^2))
config["KMT02"] = (config["K20"]*config["K2I"])*config["F2"]/(config["K20"]+config["K2I"])
config["K30"] = 3.6E-30*config["M"]*(config["temp"]/300)^-4.1
config["K3I"] = 1.9E-12*(config["temp"]/300)^0.2
config["KR3"] = config["K30"]/config["K3I"]
config["FC3"] = 0.35
config["NC3"] = 0.75-1.27*(log10(config["FC3"]))
config["F3"] = 10^(log10(config["FC3"])/(1+(log10(config["KR3"])/config["NC3"])^2))
config["KMT03"] = (config["K30"]*config["K3I"])*config["F3"]/(config["K30"]+config["K3I"])
config["K40"] = 1.3E-3*config["M"]*(config["temp"]/300)^-3.5*exp(-11000/config["temp"])
config["K4I"] = 9.7E+14*(config["temp"]/300)^0.1*exp(-11080/config["temp"])
config["KR4"] = config["K40"]/config["K4I"]
config["FC4"] = 0.35
config["NC4"] = 0.75-1.27*(log10(config["FC4"]))
config["F4"] = 10^(log10(config["FC4"])/(1+(log10(config["KR4"])/config["NC4"])^2))
config["KMT04"] = (config["K40"]*config["K4I"])*config["F4"]/(config["K40"]+config["K4I"])
config["KMT05"] = 1.44E-13*(1+(config["M"]/4.2E+19))
config["KMT06"] = 1 + (1.40E-21*exp(2200/config["temp"])*config["H2O"])
config["K70"] = 7.4E-31*config["M"]*(config["temp"]/300)^-2.4
config["K7I"] = 3.3E-11*(config["temp"]/300)^-0.3
config["KR7"] = config["K70"]/config["K7I"]
config["FC7"] = 0.81
config["NC7"] = 0.75-1.27*(log10(config["FC7"]))
config["F7"] = 10^(log10(config["FC7"])/(1+(log10(config["KR7"])/config["NC7"])^2))
config["KMT07"] = (config["K70"]*config["K7I"])*config["F7"]/(config["K70"]+config["K7I"])
config["K80"] = 3.2E-30*config["M"]*(config["temp"]/300)^-4.5
config["K8I"] = 3.0E-11
config["KR8"] = config["K80"]/config["K8I"]
config["FC8"] = 0.41
config["NC8"] = 0.75-1.27*(log10(config["FC8"]))
config["F8"] = 10^(log10(config["FC8"])/(1+(log10(config["KR8"])/config["NC8"])^2))
config["KMT08"] = (config["K80"]*config["K8I"])*config["F8"]/(config["K80"]+config["K8I"])
config["K90"] = 1.4E-31*config["M"]*(config["temp"]/300)^-3.1
config["K9I"] = 4.0E-12
config["KR9"] = config["K90"]/config["K9I"]
config["FC9"] = 0.4
config["NC9"] = 0.75-1.27*(log10(config["FC9"]))
config["F9"] = 10^(log10(config["FC9"])/(1+(log10(config["KR9"])/config["NC9"])^2))
config["KMT09"] = (config["K90"]*config["K9I"])*config["F9"]/(config["K90"]+config["K9I"])
config["K100"] = 4.10E-05*config["M"]*exp(-10650/config["temp"])
config["K10I"] = 6.0E+15*exp(-11170/config["temp"])
config["KR10"] = config["K100"]/config["K10I"]
config["FC10"] = 0.4
config["NC10"] = 0.75-1.27*(log10(config["FC10"]))
config["F10"] = 10^(log10(config["FC10"])/(1+(log10(config["KR10"])/config["NC10"])^2))
config["KMT10"] = (config["K100"]*config["K10I"])*config["F10"]/(config["K100"]+config["K10I"])
config["K1"] = 2.40E-14*exp(460/config["temp"])
config["K3"] = 6.50E-34*exp(1335/config["temp"])
config["K4"] = 2.70E-17*exp(2199/config["temp"])
config["K2"] = (config["K3"]*config["M"])/(1+(config["K3"]*config["M"]/config["K4"]))
config["KMT11"] = config["K1"] + config["K2"]
config["K120"] = 2.5E-31*config["M"]*(config["temp"]/300)^-2.6
config["K12I"] = 2.0E-12
config["KR12"] = config["K120"]/config["K12I"]
config["FC12"] = 0.53
config["NC12"] = 0.75-1.27*(log10(config["FC12"]))
config["F12"] = 10^(log10(config["FC12"])/(1.0+(log10(config["KR12"])/config["NC12"])^2))
config["KMT12"] = (config["K120"]*config["K12I"]*config["F12"])/(config["K120"]+config["K12I"])
config["K130"] = 2.5E-30*config["M"]*(config["temp"]/300)^-5.5
config["K13I"] = 1.8E-11
config["KR13"] = config["K130"]/config["K13I"]
config["FC13"] = 0.36
config["NC13"] = 0.75-1.27*(log10(config["FC13"]))
config["F13"] = 10^(log10(config["FC13"])/(1+(log10(config["KR13"])/config["NC13"])^2))
config["KMT13"] = (config["K130"]*config["K13I"])*config["F13"]/(config["K130"]+config["K13I"])
config["K140"] = 9.0E-5*exp(-9690/config["temp"])*config["M"]
config["K14I"] = 1.1E+16*exp(-10560/config["temp"])
config["KR14"] = config["K140"]/config["K14I"]
config["FC14"] = 0.36
config["NC14"] = 0.75-1.27*(log10(config["FC14"]))
config["F14"] = 10^(log10(config["FC14"])/(1+(log10(config["KR14"])/config["NC14"])^2))
config["KMT14"] = (config["K140"]*config["K14I"])*config["F14"]/(config["K140"]+config["K14I"])
config["K150"] = 8.6E-29*config["M"]*(config["temp"]/300)^-3.1
config["K15I"] = 9.0E-12*(config["temp"]/300)^-0.85
config["KR15"] = config["K150"]/config["K15I"]
config["FC15"] = 0.48
config["NC15"] = 0.75-1.27*(log10(config["FC15"]))
config["F15"] = 10^(log10(config["FC15"])/(1+(log10(config["KR15"])/config["NC15"])^2))
config["KMT15"] = (config["K150"]*config["K15I"])*config["F15"]/(config["K150"] + config["K15I"])
config["K160"] = 8E-27*config["M"]*(config["temp"]/300)^-3.5
config["K16I"] = 3.0E-11*(config["temp"]/300)^-1
config["KR16"] = config["K160"]/config["K16I"]
config["FC16"] = 0.5
config["NC16"] = 0.75-1.27*(log10(config["FC16"]))
config["F16"] = 10^(log10(config["FC16"])/(1+(log10(config["KR16"])/config["NC16"])^2))
config["KMT16"] = (config["K160"]*config["K16I"])*config["F16"]/(config["K160"]+config["K16I"])
config["K170"] = 5.0E-30*config["M"]*(config["temp"]/300)^-1.5
config["K17I"] = 1.0E-12
config["KR17"] = config["K170"]/config["K17I"]
config["FC17"] = 0.17*exp(-51/config["temp"])+exp(-config["temp"]/204)
config["NC17"] = 0.75-1.27*(log10(config["FC17"]))
config["F17"] = 10^(log10(config["FC17"])/(1.0+(log10(config["KR17"])/config["NC17"])^2))
config["KMT17"] = (config["K170"]*config["K17I"]*config["F17"])/(config["K170"]+config["K17I"])
config["KMT18"] = 9.5E-39*config["O2"]*exp(5270/config["temp"])/(1+7.5E-29*config["O2"]*exp(5610/config["temp"]))
config["KPPN0"] = 1.7E-03*exp(-11280/config["temp"])*config["M"]
config["KPPNI"] = 8.3E+16*exp(-13940/config["temp"])
config["KRPPN"] = config["KPPN0"]/config["KPPNI"]
config["FCPPN"] = 0.36
config["NCPPN"] = 0.75-1.27*(log10(config["FCPPN"]))
config["FPPN"] = 10^(log10(config["FCPPN"])/(1+(log10(config["KRPPN"])/config["NCPPN"])^2))
config["KBPPN"] = (config["KPPN0"]*config["KPPNI"])*config["FCPPN"]/(config["KPPN0"]+config["KPPNI"])
config["KNO"] = config["KRO2NO"]*config["NO"]
config["KHO2"] = config["KRO2HO2"]*config["HO2"]*0.706
config["KRO2"] = 1.26E-12*config["RO2"]
config["KNO3"] = config["KRO2NO3"]*config["NO3"]
config["KTR"] = config["KNO"]+ config["KHO2"] + config["KRO2"] + config["KNO3"]
config["K16ISOM"] = (config["KTR"]*5.18E-04*exp(1308/config["temp"])) +(2.76E07*exp(-6759/config["temp"]))


# Photolysis Rates
config["dec"] = 23.79 # solar declination angle
config["lat"] = 50.0  # latitude
config["lha"] = (1.0+config["ttime"]/4.32E+4)*π  # local hour angle - representing time of day
config["radian"] = 180.0/π
config["lat"] = config["lat"]/config["radian"]
config["dec"] = config["dec"]/config["radian"]
config["θ"] = acos( (cos(config["lha"])*cos(config["dec"])*cos(config["lat"])) + (sin(config["dec"])*sin(config["lat"])) )
config["sinld"] = sin(config["lat"])*sin(config["dec"])
config["cosld"] = cos(config["lat"])*cos(config["dec"])

config["cosx"] = cos(config["lha"])*config["cosld"] + config["sinld"]  # these should be identical
config["cosx"] = cos(config["θ"])
if config["cosx"] < 0
    config["cosx"] = 0  # for night time? Otherwise we get that J is complex
end



config["secx"] = 1.0E+0/(config["cosx"]+1.0E-30)

# set up our J array
# data from photolysis.txt
# j(k) = 1(k)*cosx^(mm(k))*exp(-nn(k) * secx)
config["J[1]"] =6.073E-05*config["cosx"]^(1.743)*exp(-1.0*0.474*config["secx"])
config["J[2]"] =4.775E-04*config["cosx"]^(0.298)*exp(-1.0*0.080*config["secx"])
config["J[3]"] =1.041E-05*config["cosx"]^(0.723)*exp(-1.0*0.279*config["secx"])
config["J[4]"] =1.165E-02*config["cosx"]^(0.244)*exp(-1.0*0.267*config["secx"])
config["J[5]"] =2.485E-02*config["cosx"]^(0.168)*exp(-1.0*0.108*config["secx"])
config["J[6]"] =1.747E-01*config["cosx"]^(0.155)*exp(-1.0*0.125*config["secx"])
config["J[7]"] =2.644E-03*config["cosx"]^(0.261)*exp(-1.0*0.288*config["secx"])
config["J[8]"] =9.312E-07*config["cosx"]^(1.230)*exp(-1.0*0.307*config["secx"])
config["J[11]"] =4.642E-05*config["cosx"]^(0.762)*exp(-1.0*0.353*config["secx"])
config["J[12]"]=6.853E-05*config["cosx"]^(0.477)*exp(-1.0*0.323*config["secx"])
config["J[13]"]=7.344E-06*config["cosx"]^(1.202)*exp(-1.0*0.417*config["secx"])
config["J[14]"]=2.879E-05*config["cosx"]^(1.067)*exp(-1.0*0.358*config["secx"])
config["J[15]"]=2.792E-05*config["cosx"]^(0.805)*exp(-1.0*0.338*config["secx"])
config["J[16]"]=1.675E-05*config["cosx"]^(0.805)*exp(-1.0*0.338*config["secx"])
config["J[17]"]=7.914E-05*config["cosx"]^(0.764)*exp(-1.0*0.364*config["secx"])
config["J[18]"]=1.482E-06*config["cosx"]^(0.396)*exp(-1.0*0.298*config["secx"])
config["J[19]"]=1.482E-05*config["cosx"]^(0.396)*exp(-1.0*0.298*config["secx"])
config["J[20]"]=7.600E-04*config["cosx"]^(0.396)*exp(-1.0*0.298*config["secx"])
config["J[21]"]=7.992E-07*config["cosx"]^(1.578)*exp(-1.0*0.271*config["secx"])
config["J[22]"]=5.804E-06*config["cosx"]^(1.092)*exp(-1.0*0.377*config["secx"])
config["J[23]"]=2.4246E-06*config["cosx"]^(0.395)*exp(-1.0*0.296*config["secx"])
config["J[24]"]=2.424E-06*config["cosx"]^(0.395)*exp(-1.0*0.296*config["secx"])
config["J[31]"]=6.845E-05*config["cosx"]^(0.130)*exp(-1.0*0.201*config["secx"])
config["J[32]"]=1.032E-05*config["cosx"]^(0.130)*exp(-1.0*0.201*config["secx"])
config["J[33]"]=3.802E-05*config["cosx"]^(0.644)*exp(-1.0*0.312*config["secx"])
config["J[34]"]=1.537E-04*config["cosx"]^(0.170)*exp(-1.0*0.208*config["secx"])
config["J[35]"]=3.326E-04*config["cosx"]^(0.148)*exp(-1.0*0.215*config["secx"])
config["J[41]"]=7.649E-06*config["cosx"]^(0.682)*exp(-1.0*0.279*config["secx"])
config["J[51]"]=1.588E-06*config["cosx"]^(1.154)*exp(-1.0*0.318*config["secx"])
config["J[52]"]=1.907E-06*config["cosx"]^(1.244)*exp(-1.0*0.335*config["secx"])
config["J[53]"]=2.485E-06*config["cosx"]^(1.196)*exp(-1.0*0.328*config["secx"])
config["J[54]"]=4.095E-06*config["cosx"]^(1.111)*exp(-1.0*0.316*config["secx"])
config["J[55]"]=1.135E-05*config["cosx"]^(0.974)*exp(-1.0*0.309*config["secx"])
config["J[56]"]=4.365E-05*config["cosx"]^(1.089)*exp(-1.0*0.323*config["secx"])
config["J[57]"]=3.363E-06*config["cosx"]^(1.296)*exp(-1.0*0.322*config["secx"])
config["J[61]"]=7.537E-04*config["cosx"]^(0.499)*exp(-1.0*0.266*config["secx"])
