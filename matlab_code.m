% Radiator Dimension Optimization
% This MATLAB code iteratively finds the minimum required radiator dimensions
% to cool a load of 1 kWh using water as the coolant.

% Constants and Assumptions
load_kwh = 1;                  % Thermal load in kilowatt-hour (kWh)
atm_temp_low = 25;             % Lower range of atmospheric temperature in °C
atm_temp_high = 30;            % Upper range of atmospheric temperature in °C
inlet_temp = 55;               % Inlet water temperature in °C
outlet_temp_low = 30;          % Lower range of outlet temperature in °C
outlet_temp_high = 35;         % Upper range of outlet temperature in °C
water_density = 1000;          % Density of water in kg/m^3
water_heat_capacity = 4186;    % Specific heat capacity of water in J/(kg·°C)
effective_area_fraction = 0.87;  % Fraction of total area used as effective area

% Initialize variables
min_radiator_length = Inf;
min_radiator_width = Inf;
min_surface_area = Inf;

% Iterative Radiator Dimension Optimization
for length = 1:200  % Length in arbitrary units
    for width = 1:200  % Width in arbitrary units
        % Calculate the total surface area
        surface_area = length * width;

        % Calculate the effective surface area
        effective_surface_area = effective_area_fraction * surface_area;

        % Calculate the temperature rise
        delta_temp = inlet_temp - outlet_temp_low;

        % Calculate the heat transfer rate
        heat_transfer_rate = load_kwh * 3600 * 1000;  % Convert kWh to J

        % Calculate the minimum required surface area using the formula:
        % Q = m * C * delta_T
        required_surface_area = heat_transfer_rate / (water_density * water_heat_capacity * delta_temp);

        % Check if the current dimensions meet the requirement
        if effective_surface_area >= required_surface_area
            if effective_surface_area < min_surface_area
                min_surface_area = effective_surface_area;
                min_radiator_length = length;
                min_radiator_width = width;
            end
        end
    end
end

% Display Results
fprintf('Minimum required radiator dimensions:\n');
fprintf('Length: %d units\n', min_radiator_length);
fprintf('Width: %d units\n', min_radiator_width);
