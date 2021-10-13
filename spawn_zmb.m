
function out = spawn_zmb(path_num,path_len)
    switch path_num
        case 1
            x_pos = 1;
            y_pos = 1;
        case 2
            x_pos = 1;
            y_pos = path_len+1;
        case 3
            x_pos = 1;
            y_pos = 2*path_len+1;
        case 4
            x_pos = path_len+1;
            y_pos = 1;
        case 5
            x_pos = path_len+1;
            y_pos = 2*path_len+1;
        case 6
            x_pos = 2*path_len+1;
            y_pos = 1;
        case 7
            x_pos = 2*path_len+1;
            y_pos = path_len+1;
        case 8
            x_pos = 2*path_len+1;
            y_pos = 2*path_len+1;
    end
    out = [x_pos,y_pos];
end

