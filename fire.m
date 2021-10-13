function zomb_pos = fire(game_table,path,path_len)
    pos_x = 1;
    pos_y = 1;
    switch path
        case 1
            for i=1:path_len
               is_zmb = game_table(path_len+1-i,path_len+1-i);
               if is_zmb ~= 0
                   pos_x = path_len+1-i;
                   pos_y = path_len+1-i;
                   break
               end
            end
        case 2
           for i=1:path_len
               is_zmb = game_table(path_len+1-i,path_len+1); 
               if is_zmb ~= 0
                   pos_x = path_len+1-i;
                   pos_y = path_len+1;
                   break
               end
           end
        case 3
            for i=1:path_len
               is_zmb = game_table(path_len+1-i,path_len+1+i); 
               if is_zmb ~= 0
                   pos_x = path_len+1-i;
                   pos_y = path_len+1+i;
                   break
               end
            end
        case 4
            for i=1:path_len
               is_zmb = game_table(path_len+1,path_len+1-i); 
               if is_zmb ~= 0
                   pos_x = path_len+1;
                   pos_y = path_len+1-i;
                   break
               end
            end
        case 5
            for i=1:path_len
               is_zmb = game_table(path_len+1,path_len+1+i); 
               if is_zmb ~= 0
                   pos_x = path_len+1;
                   pos_y = path_len+1+i;
                   break
               end
            end
        case 6
            for i=1:path_len
               is_zmb = game_table(path_len+1+i,path_len+1-i); 
               if is_zmb ~= 0
                   pos_x = path_len+1+i;
                   pos_y = path_len+1-i;
                   break
               end
            end
        case 7
            for i=1:path_len
               is_zmb = game_table(path_len+1+i,path_len+1); 
               if is_zmb ~= 0
                   pos_x = path_len+1+i;
                   pos_y = path_len+1;
                   break
               end
            end
        case 8
            for i=1:path_len
               is_zmb = game_table(path_len+1+i,path_len+1+i); 
               if is_zmb ~= 0
                   pos_x = path_len+1+i;
                   pos_y = path_len+1+i;
                   break
               end
            end
    end
    zomb_pos = [pos_x pos_y];
end