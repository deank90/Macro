%% Problem C
rhohat=zeros(100,3);
T=1100;
rho=[.95,.5,.999];
alpha=0;
for j=1:3
    for i=1:100
        Y0=AR1T(T,alpha,rho(j));
        Y0Last=Y0(1001:1100);
        X0Last=Y0(1000:1099);
        [rhohat(i,j),tmp1,tmp2]=olsl(Y0Last,X0Last);
    end
end