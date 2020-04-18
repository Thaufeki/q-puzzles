// Every year that is exactly divisible by four is a leap year, except for years that are exactly divisible by 100, 
// but these centurial years are leap years if they are exactly divisible by 400.

args:.Q.opt .z.x;

isLeapYear:{[year]
    $[year mod 4;
        :0b;
      not year mod 100;
        $[year mod 400;:0b;:1b];
      :1b
    ];
 };

// Just because it's being annoying me

isLeapYear1:{{x;y;z} . 0=x mod\: 100 400 4};

// This is listed as an alternative solution, but is incorrect? will return true on any value divisible by 4
// q)isLeapYear1[100]
// 1b

// So this is the optimal solution
isLeapYear2:{$[0=x mod 100;0=x mod 400;0=x mod 4]};



main:{[year]

    -1 string isLeapYear[year];
    start:.z.p;result:do[100000;isLeapYear each 1800 1900 2000 2020];exectimeSol:.z.p-start;
    -1 "Performance: ", string `long$`time$exectimeSol;
    start:.z.p;result:do[100000;isLeapYear2 each 1800 1900 2000 2020];exectimeBest:.z.p-start;
    -1 "Performance of best program: ", string `long$`time$exectimeBest;
    perf:exectimeSol - exectimeBest;
    $[0 < perf;-1 "Solution ",(string `long$`time$perf),"ms slower than best";-1 "Solution ",(string `long$`time$perf),"ms faster than best"]
 };

if[count args;
    year:"I"$first args[`year];
    main[year];
    exit 0
 ]