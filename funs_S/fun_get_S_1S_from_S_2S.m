function [ S_1S ] = fun_get_S_1S_from_S_2S ( S_2S )


%%% Description of the function
% 
% This function converts a two-sided spectrum to one-sided
%
% Since for univariate the spectrum is real, the relation between
% 1S and 2S is just a factor of 2x . However, the conjugate is implemented
% so that this function can be employed for MV
%
%
%%% Inputs:
%           S_2S        An object (structure) class 'S'
%                       The following fields need to be defined:
%                       .sides = '2S'
%                       .x_values
%                       .y_values
%                       
%
%%% Outputs:
%           S_1S        An object (structure) class 'S'
%                       The following fields are added to the object:
%                       .sides = '1S'
%                       .x_values
%                       .y_values
% 
%


%% checks

if ~strcmp(S_2S.sides,'2S')
    error('The input spectrum does not have field "sides" = "2S"')
end



%% Unwrap relevant variables, include conjugate of y_values for negative frequencies,
%  and put them into columns, in case they are row-wise

x_values = S_2S.x_values;
y_values = S_2S.y_values;
y_values(x_values<0) = conj(y_values(x_values<0));


if isrow(x_values); x_values = transpose(x_values); end
if isrow(y_values); y_values = transpose(y_values); end



%% code


S_1S = S_2S;

S_1S.sides = '1S';


% take negative, zero and positive frequency values, and put them x2 in the positive side

[x_values_1S positions] = sort([abs(x_values)]);
y_values_1S = y_values(positions)*2;

% then, remove repeated
[x_values_1S , positions] = unique(x_values_1S);

y_values_1S = y_values_1S(positions);


% asses outputs
S_1S.x_values = x_values_1S;
S_1S.y_values = y_values_1S;






