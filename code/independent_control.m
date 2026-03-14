function output = processInputs(x1, y1, z1, z2, x2, y2)
    % Define the base value for comparison
    baseValue = 90;

    % Initialize outputs with default value 90
    output = 90 * ones(1, 6);

    % Calculate changes from base value for both sets combined
    changes = [abs(x1 - baseValue), abs(y1 - baseValue), abs(z1 - baseValue), ...
               abs(z2 - baseValue), abs(x2 - baseValue), abs(y2 - baseValue)];
    [~, idx] = max(changes); % Find the index of the maximum change
    
    % Assign values to the output array based on the maximum change
    switch idx
        case 1
            delta = x1 - baseValue; % Change from 90
            output(1) = 90 - 0.5 * abs(delta); % Adjust the first element based on x1 deviation
            output(2) = x1; % Second element as x1
            output(3) = calculateOpposite(x1); % Opposite calculation for third element
            output(4) = 90 + abs(delta) / 12; % output(4) changes less frequently, 12 times less change
            output(5) = 90 - delta / 6; % Increase or decrease in opposite direction at half the rate of x1's change from 90
            output(6) = 90 + delta / 6; % Opposite direction change at half the rate
        case 2
            delta = y1 - baseValue; % Change from 90
            output(2:3) = y1;
            output(1) = calculateOpposite(y1);
            output(5:6) = 90 - delta / 6;
            output(4) = 90 + delta / 6;
        case 3
            delta = z1 - baseValue; % Change from 90
            output(1:3) = 180 - z1;
            output(4:6) = 90 + delta / 6;
        case 4
            delta = z2 - baseValue; % Change from 90
            output(4:6) = z2;
            output(1:3) = 90 - delta / 6;
        case 5
            delta = x2 - baseValue; % Change from 90
            output(5) = x2;
            output(4) = 90 - 0.5 * abs(x2 - baseValue);
            output(6) = calculateOpposite(x2);
            output(1) = 90 + abs(delta) / 3; 
            output(2:3) = 90 + abs(delta) / 2; 
        case 6
            delta = y2 - baseValue; % Change from 90
            output(5:6) = y2;
            output(4) = calculateOpposite(y2);
            output(1) = 90 + abs(delta) / 2;
            output(2:3) = 90 + abs(delta) / 3;
    end
end

% Helper function to calculate the opposite motion
function opposite = calculateOpposite(value)
    baseValue = 90;
    if value == baseValue
        opposite = baseValue;
    elseif value < baseValue
        opposite = 180 - (value - 0);  % Moving towards 180 from 90 as value decreases towards 0
    else % value > 90
        opposite = 90 - (value - 90); % Moving towards 0 from 90 as value increases towards 180
    end
end

