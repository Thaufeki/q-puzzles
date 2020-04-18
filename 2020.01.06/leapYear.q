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
    // Solution from web 
    // isLeapYear:{mod[;2] sum 0=x mod\: 4 100 400};
    // if year is divisible by 1 of them it has to be 4, if divisible by 400 then all 3
    // if only divisible by 2, then it has to be 4 and 100, not a leap year
    // so just check remainder of mod 2, as 1 and 3 will give true, i.e. 1
    // much more elegant than cond
 };

main:{[year]

    :isLeapYear[year]

 };
year:"I"$first args[`year];
main[year]
exit 0