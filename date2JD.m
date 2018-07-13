function [jd0, jd] = date2JD(data)
    % retorna a data juliana com fracao horaria jd e sem fracao horaria jd0
    dia = data.dia;
    mes = data.mes;
    ano = data.ano;
    jd0 = 367*ano - fix(7*(ano + fix((mes +9)/12))/4) + ...
        fix(275*mes/9) + dia + 1721014;%3.5;
    
    UT = (data.h-12) + data.m/60 + data.s/3600;
    jd = jd0 + UT/24;
end