% Author: Sercan Aksoy
% Last Motified Date: 21.06.2021
% Subject: Yapay Zeka Donem Projesi
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;
close all;

% Enemies:
% There are 10 zombies to kill
% 8 ways they may occur
% 7 steps to reach hero

% Hero:
% Area centered location
% 40 bullets
% 8 ways to shot, hero does not has to shot
% For accuracy hero should not do large angle movements

% General:
% It is possible to spawn new zombie in the path which has already a zombie
% If any of the zombies reach to the hero game over
% Every movement time zombies get closer to hero one more step
% Every movement time hero does a movement shot 8 way or wait


% Zombie spawn pattern:
% Map:
% 1 2 3
% 4   5
% 6 7 8
% Pattern:
how_many_zombies = 10;
enemy_pattern = round(7*rand(1,how_many_zombies));
enemy_pattern = enemy_pattern + 1;
% Zombies spawn randomly for the each run
movement = [0:8]; % 0 represents to wait
angular_cost_ar = [0:7];
angular_cost = angular_cost_ar * 45;
angular_cost = [0 angular_cost];
% Creating table 15x15
path_length = 7;
Mx = path_length*2 +1;
My = Mx;
% Hero
hero_pos = [path_length+1 path_length+1];
hero_bullet = 40;
hero_seq_len = how_many_zombies + 2*path_length;
% Padding zeros to enemy pattern to reach
% heros sequence lenght, from that
% zombies don't spawn every movement time
en_padding = zeros(1,path_length);
enemy_pattern = [enemy_pattern en_padding];
enemy_pattern = enemy_pattern(randperm(length(enemy_pattern)));
enemy_pattern = [enemy_pattern en_padding];
% Enviroment
population_size = 2000; %5000
mutation_rate = 0.02;
generation_number = 200; %200
NG_individual_num = population_size - population_size/2;
% Fitness values
% f1 : Fired bullets     Wanted to be MINIMIZED
% f2 : Zombies closeness Wanted to be MINIMIZED 
% f3 : Angular cost      Wanted to be MINIMIZED
max_f1 = hero_seq_len;
% To calculate max f2 we need to picture something like
% hero kills every zombie in the last movement time
max_f2 = how_many_zombies * (path_length + path_length+1)/2;
max_f3 = 180 * (hero_seq_len-1);

lose_game = 0;
move_to = [1 1];

greatest_among_generation = zeros(1,generation_number);
mean_of_generation = greatest_among_generation;
fired_bullets_among_generation = greatest_among_generation;
best_paths = zeros(generation_number,hero_seq_len);

% First generation
hero_seq_total = round(8*rand(population_size,hero_seq_len));

