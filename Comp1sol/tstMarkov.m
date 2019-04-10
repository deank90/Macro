transition_probabilities = [0.8 0.2;0.2 0.8]; starting_value = 0.5; chain_length = 1000;
    chain = zeros(1,chain_length);
    chain(1)=starting_value;
    posval=[0.5,1.5];
    for i=2:chain_length
        this_step_distribution = transition_probabilities(find(posval==starting_value),:);
        cumulative_distribution = cumsum(this_step_distribution);
        r = rand();
        chain(i) = posval(find(cumulative_distribution>r,1));
    end