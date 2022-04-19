using Catalyst

@variables t A(t) B(t) C(t)

test_rn = @reaction_network begin
	1.0, 1.0*A+1.0*B ⟶ 1.0*C
end