for i=1:generation_number
    f1 = zeros(1,population_size);
    f2 = f1;
    f3 = f1;
    for j=1:population_size
        hero_seq = hero_seq_total(j,:);
        fired_bullet = 0;
        total_angular_cost = 0;
        zmb_closeness = 0;
        lose_game = 0;
        game_table = zeros(Mx,My);
        for m=1:hero_seq_len
            % Find all existing zombies and move them   
            for k=1:path_length
                is_zmb = game_table(path_length+1-k,path_length+1-k); %1
                if is_zmb ~= 0
                    move_to = move_zmb(path_length+1-k,path_length+1-k,is_zmb);
                    if move_to(1) == path_length+1 && move_to(2) == path_length+1
                        lose_game = 1;
                        break
                    end
                    game_table(move_to(1),move_to(2)) = is_zmb;
                    game_table(path_length+1-k,path_length+1-k) = 0;
                end
                %------------------------------------------------------------
                is_zmb = game_table(path_length+1-k,path_length+1); %2
                if is_zmb ~= 0
                    move_to = move_zmb(path_length+1-k,path_length+1,is_zmb);
                    if move_to(1) == path_length+1 && move_to(2) == path_length+1
                        lose_game = 1;
                        break
                    end
                    game_table(move_to(1),move_to(2)) = is_zmb;
                    game_table(path_length+1-k,path_length+1) = 0;
                end
                %------------------------------------------------------------
                is_zmb = game_table(path_length+1-k,path_length+1+k); %3
                if is_zmb ~= 0
                    move_to = move_zmb(path_length+1-k,path_length+1+k,is_zmb);
                    if move_to(1) == path_length+1 && move_to(2) == path_length+1
                        lose_game = 1;
                        break
                    end
                    game_table(move_to(1),move_to(2)) = is_zmb;
                    game_table(path_length+1-k,path_length+1+k) = 0;
                end
                %------------------------------------------------------------
                is_zmb = game_table(path_length+1,path_length+1-k); %4
                if is_zmb ~= 0
                    move_to = move_zmb(path_length+1,path_length+1-k,is_zmb);
                    if move_to(1) == path_length+1 && move_to(2) == path_length+1
                        lose_game = 1;
                        break
                    end
                    game_table(move_to(1),move_to(2)) = is_zmb;
                    game_table(path_length+1,path_length+1-k) = 0;
                end
                %------------------------------------------------------------
                is_zmb = game_table(path_length+1,path_length+1+k); %5
                if is_zmb ~= 0
                    move_to = move_zmb(path_length+1,path_length+1+k,is_zmb);
                    if move_to(1) == path_length+1 && move_to(2) == path_length+1
                        lose_game = 1;
                        break
                    end
                    game_table(move_to(1),move_to(2)) = is_zmb;
                    game_table(path_length+1,path_length+1+k) = 0;
                end
                %------------------------------------------------------------
                is_zmb = game_table(path_length+1+k,path_length+1-k); %6
                if is_zmb ~= 0
                    move_to = move_zmb(path_length+1+k,path_length+1-k,is_zmb);
                    if move_to(1) == path_length+1 && move_to(2) == path_length+1
                        lose_game = 1;
                        break
                    end
                    game_table(move_to(1),move_to(2)) = is_zmb;
                    game_table(path_length+1+k,path_length+1-k) = 0;
                end
                %------------------------------------------------------------
                is_zmb = game_table(path_length+1+k,path_length+1); %7
                if is_zmb ~= 0
                    move_to = move_zmb(path_length+1+k,path_length+1,is_zmb);
                    if move_to(1) == path_length+1 && move_to(2) == path_length+1
                        lose_game = 1;
                        break
                    end
                    game_table(move_to(1),move_to(2)) = is_zmb;
                    game_table(path_length+1+k,path_length+1) = 0;
                end
                %------------------------------------------------------------
                is_zmb = game_table(path_length+1+k,path_length+1+k); %8
                if is_zmb ~= 0
                    move_to = move_zmb(path_length+1+k,path_length+1+k,is_zmb);
                    if move_to(1) == path_length+1 && move_to(2) == path_length+1
                        lose_game = 1;
                        break
                    end
                    game_table(move_to(1),move_to(2)) = is_zmb;
                    game_table(path_length+1+k,path_length+1+k) = 0;
                end
                %------------------------------------------------------------
            end
            if lose_game == 1
                break
            end   
            % Find where to spawn new zombie
            if enemy_pattern(m) ~= 0
                pos = spawn_zmb(enemy_pattern(m),path_length);
                % Sign the cell with the spawned zombie
                game_table(pos(1),pos(2)) = enemy_pattern(m);
            end
            % Time to shoot some zombies
            fired_path = hero_seq(m);

            if fired_path ~= 0
                zomb_pos = fire(game_table,fired_path,path_length);
                fired_bullet = fired_bullet + 1;
                game_table(zomb_pos(1),zomb_pos(2)) = 0;
            end
            
            % Fitnesses
            f2(j) = f2(j) + find_zmb(game_table,Mx,My);
            %disp(game_table)
        end
        inv_fr=hero_seq+1;
        hero_seq_2=inv_fr(2:end);
        hero_seq_1=inv_fr(1:end-1);
        a1=angular_cost(hero_seq_1); a2=angular_cost(hero_seq_2);
        difference_vec=abs(a1-a2);
        difference_vec(difference_vec>180)=360-difference_vec(difference_vec>180);
        
        f3(j)=sum(difference_vec);
        f1(j)=fired_bullet;
        if lose_game == 1
            f1(j) = max_f1;
            f2(j) = max_f2;
            f3(j) = max_f3;
        end
    end
    n_f1 = f1 / max_f1;
    n_f2 = f2 / max_f2;
    n_f3 = f3 / max_f3;
    
    %n_f2 = n_f2 / sum(n_f2);
    
    weight = n_f1 + n_f2 + n_f3;
    n_weight = weight/sum(weight);
    n_weight = 1 - n_weight; %to make small weight values pick rate bigger 
    
    n_weight = n_weight/sum(n_weight);
    
    [sorted,inds]=sort(n_weight);
    sorted_indices(inds)=1:population_size;
    [val best_ind]=max(sorted_indices);
    
    best_paths(i,:) = hero_seq_total(best_ind,:);
    fired_bullets_among_generation(i) = nnz(hero_seq_total(best_ind,:));
    greatest_among_generation(i) = weight(best_ind);
    mean_of_generation(i) = mean(weight);
    
    choosen_samples = randsample(population_size,population_size,true,sorted_indices);
    NEW_hero_seq_total = zeros(population_size,hero_seq_len);
    
    % Cross-over
    for j=1:population_size/2
        chsn_1 = hero_seq_total(choosen_samples(j),:);
        chsn_2 = hero_seq_total(choosen_samples(j+population_size/2),:);
        
        slice_from = round((hero_seq_len-3)*rand(1,1))+2; %2 <= slice_from <= hero_seq_len -1
        
        NEW_hero_seq_total(j,:) = [chsn_1(1:slice_from) chsn_2(slice_from+1:end)];
        NEW_hero_seq_total(j+(population_size/2),:) = [chsn_1(1:slice_from) chsn_2(slice_from+1:end)];
        
    end
    if NG_individual_num > 0
        NEW_hero_seq_total(inds(NG_individual_num+1:end),:) = hero_seq_total(inds(NG_individual_num+1:end),:);
    end
    % Mutation
    rand_mat = rand(population_size,hero_seq_len)<mutation_rate;
    mutant_mat = round(8*rand(population_size,hero_seq_len));
    NEW_hero_seq_total(rand_mat) = mutant_mat(rand_mat);
    if NG_individual_num > 0
        NEW_hero_seq_total(inds(NG_individual_num+1:end),:) = hero_seq_total(inds(NG_individual_num+1:end),:);
    end
    hero_seq_total = NEW_hero_seq_total;
end
plot(greatest_among_generation,'r');
hold on;
plot(mean_of_generation,'b');

figure;
plot(fired_bullets_among_generation);
