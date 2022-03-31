function q = Z_integralCalc_3_SAccelerate_V6(fun,a,b,opstruct)
%INTEGRALCALC  Perform INTEGRAL calculation.
% 
    %   Based on "quadva" by Lawrence F. Shampine.
    %   Ref: L.F. Shampine, "Vectorized Adaptive Quadrature in Matlab",
    %   Journal of Computational and Applied Mathematics 211, 2008, pp.131-140
    %
    %   Strong algebraic singularities are handled with a technique from
    %   L.F. Shampine, "Weighted Quadrature by Change of Variable", Neural,
    %   Parallel, and Scientific Computations 18, 2010, pp. 195-206.
    %
    %   Copyright 2007-2015 The MathWorks, Inc.
% 
    % Variable names in all caps are referenced in nested functions.
%     
    % Fixed parameters.
%     
%   test
%     fun = @(theta) (sqrt(cos(theta))) ...
%                  .* (1 +    cos(theta) ) ...
%                  .* (exp((1i.*u/2) * (sin(theta/2).^2) / sin2alh   )) ...
%                  .* (besselj(0,       sin(theta)       / sin_al .*V)) ...
%                  .* (sin(theta));
%     a   = 0
%     b   = alpha
% 

        Default_MAXInterValCount = 16384; % 2^14
        % Unpackage options.
        rule                 = opstruct.Rule;
        NODES                = rule.Nodes(:);
        NNODES               = numel(NODES);
        WT                   = rule.HighWeights;
        EWT                  = WT - rule.LowWeights;
        ATOL                 = opstruct.AbsTol;
        RTOL                 = opstruct.RelTol;
        INITIALINTERVALCOUNT = opstruct.InitialIntervalCount;
        ARRAYVALUED          = opstruct.ArrayValued;
        MAXINTERVALCOUNT     = ceil(Default_MAXInterValCount*opstruct.Persistence);
        FUN                  = fun;
        
        A = a;                                                             % a   = 0
        B = b;                                                             % b   = alpha
        
        % Construct interval vector with waypoints.                        % since waypoints is void;
%         rinterval = [A,B];                                               % rinterval = [A,B];
        % Extract A and B from interval vector to regularize possible mixed single/double inputs.
%         A    = rinterval( 1 );                                             
%         B    = rinterval(end);                                             
%         ONE  = ones( class(rinterval));                                    % ONE  = 1 (double)

        C1 = 0.25*(B-A);
        C2 = 0.50*(B+A);
        C3 = 0.75*(B-A);
        ONE  = ones('double');                                             % ONE  = 1 (double)

%         rinterval = [-ONE,+ONE];                                           % true : a = 1, b = alpha        
%         tinterval = rinterval;
%        [tinterval,pathlen] = split_inter(tinterval,INITIALINTERVALCOUNT);  
       
        pathlen   = 2;
        tinterval = -ONE:(pathlen/INITIALINTERVALCOUNT):+ONE;
        q = iterateArrayValued(@AtoBInvTransform,tinterval);

    %--------------------------------------------------------------------------

        function q = iterateArrayValued(u,tinterval)
            % Initialize array of subintervals of [a,b].
            subs  = [tinterval(1:end-1);tinterval(2:end)];
            nsubs = size(subs,2);
            % SUBS contains subintervals of [a,b] 
            %   where the integral is not sufficiently accurate. 
            % The first  row of SUBS holds the                left end points and 
            % the second row of SUBS holds the corresponding right end points.
            % First round of iteration
            midpt = sum( subs)/2;   % midpoints of the subintervals
            halfh = diff(subs)/2;  % half the lengths of the subintervals
            x     = NODES*halfh + midpt; % NNODES x nsubs
            
            [t,w] = u(x(:,1));
            fx1     = FUN(t(1)).*w(1);
            nfx     =         numel(  fx1);
            outsize =          size(  fx1);
            outcls  = superiorfloat(x,fx1);
                   finalInputChecks(x,fx1);
            % Define initializers.
            if issparse(fx1)
                zeros_nfx_by_nsubs = sparse(nfx,nsubs);
%                 zeros_outsize      = sparse(outsize(1),outsize(2));
                zeros_nfx_by_1     = sparse(nfx,1);
            else
                zeros_nfx_by_nsubs = zeros([nfx,nsubs],outcls);
%                 zeros_outsize      = zeros( outsize   ,outcls);
                zeros_nfx_by_1     = zeros( nfx,1     ,outcls);
            end
              q_ok = gpuArray(zeros_nfx_by_1);                             % Initialize partial sums.

%                     %TST
%             iternumber = 0
%                     %TST
            % Initialize main loop
            while true
%                     %TST
%                 iternumber = iternumber+1
%                     %TST
                qsubs   = gpuArray(zeros_nfx_by_nsubs);
                errsubs = gpuArray(zeros_nfx_by_nsubs);
                q       = q_ok;
                    for k = 1:nsubs
                          qsubsk = gpuArray(zeros_nfx_by_1);
                        errsubsk = gpuArray(zeros_nfx_by_1);
                            [t,w] = u(x(:,k));
                        too_close = checkSpacing(t);
                        if too_close
                            break
                        end
                        for j = 1:NNODES
                                 fxj =        FUN(t(j)).*  w(j);
                              qsubsk =   qsubsk + fxj(:)* WT(j);
                            errsubsk = errsubsk + fxj(:)*EWT(j);
                        end
                        errsubs(:,k) =   errsubsk.*halfh(k);
                          qsubs(:,k) =     qsubsk.*halfh(k);
                          q          = q + qsubs(      :,k);
                    end
                % Locate subintervals where the approximate integrals are sufficiently accurate and 
                % use them to update the partial error sum.
                
