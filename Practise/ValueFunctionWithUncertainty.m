%% Value Function with Uncertainty
sigma=1.5;
delta=.1;
beta=.95;
alpha=.3;
rho=.8;

nbk=1000;
nba=2;
crit=1;
epsi=1e-6;

p=(1+rho)/2;
PI=[p 1-p; 1-p p];
se=.12;
ab=0;
a1=exp(-se*se/(1-rho*rho));
a2=exp(se*se/(1-rho*rho));
A=[a1 a2];

kmin=.2;
kmax=6;
kgrid=linspace(kmin,kmax,nbk)';
c=zeros(nbk,nba);
util=zeros(nbk,nba);
v=zeros(nbk,nba);
Tv=zeros(nbk,nba);
dr=Tv;
iter=0;

while crit>epsi
	for i=1:nbk
		for j=1:nba
			c=A(j)*kgrid(i)^alpha+(1-delta)*kgrid(i)-kgrid;
			neg=find(c<=0);
			c(neg)=NaN;
			util(:,j)=(c.^(1-sigma)-1)/(1-sigma);
			util(neg,j)=-1e12;
		end
		[Tv(i,:),dr(i,:)]=max(util+beta*(v*PI));
	end
	crit=max(max(abs(Tv-v)));
	v=Tv;
	iter=iter+1;
end

kp=kgrid(dr);
for j=1:nba
	c(:,j)=A(j)*kgrid.^alpha+(1-delta)*kgrid-kp(:,j);
end