function chain=markov_gen(y0)
transition_probabilities = [0.8 0.2;0.2 0.8]; chain_length = 1000;
    chain = zeros(chain_length,1);
    chain(1)=y0;
    posval=[0.5,1.5];
    for i=2:chain_length
        this_step_distribution = transition_probabilities(find(posval==y0),:);
        cumulative_distribution = cumsum(this_step_distribution);
        r = rand();
        chain(i) = posval(find(cumulative_distribution>r,1));
    end
end