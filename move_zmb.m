function pos_zombie = move_zmb(x_pos,y_pos,path)
    pos_x = 0;
    pos_y = 0;
    switch path
        case 1
            pos_x = x_pos+1;
            pos_y = y_pos+1;
        case 2
            pos_x = x_pos+1;
            pos_y = y_pos;
        case 3
            pos_x = x_pos+1;
            pos_y = y_pos-1;
        case 4
            pos_x = x_pos;
            pos_y = y_pos+1;
        case 5
            pos_x = x_pos;
            pos_y = y_pos-1;
        case 6
            pos_x = x_pos-1;
            pos_y = y_pos+1;
        case 7
            pos_x = x_pos-1;
            pos_y = y_pos;
        case 8
            pos_x = x_pos-1;
            pos_y = y_pos-1;
    end    
    pos_zombie = [pos_x pos_y];
end

