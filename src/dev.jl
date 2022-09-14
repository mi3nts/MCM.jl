using Dates
using Unitful
using Catalyst
using SolarGeometry

# load in relevant files
test_file = "../data/mcm_3-2_kpp_complete.kpp"
isfile(test_file)


# Constant.jl
Nₐ = Unitful.Na
R_gas = Unitful.R

# Configure.jl
file = "../data/mcm_3-2_fortran_complete.txt"
temp = 25*u"°C"
start_time  = DateTime(2022, 9, 13, 12, 0, 0)
start_time  = DateTime(2022, 9, 13, 23, 59, 59)
H2O = 10.0*u"1/cm^3"
latitude = 32.847445*u"°"
longitude = -97.108830*u"°"


# regular expressions demo
re = r"^\s*(?:#|$)"
typeof(re)

# check whether or not the regex matches
occursin(re, "not a comment")
occursin(re, "# a comment")

# return the actual match
match(re, "not a comment")
match(re, "# a comment")



pattern = r"[a-zA-Z0-9]+@+[a-zA-Z]+\.(com|edu|net)"
text="jwaczak@gmail.com"

m = match(pattern, text)
m.match

var = s"test"
typeof(var)
