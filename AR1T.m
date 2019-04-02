%% (b) AR(1) generation input is y0, T, sigma, alpha, rho;
function Y=AR1T(y0,T,sigma,alpha,rho)
	% initialize Y
	Y=zeros(T,1);
	for i=1:T
		if i==1
			Y(i)=alpha+randn;
		else
			Y(i)=rho*Y(i-1)+alpha+randn;
		end
end