%               tol  = abs(q(:))*RTOL;
                tolr = abs(q   )*RTOL;%*(2/pathlen);
%               tola =           ATOL;%*(2/pathlen);
                err_ok = gpuArray(zeros_nfx_by_1);
                err_no =          zeros_nfx_by_1 ;
                nleft  = 0;
                
                for k = 1:nsubs
                    abs_halfhk   = abs(  halfh(  k));
                    abs_errsubsk = abs(errsubs(:,k));
                    if all( abs_errsubsk <= tolr*abs_halfhk | ...
                            abs_errsubsk <= ATOL*abs_halfhk)
                          q_ok =   q_ok +   qsubs(:,k);
                        err_ok = err_ok + errsubs(:,k);
                    else
                        err_no = err_no + abs_errsubsk;
                        nleft         = nleft + 1;
                        subs(:,nleft) = subs(:,k);
                        midpt( nleft) = midpt( k);
                    end
                end
                
                 subs = subs(:,1:nleft); % Trim subs  array.
                midpt = midpt( 1:nleft); % Trim midpt array.
                % For iteration
                nsubs = 2*nleft;
%               nsubs = 2*size(subs,2);???same???
                 subs = reshape([subs(1,:); midpt; midpt; subs(2,:)],2,[]);
                % Split the remaining subintervals in half.  
                midpt = sum( subs)/2;   % midpoints of the subintervals
                halfh = diff(subs)/2;  % half the lengths of the subintervals
                x     = NODES*halfh + midpt; % NNODES x nsubs
                
                % The approximate error bound is constructed 
                %   by adding the approximate error bounds for the subintervals 
                %   with accurate approximations to the 1-norm of the approximate error bounds for the remaining subintervals.  
                % This guards against excessive cancellation of the errors of the remaining subintervals.
%                 errbnd = reshape(abs(err_ok) + err_no, outsize);
                errbnd = abs(err_ok) + err_no;
                % Test for convergence.
%               if nleft < 1 || all( errbnd(:) <= tol | errbnd(:) <= ATOL)
                if nleft < 1 || all( errbnd    <= tolr| errbnd    <= ATOL)
                    break
                end
                % Check for nonfinites.
                if ~all(isfinite(q) & isfinite(errbnd))
                    warning(  message('MATLAB:integral:NonFiniteValue'));
                    if opstruct.ThrowOnFail
                        error(message('MATLAB:integral:unsuccessful'));
                    end
                    break
                end
                % Quit if splitting results in too many subintervals.
                if nsubs > MAXINTERVALCOUNT
                    % newPersistence = ceil(nsubs/DEFAULT_MAXINTERVALCOUNT);
                    warning(  message('MATLAB:integral:MaxIntervalCountReached',sprintf('%9.1e',max(errbnd(:)))));
                    if opstruct.ThrowOnFail
                        error(message('MATLAB:integral:unsuccessful'));
                    end
                    break
                end
            end
            q = gather(reshape( q ,outsize));
        end
    %--------------------------------------------------------------------------

        function [x,w] = AtoBInvTransform(t)
            % Transform to weaken singularities at both ends: [a,b] -> [-1,1]
            x = C1*t.*(3 - t.^2) + C2;
            w = C3   *(1 - t.^2);

            % Equivalent formula for values close to -1 or 1 (better numerically)
            tShift      = abs(t) - 1;
            xOffset     =  C1*tShift.^2.*(tShift + 3);
            wBoundaries = -C3*tShift   .*(tShift + 2);

            bd = 1/4; % distance from zero at which special-case treatment is used.
            x(    t<-bd) = A + xOffset(    t<-bd);
            x(    t> bd) = B - xOffset(    t> bd);
            w(abs(t)>bd) = wBoundaries(abs(t)>bd);
        end

    %--------------------------------------------------------------------------

        function too_close = checkSpacing(x)
            ax = abs(x);
            tcidx = find(abs(diff(x)) <= 100*eps(class(x))* ...
                max(ax(1:end-1),ax(2:end)),1);
            too_close = ~isempty(tcidx);
            if too_close
                warning(message('MATLAB:integral:MinStepSize', ...
                    num2str(x(tcidx),6)));
                if opstruct.ThrowOnFail
                    error(message('MATLAB:integral:unsuccessful'));
                end
            end
        end % checkSpacing

    %--------------------------------------------------------------------------

        function finalInputChecks(x,fx)
            % Do final input validation with sample input and outputs to the integrand function.
            % Check classes.
            if ~isfloat(fx)
                error(message('MATLAB:integral:UnsupportedClass',class(fx)));
            end
            % Check sizes.
            if ~ARRAYVALUED && ~isequal(size(x),size(fx))
                error(message('MATLAB:integral:FxNotSameSizeAsX'));
            end
            outcls = superiorfloat(x,fx);
            outdbl = strcmp(outcls,'double');
            % Make sure that RTOL >= 100*eps(outcls) except when using pure
            % absolute error control (ATOL>0 && RTOL==0). Obviously we're
            % assuming that the default tolerances are OK.
            if ~(ATOL > 0 && RTOL == 0) && RTOL < 100*eps(outcls)
                RTOL = 100*eps(outcls);
            end
            if outdbl
                % Single RTOL or ATOL should not force any single precision
                % computations.
                RTOL = double(RTOL);
                ATOL = double(ATOL);
            else
                WT    = cast(WT,class(fx));
                EWT   = cast(EWT,class(fx));
                NODES = cast(NODES,class(x));
            end
        end % finalInputChecks

    %--------------------------------------------------------------------------

end
