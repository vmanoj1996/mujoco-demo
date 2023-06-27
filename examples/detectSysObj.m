classdef detectSysObj < matlab.System

    properties(Nontunable)
        d;
    end

    methods (Access = protected)
        function setupImpl(obj)
        end

        function y = stepImpl(obj,u)

            y = u;
        end

    end
end
