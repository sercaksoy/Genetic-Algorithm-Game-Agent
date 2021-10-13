function num_zmb = find_zmb(game_table,sizex,sizey)
    num = 0;
    path_l = floor(sizex/2);
    for i=1:sizex
        for j=1:sizey
            is_zmb = game_table(i,j);
            if is_zmb ~= 0
                if is_zmb == 1
                    num = num + i;
                elseif is_zmb == 2
                    num = num + i;
                elseif is_zmb == 3
                    num = num + i;
                elseif is_zmb == 4
                    num = num + j;
                elseif is_zmb == 5
                    num = num + sizex - j + 1;
                elseif is_zmb == 6
                    num = num + j;
                elseif is_zmb == 7
                    num = num + sizex - i + 1;
                else
                    num = num + sizex - i + 1;
                end
            end
        end
    end
    
    num_zmb = round(num);
end