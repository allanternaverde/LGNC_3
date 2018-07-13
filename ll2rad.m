function [lat,lon] = ll2rad(lat,str1, lon, str2)
    % conversao para radianos
    lat = deg2rad(dms2degrees(lat));
    lon = deg2rad(dms2degrees(lon));
    
    if strcmp(str1,'S')
        lat = -lat;
    end
    if strcmp(str2,'W')
        lon = -lon;
    end
end