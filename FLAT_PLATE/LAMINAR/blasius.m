%% BLASIUS
solver = 'bvp4c';
bvpsolver = fcnchk(solver);

infinity = 3;
maxinfinity = 10;

% This constant guess satisfying the boundary conditions
% is good enough to get convergence when 'infinity' = 3.
solinit = bvpinit(linspace(0,infinity,5),[0 0 1]);
sol = bvpsolver(@blasius,@resBlasius,solinit);
eta = sol.x;
f = sol.y;

% Reference solution from T. Cebeci and H.B. Keller, Shooting and parallel
% shooting methods for solving the Falkner-Skan boundary-layer equation, J.
% Comp. Phy., 7 (1971) p. 289-300.

for Bnew = infinity+1:maxinfinity
   
   solinit = bvpxtend(sol,Bnew);   % Extend the solution to Bnew.
   sol = bvpsolver(@blasius,@resBlasius,solinit);
   eta = sol.x;
   f = sol.y;
   
   fprintf('Value computed using infinity = %g is %7.5f.\n',Bnew,f(3,1))
end

figure;
plot(f(2,:),eta);
title("Blasius profile")
xlabel('\eta')
ylabel("u/U")

%% FUNCTIONS

function yp = blasius(t,y)
% BLASIUS

yp = y;

yp(1) = y(2);
yp(2) = y(3);
yp(3) = -0.5*y(1).*y(3);

end

function res = resBlasius(f0,finf)
res = [f0(1)
    f0(2)
    finf(2) - 1];
end