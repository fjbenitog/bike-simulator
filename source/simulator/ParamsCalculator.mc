using Toybox.System;
using Toybox.Math;
using Toybox.Test;
module Simulator{

	class Result{
		var power;
		var gear;
		
		function initialize(power_, gear_){
			power = power_;
			gear = gear_;
		}
	}
		
		function calculate(percentage){
			return calculateForTesting(Properties.gears(), Properties.power(), Properties.level(),percentage);
		}
		
		function calculateForTesting(gears, powerSize, level,percentage){
			var power = percentage + level;
			if(power > powerSize){
				return new Result(powerSize,gears - (power - powerSize));
			}else if(power<1){
				return new Result(1,gears);
			}else{
				return new Result(power,gears);
			}
		}
		
	
	(:test)
	function level1Percentage0(logger){
		var gears = 8;
		var powerSize = 10;
		var level = 1;
		var percentage = 0;
		var result = new Result(1,8);
		return checkCalculator(logger,gears,powerSize,level,percentage, result);
	}
	
	(:test)
	function level1Percentage1(logger){
		var gears = 8;
		var powerSize = 10;
		var level = 1;
		var percentage = 1;
		var result = new Result(2,8);
		return checkCalculator(logger,gears,powerSize,level,percentage, result);
	}
	
	(:test)
	function level1Percentage9(logger){
		var gears = 8;
		var powerSize = 10;
		var level = 1;
		var percentage = 9;
		var result = new Result(10,8);
		return checkCalculator(logger,gears,powerSize,level,percentage, result);
	}
	
	(:test)
	function level1Percentage10(logger){
		var gears = 8;
		var powerSize = 10;
		var level = 1;
		var percentage = 10;
		var result = new Result(10,7);
		return checkCalculator(logger,gears,powerSize,level,percentage, result);
	}
	
	(:test)
	function level1Percentage11(logger){
		var gears = 8;
		var powerSize = 10;
		var level = 1;
		var percentage = 11;
		var result = new Result(10,6);
		return checkCalculator(logger,gears,powerSize,level,percentage, result);
	}
	
	(:test)
	function level1Percentage16(logger){
		var gears = 8;
		var powerSize = 10;
		var level = 1;
		var percentage = 16;
		var result = new Result(10,1);
		return checkCalculator(logger,gears,powerSize,level,percentage, result);
	}
	
	(:test)
	function level5PercentageMinus1(logger){
		var gears = 8;
		var powerSize = 10;
		var level = 5;
		var percentage = -1;
		var result = new Result(4,8);
		return checkCalculator(logger,gears,powerSize,level,percentage, result);
	}
	
	(:test)
	function level5Percentage0(logger){
		var gears = 8;
		var powerSize = 10;
		var level = 5;
		var percentage = 0;
		var result = new Result(5,8);
		return checkCalculator(logger,gears,powerSize,level,percentage, result);
	}
	
	(:test)
	function level5Percentage1(logger){
		var gears = 8;
		var powerSize = 10;
		var level = 5;
		var percentage = 1;
		var result = new Result(6,8);
		return checkCalculator(logger,gears,powerSize,level,percentage, result);
	}
	
	(:test)
	function level5Percentage5(logger){
		var gears = 8;
		var powerSize = 10;
		var level = 5;
		var percentage = 5;
		var result = new Result(10,8);
		return checkCalculator(logger,gears,powerSize,level,percentage, result);
	}
	
	(:test)
	function level5Percentage6(logger){
		var gears = 8;
		var powerSize = 10;
		var level = 5;
		var percentage = 6;
		var result = new Result(10,7);
		return checkCalculator(logger,gears,powerSize,level,percentage, result);
	}
	
	
	(:test)
	function level5Percentage12(logger){
		var gears = 8;
		var powerSize = 10;
		var level = 5;
		var percentage = 12;
		var result = new Result(10,1);
		return checkCalculator(logger,gears,powerSize,level,percentage, result);
	}
	
	(:test)
	function level3PercentageMinus2(logger){
		var gears = 8;
		var powerSize = 10;
		var level = 5;
		var percentage = -2;
		var result = new Result(3,8);
		return checkCalculator(logger,gears,powerSize,level,percentage, result);
	}
	
	function checkCalculator(logger,gears,powerSize,level,percentage,expectedResult){
		logger.debug("Calculator(gears:"+gears+",powerSize:"+powerSize+",level:"+level+") with percentage = "+percentage);
		var result = calculateForTesting(gears,powerSize,level,percentage);
		logger.debug("Return: Result(power:"+result.power+" , gear:"+result.gear+")");
		Test.assertEqualMessage(expectedResult.power, result.power, "Power expected was "+expectedResult.power+" but was " + result.power);
		Test.assertEqualMessage(expectedResult.gear, result.gear, "Gear expected was "+expectedResult.gear+" but was " + result.gear);
		return true;
	}
	
}