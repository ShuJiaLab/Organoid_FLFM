function [Ray_fin] = P1_freespace(Ray_ini,distance)
%ray propagation encountering lens

%test 
% Ray_ini = [ray_rh(idxa,2),ray_th(idxa,2)];
% flength = ds_02_te;
    TRANS_MATRIX  = [ 1, distance ;...
                      0, 1       ];
    Ray_fin = TRANS_MATRIX * Ray_ini;
end
