function [Object_31_FOVZm,Object_33_NumZu,Object_33_NumZl,...
          Object_33_NumZd,Object_34_Ind_Z,Object_35_CoorZ] = S01_Coord_create_ud(Object_31_FOVZu,Object_31_FOVZl,Object_32_STP_Z)
% Object_31_FOVZu = +120.000*10^-6
% Object_31_FOVZl = -120.000*10^-6
% Object_32_STP_Z = Object_32_Z_stp
        
        Object_35_CoorZ = Object_31_FOVZl:Object_32_STP_Z:Object_31_FOVZu ; 
        Object_34_Ind_Z =          int32( Object_35_CoorZ/Object_32_STP_Z);  
        Object_33_NumZl =         Object_34_Ind_Z( 1 );  
        Object_33_NumZu =         Object_34_Ind_Z(end); 
        Object_33_NumZd =  length(Object_34_Ind_Z);
        Object_31_FOVZm = max(abs(Object_31_FOVZu),abs(Object_31_FOVZl));
end

%         Object_31_FOVZm = max(abs(Object_31_FOVZu),abs(Object_31_FOVZl));  
%         Object_33_NumZu = round(  Object_31_FOVZu /    Object_32_STP_Z) ;  
%         Object_33_NumZl = round(  Object_31_FOVZl /    Object_32_STP_Z) ;  
%         Object_33_NumZd = 1 +     Object_33_NumZu -    Object_33_NumZl  ;  
%         Object_34_Ind_Z =       ( Object_33_NumZl :    Object_33_NumZu) ;  
%         Object_35_CoorZ =         Object_34_Ind_Z *    Object_32_STP_Z  ;  