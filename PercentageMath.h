//
//  PercentageMath.h
//  Brain
//
//  Created by Evan on 5/16/12.
//  Copyright (c) 2012 Super Top Secret. All rights reserved.
//

/** Get the percent a number is between min and max */
double PercentBetween(double value, double min, double max);
double PercentBetweenQuadratic(double value, double min, double max);
double PercentBetweenCubic(double value, double min, double max);
double PercentBetweenQuartic(double value, double min, double max);
double PercentBetweenExponential(double value, double min, double max, double exp);

/** Get a value x percent between min and max */
double ValueBetween(double percent, double min, double max);

/** Get the number a value is between two values based on an unrelated percent.
 Equivalent to:
 
 double p = PercentBetween(value, pMin, pMax);
 double v = ValueBetween(p, vMin, vMax);
 
 */
double ValueBetweenByPercent(double value, double pMin, double pMax, double vMin, double vMax);
double ValueBetweenByPercentQuadratic(double value, double pMin, double pMax, double vMin, double vMax);
double ValueBetweenByPercentCubic(double value, double pMin, double pMax, double vMin, double vMax);
double ValueBetweenByPercentQuartic(double value, double pMin, double pMax, double vMin, double vMax);
double ValueBetweenByPercentExponential(double value, double pMin, double pMax, double vMin, double vMax, double exp);