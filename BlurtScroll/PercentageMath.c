//
//  PercentageMath.c
//  Brain
//
//  Created by Evan on 5/16/12.
//  Copyright (c) 2012 Super Top Secret. All rights reserved.
//

#import "PercentageMath.h"
#import "math.h"

double PercentBetween(double value, double min, double max) {
    double den = max - min;
    if (den == 0.0f) {
        return min;
    } else {
        double num = value - min;
        return num / den;
    }
}

double PercentBetweenQuadratic(double value, double min, double max) {
    return PercentBetweenExponential(value, min, max, 2);
}
double PercentBetweenCubic(double value, double min, double max) {
    return PercentBetweenExponential(value, min, max, 3);
}
double PercentBetweenQuartic(double value, double min, double max) {
    return PercentBetweenExponential(value, min, max, 4);
}

double PercentBetweenExponential(double value, double min, double max, double exp) {
    return pow(PercentBetween(value, min, max), exp);
}


double ValueBetween(double percent, double min, double max) {
    return min + (max - min) * percent;
}

double ValueBetweenByPercent(double value, double pMin, double pMax, double vMin, double vMax)
{
    double p = PercentBetween(value, pMin, pMax);
    double v = ValueBetween(p, vMin, vMax);
    return v;
}

double ValueBetweenByPercentQuadratic(double value, double pMin, double pMax, double vMin, double vMax) {
    return ValueBetweenByPercentExponential(value, pMin, pMax, vMin, vMax, 2);
}

double ValueBetweenByPercentCubic(double value, double pMin, double pMax, double vMin, double vMax) {
    return ValueBetweenByPercentExponential(value, pMin, pMax, vMin, vMax, 3);
}

double ValueBetweenByPercentQuartic(double value, double pMin, double pMax, double vMin, double vMax) {
    return ValueBetweenByPercentExponential(value, pMin, pMax, vMin, vMax, 4);
}

double ValueBetweenByPercentExponential(double value, double pMin, double pMax, double vMin, double vMax, double exp)
{
    double p = PercentBetweenExponential(value, pMin, pMax, exp);
    double v = ValueBetween(p, vMin, vMax);
    return v;
}
