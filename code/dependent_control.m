function [output1, output2] = processInputs(x1, y1, z1, z2, x2, y2)
    % Define the base value for comparison, typically the midpoint    or neutral position
    baseValue = 90;

    % Initialize outputs with default value 90 for each element
    output1 = 90 * ones(1, 3);
    output2 = 90 * ones(1, 3);

    % Calculate absolute changes from the base value for the first set of inputs (x1, y1, z1)
    changes1 = [abs(x1 - baseValue), abs(y1 - baseValue), abs(z1 - baseValue)];
    [~, idx1] = max(changes1);  % Determine the index of the input with the maximum change

    % Calculate absolute changes from the base value for the second set of inputs (z2, x2, y2)
    changes2 = [abs(z2 - baseValue), abs(x2 - baseValue), abs(y2 - baseValue)];
    [~, idx2] = max(changes2);  % Determine the index of the input with the maximum change
    
    % Assign values to output1 based on the maximum change in the first set of inputs
    switch idx1
        case 1
            % Set the second element directly as x1
            output1(2) = x1;
            % Calculate and adjust the first element to decrease towards 45 from 90 as x1 deviates
            output1(1) = 90 - 0.5 * abs(x1 - baseValue);
            % Calculate the third element to behave oppositely depending on x1's value
            if x1 == 90
                output1(3) = 90;  % No change if x1 is at base value
            elseif x1 < 90
                output1(3) = 180 - x1;  % Increase if x1 decreases
            else
                output1(3) = 90 - (x1 - 90);  % Decrease if x1 increases
            end
        case 2
            % Set the middle and last elements directly as y1
            output1(2:3) = y1;
            % Opposite action for the first element
            if y1 == 90
                output1(1) = 90;
            elseif y1 < 90
                output1(1) = 180 - y1;
            else
                output1(1) = 90 - (y1 - 90);
            end
        case 3
            % All elements set inversely from z1
            output1(1:3) = 180 - z1;
    end

    % Assign values to output2 based on the maximum change in the second set of inputs
    switch idx2
        case 1
            % Set all elements directly as z2
            output2(1:3) = z2;
        case 2
            % Set the second element directly as x2
            output2(2) = x2;
            % Adjust the first element similarly to output1(1)
            output2(1) = 90 - 0.5 * abs(x2 - baseValue);
            % Opposite action for the last element
            if x2 == 90
                output2(3) = 90;
            elseif x2 < 90
                output2(3) = 180 - x2;
            else
                output2(3) = 90 - (x2 - 90);
            end
        case 3
            % Set the last two elements directly as y2
            output2(2:3) = y2;
            % Opposite action for the first element
            if y2 == 90
                output2(1) = 90;
            elseif y2 < 90
                output2(1) = 180 - y2;
            else
                output2(1) = 90 - (y2 - 90);
            end
    end
end
