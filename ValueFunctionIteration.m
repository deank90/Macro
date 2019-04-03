%% Test Value Function Iteration
sigma=1.5;
delta=.1;
beta=.95;
alpha=.3;

nbk=1000;
crit=1;
epsi=1e-6;

ks=((1-beta*(1-delta))/(alpha*beta))^(1/(alpha-1));

dev=.9;
kmin=(1-dev)*ks;
kmax=(1+dev)*ks;
dk=(kmax-kmin)/(nbk-1);
kgrid=linspace(kmin,kmax,nbk)';
v=zeros(nbk,1);
tv=zeros(nbk,1);
dr=zeros(nbk,1);

while crit>epsi
	for i=1:nbk
		tmp=kgrid(i)^alpha+(1-delta)*kgrid(i)-kmin;
		imax=min(floor(tmp/dk)+1,nbk);
		c=kgrid(i)^alpha+(1-delta)*kgrid(i)-kgrid(1:imax);
		util=(c.^(1-sigma)-1)/(1-sigma);
		[tv(i),dr(i)]=max(util+beta*v(1:imax));
    end
	crit=max(abs(tv-v));
	v=tv;
end

kp=kgrid(dr);
c=kgrid.^alpha+(1-delta)*kgrid-kp;
util=(c.^(1-sigma)-1)/(1-sigma);