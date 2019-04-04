%% Infinite-horizon consumption and saving with uncertainty

% Initialization of params in the model
r=.05; % return of saving
beta=.95; % discount rate

% Approximation of y by a Markov process given in the helpful note
PI=[.8, .2;.8, .2]; % transition matrix
y=[.5 1.5]; % two suggested states

% Construction of the a's grid
nbg=1000;% # of a's points in the grid
nbs=length(y); % # of y's states
crit=1; % Initialization of the convergence criterion
epsi=1e-6; % Precision of convergence
amin=-.5; % Lower bound for gross saving returns
amax=3; % Upper bound for gross saving returns
agrid=linspace(amin,amax,nbg)'; % The a's grid

% Initialization of variables in the iteration
c=zeros(nbg,nbs);
util=zeros(nbg,nbs);
v=zeros(nbg,nbs);
Tv=zeros(nbg,nbs);
dr=zeros(nbg,nbs);
iter=0;
Maxiter=500;

while and(crit>epsi,iter<Maxiter)
	for i=1:nbg
		for j=1:nbs
			tempc=agrid(i)+y(j)-agrid./(1+r);
			neg=find(tempc<=0);
			tempc(neg)=NaN;
			util(:,j)=log(tempc);
			util(neg,j)=-1e12;
		end
		[Tv(i,:),dr(i,:)]=max(util+beta*(v*PI));
	end
	crit=max(max(abs(Tv-v)));
	v=Tv;
	iter=iter+1;
end
apolicy=agrid(dr);
for j=1:nbs
	c(:,j)=agrid+y(j)*ones(size(agrid))-agrid./(1+r);
end