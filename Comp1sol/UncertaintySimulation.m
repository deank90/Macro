%% 2Q in 2P simulation
% Initialization of a0, c0 and total time;
a0=0;
n=1000;
Sapolicy=zeros(n,2);
Sc=zeros(n,2);
% Generation of the optimal solution
cnsUncertaintyValueFunctionIteration;
% Simulation of the y's process:
posval=[0.5 1.5];
y=[markov_gen(0.5), markov_gen(1.5)];
idx_track=zeros(n,2);
for i=1:n
    if i==1
        [~,idx]=min(abs(agrid));
        idx_track(i,:)=[idx,idx];
        Sapolicy(i,:)=[apolicy(idx,find(posval==y(i,1))),apolicy(idx,find(posval==y(i,2)))];
        Sc(i,:)=[c(idx,find(posval==y(i,1))),c(idx,find(posval==y(i,2)))];
    else
        [~,idx1]=min(abs(Sapolicy(i-1,1)-agrid));
        [~,idx2]=min(abs(Sapolicy(i-1,2)-agrid));
        idx_track(i,:)=[idx1,idx2];
        Sapolicy(i,:)=[apolicy(idx1,find(posval==y(i,1))),apolicy(idx2,find(posval==y(i,2)))];
        Sc(i,:)=[c(idx1,find(posval==y(i,1))),c(idx2,find(posval==y(i,2)))];
    end
end