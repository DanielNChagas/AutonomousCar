
%
% do not forget - if you leave timers active you system may become very
% slow
% in case you're not sure if you have timers active do
% delete(timerfindall)
%


% my_timer = timer('Name', 'my_timer', 'ExecutionMode', 'fixedRate', 'Period', 1, ...
%                     'StartFcn', @(x,y)disp('started...'), ...
%                     'StopFcn', @(x,y)disp('stopped ...'), ...
%                     'TimerFcn', @(x,y)disp('ping'))

my_timer = timer('Name', 'my_timer', 'ExecutionMode', 'fixedRate', 'Period', 1, ...
                    'StartFcn', @(x,y)disp('Timer started...'), ...
                    'StopFcn', @(x,y)disp('Timer stopped ...'), ...
                    'TimerFcn', @my_callback_fcn)
                    
start(my_timer)