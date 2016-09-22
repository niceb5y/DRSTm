//
//  EXPKit.swift
//  DRSTKit
//
//  Created by 김승호 on 2016. 1. 15..
//  Copyright © 2016년 Seungho Kim. All rights reserved.
//

import UIKit

/**
Deresute EXP Data
- author: niceb5y
*/
open class DRSTEXP: NSObject {
	static let exp: Array<Int> = [
		30,    50,    70,    90,    110,   130,   150,   170,   190,   210,
		230,   250,   270,   290,   310,   330,   350,   370,   390,   410,
		430,   450,   470,   490,   510,   530,   550,   570,   590,   610,
		630,   650,   670,   690,   710,   730,   750,   770,   790,   810,
		830,   850,   870,   890,   910,   930,   950,   970,   990,   1500,
		1520,  1540,  1560,  1580,  1600,  1620,  1640,  1660,  1680,  1700,
		1720,  1740,  1760,  1780,  1800,  1820,  1840,  1860,  1880,  1900,
		1920,  1940,  1960,  1980,  2000,  2020,  2040,  2060,  2080,  2100,
		2120,  2140,  2160,  2180,  2200,  2220,  2240,  2260,  2280,  2300,
		2320,  2340,  2360,  2380,  2400,  2420,  2440,  2460,  2480,  3000,
		3020,  3040,  3060,  3080,  3100,  3120,  3140,  3160,  3180,  3200,
		3220,  3240,  3260,  3280,  3300,  3320,  3340,  3360,  3380,  3400,
		3420,  3440,  3460,  3480,  3500,  3520,  3540,  3560,  3580,  3600,
		3620,  3640,  3660,  3680,  3700,  3720,  3740,  3760,  3780,  3800,
		3820,  3840,  3860,  3880,  3900,  3920,  3940,  3960,  3980,  4500,
		4520,  4540,  4560,  4580,  4600,  4620,  4640,  4660,  4680,  5400,
		5420,  5440,  5460,  5480,  5500,  5520,  5540,  5560,  5580,  6300,
		6320,  6340,  6360,  6380,  6400,  6420,  6440,  6460,  6480,  7200,
		7220,  7240,  7260,  7280,  7300,  7320,  7340,  7360,  7380,  8100,
		8120,  8140,  8160,  8180,  8200,  8220,  8240,  8260,  8280,  9000,
		9020,  9040,  9060,  9080,  9100,  9120,  9140,  9160,  9180,  9900,
		9920,  9940,  9960,  9980,  10000, 10020, 10040, 10060, 10080, 10800,
		10820, 10840, 10860, 10880, 10900, 10920, 10940, 10960, 10980, 11700,
		11720, 11740, 11760, 11780, 11800, 11820, 11840, 11860, 11880, 12600,
		12620, 12640, 12660, 12680, 12700, 12720, 12740, 12760, 12780, 13500,
		13520, 13540, 13560, 13580, 13600, 13620, 13640, 13660, 13680, 14400,
		14420, 14440, 14460, 14480, 14500, 14520, 14540, 14560, 14580, 15300,
		15320, 15340, 15360, 15380, 15400, 15420, 15440, 15460, 15480, 16200,
		16220, 16240, 16260, 16280, 16300, 16320, 16340, 16360, 16380, 17100,
		17120, 17140, 17160, 17180, 17200, 17220, 17240, 17260, 17280, 0
	]

	/**
	EXP at certain level
	- author: niceb5y
	- parameters:
		- level: Level of Account
	- returns: EXP (or -1 if value not exist)
	*/
	open static func expAtLevel(_ level: Int) -> Int {
		if level >= 1 && level <= 300 {
			return exp[level - 1]
		}
		return -1
	}
}
