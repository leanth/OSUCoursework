function I = twoDtrap(func, ax, bx, ay, by, n, varargin)
% trap: composite trapezoidal rule quadrature
% [I, S] = trap(func, a, b, n, pl, p2,...): compositie trapezoidal rule
% input:
%   func = name of the function to be integrated
%   a, b = integration limits
%   n = number of segments (default = 100)
%   p1, p2,... = additional parameters used by func
% output:
%   I = integral estimate
%   S = array of segment values (n segments)

x_a = ax; % initialize 1st x point
y_a = ay; % initialize 1st y point
% h = (b - a) / n;
% s = func(a , varargin{:});
wx = (bx - ax) / n; % base width, dependent on n number of segments
wy = (by - ay) / n; % base width, dependent on n number of segments
S = zeros(n, 2); % allocate memory based on n number of segments

% modified trap code
for i = 1:n
    y_b = y_a + wy;
    for j = 1:n
        x_b = x_a + wx; % next point
        avg_h = (func(x_a, y_a, varargin{:}) + func(x_b, y_b, varargin{:})) / 2; % avg height
        s = wx * avg_h; % volume
        S(i, 1) = s; % store computed area of segment
        x_a = x_b; % next segment
    end
    y_a = y_b;
end

I = sum(S); % sum of all segment areas

end