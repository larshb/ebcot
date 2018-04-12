function [CX D] = bpc(y)
% Codeblock y

% Scanpattern parameters
[rows,cols] = size(y);
sections = rows/4; % (stripes)

% Initialize outputs
CX = []; % Contexts
D = [];  % Decisions

% Use signed magnitude
v = abs(y) % Magnitude array (v)
chi = y<0 % Sign array (?)

% Bitplane decomposition
bitplanes = mat2bp(v);

% Initialize state variables
sigma  = zeros(size(y));
sigma_ = zeros(size(y));
eta    = zeros(size(y));

% Fixed scan-pattern
% Clean-up pass
state = 0;
primitive = 'xx';
for section = 1:sections
    for n = 1:cols
        m = (section-1)*4+1;
        while (m < section*4)
            switch(state)
                case 0
                    if ~sigma(m,n) && ~eta(m,n)
                        sigma_neighbours = sigma( ... 
                            max(m-1,1):min(m+4,rows), ...
                            max(n-1,1):min(n+1,cols));
                        if (mod(m-1,4)==0 && ...
                                all(all(sigma_neighbours == 0)))
                            disp RL
                        else
                            disp ZC
                        end
                        disp([m-1,n-1])
                    end
            end
        end
    end
end

end

function [bits,width] = mat2bp(mat)
% Matrix to bitplanes
[dx,dy] = size(mat);
bits = de2bi(mat);
width = size(bits,2);
bits = reshape(bits, [dx, dy, width]);
end