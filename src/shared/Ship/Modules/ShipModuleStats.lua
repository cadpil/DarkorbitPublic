local modules = {

    CoreInternal = {

        Hull = {

            Eagle = {

                Size_1 = {

                    Class_L = {
                        Mass = 40_000;
                        Integrity = 120;
                    }
                }
            }
        },

        Thrusters = {

            Size_1 = {

                Class_E = {
                    Mass = 2_000;
                    Integrity = 55;

                    OptimalMass = 60_000;
                    MaximumMass = 85_000;
                    OptimalMassSpeed = 200;
                    OptimalMassAccelaration = 0.55;

                    OptimalMassPitch = 1.9;
                    OptimalMassRoll = 2.75;
                    OptimalMassYaw = 0.5;
                    OptimalMassPitchAcceleration = 0.2;
                    OptimalMassRollAcceleration = 0.2;
                    OptimalMassYawAcceleration = 0.05;

                    OptimalMassLateralSpeed = 125;
                    OptimalMassVerticalSpeed = 170;
                    OptimalMassLateralAcceleration = 0.4;
                    OptimalMassVerticalAcceleration = 0.475;
                }
            }
        },
    },

}

return modules