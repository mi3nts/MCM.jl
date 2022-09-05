using Unitful

a = 9.81*u"m/s^2"
v0 = 5*u"m/s"
t0 = 5*u"s"

println(a)
println(v0)

x(t) = v0*t + 1/2*a*t^2
v(t) = v0 + a*t

println(x(t0))


# check unit math
println(x(t0) + v(t0))

# converting units
println(uconvert(u"yr", t0))


# check dimensions
hbar = 1*u"ħ"

println(typeof(hbar))

println(upreferred(hbar))


# checking units
1*u"kg" == 1000*u"g"

xs = collect(0.0:0.1:1.0) * u"m"
