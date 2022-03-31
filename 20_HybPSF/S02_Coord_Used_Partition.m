function [SubPar_34_Ind_Z,HybPSF_Par_Ini,HybPSF_Par_End] = S02_Coord_Used_Partition(...
          SimPSF_34_Ind_Z,HybPSF_Use_Ini,HybPSF_Use_End,SimUse_31_numsg,SimPSF_35_CoorZ)

% Used for partition the segments of depth for hybPSF generation
% 
% SimUse_31_numsg = FLF_SimPSF_Par_Seg;
% SimPSF_35_CoorZ = FLF_SimPSF_Sim_Dep;
% SimPSF_34_Ind_Z = FLF_SimPSF_Sim_Ind;
% HybPSF_Use_Ini  = FLF_PSFhyb_Ele_Ini;
% HybPSF_Use_End  = FLF_PSFhyb_Ele_End;

% HybPSF_Use_End = 200


    
    SubPar_08_frame = 1:SimUse_31_numsg:length(SimPSF_34_Ind_Z);              
    SubPar_34_Ind_Z = SimPSF_34_Ind_Z(SubPar_08_frame);                    SubPar_35_CoorZ = SimPSF_35_CoorZ(SubPar_08_frame)   ;
    SubPar_34_Index =        1:length(SubPar_08_frame);                    SubPar_33_NumZc = ceil(    length(SubPar_08_frame)/2);
    
    HybPSF_Par_Frm  =(HybPSF_Use_Ini<SubPar_34_Ind_Z) & (SubPar_34_Ind_Z<HybPSF_Use_End);
    HybPSF_Par_Ini  = min(SubPar_34_Index(HybPSF_Par_Frm))-1;
    HybPSF_Par_End  = max(SubPar_34_Index(HybPSF_Par_Frm))+1;
end


















