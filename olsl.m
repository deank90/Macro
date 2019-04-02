%% (a) OLS Function Practise
function [betahat, cvar, se] = olsl(Y, X)
% 1. data credibility check
	[ys1,ys2]=size(Y);
	[xs1,xs2]=size(X);
	if ys1~=xs1
		error('Y and X observations" # not equal!' );
	elseif ys2>1
		error('Y is not a column vector');
	elseif xs1<xs2
		error('# of observations is less than # of variables');
	end

% 2. estimation of betahat, cvar and standard error of estimate
	betahat=(X'*X)^(-1)*X'*Y;
	Px=X*(X'*X)^(-1)*X';
	Mx=eye(xs1)-Px;
	e=Mx*Y;
	deltahat=e'*e/(xs1-xs2);
	cvar=deltahat*(X'*X)^(-1);
	se=diag(cvar);
end
