function [Ray_fin] = P2_lens( Ray_ini,flength)
%ray propagation encountering lens

%test 
% Ray_ini = [ray_rh(idxa,2),ray_th(idxa,2)];
% flength = ds_02_te;
    TRANS_MATRIX  = [ 1         , 0  ;...
                     -1/flength , 1 ];
    Ray_fin = TRANS_MATRIX * Ray_ini;
end