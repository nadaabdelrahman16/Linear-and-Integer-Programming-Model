
import Pkg
Pkg.add("JuMP")
Pkg.add("Clp")
using JuMP, Clp
"""
   example linear programming optimization
   Decision variables :
     x1->45 inch tv , x2->60 inch tv
   objective function :
     max 50x1+75x2
   constraints :
     2x1+2x2<=300  "man-hours in its production area"
     1x1+3x2<=240  "man-hours in its assembly area"
      x1,x2>=0
"""
M = Model(Clp.Optimizer)
@variable(M , 0<= x1 )
@variable(M , 0 <=x2)
@objective(M , Max, 50x1 + 75x2 )
@constraint(M , const1, 2x1 +  2x2  <= 300)
@constraint(M , const2,  x1 + 3x2  <= 240)
optimize!(M)
obj_value = JuMP.objective_value(M)
x1_value = JuMP.value(x1)
x2_value = JuMP.value(x2)
println("profit per shift: ", obj_value)
println("production levels of GE45 = ", x1_value)
println("production levels of GE60= ", x2_value)
