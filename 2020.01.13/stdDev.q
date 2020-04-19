// Usage: q stdDev.q

simSlippage:{
    n:10000;

    system "S -314159";
    slippage:5-0.01*n?1000;

    system "S -314159";
    notional:10000+n?100000;

    ([] notional:notional;slippage:slippage)
  };

// I don't understand how this correct
// It's a reduction of the calculation that I haven't seen anywhere
// In my calc I followed the function to the letter, and got a different answer
// so need to see what's up

 wsdev:{[w;x]
    $[1>=n:sum w<>0;:0f;sqrt (n%n-1)*w wavg xdm*xdm:x-w wavg x]
  };

// Would like to review later,
// currently >10x slower than above solution

my_wsdev:{[w;data]
    :(sum w*(data-wavg[w;data])xexp 2)%(sum w)*(n0-1)%n0:sum w<>0
 };

main:{[]

    perfData:simSlippage[];
    -1 string exec my_wsdev[notional;slippage] from perfData;
    start:.z.p;do[10000;exec my_wsdev[notional;slippage] from perfData];execTimeSol:.z.p-start;
    start:.z.p;do[10000;exec wsdev[notional;slippage] from perfData];execTimeBest:.z.p-start;
    perf:execTimeSol - execTimeBest;
    perfPct:string floor 100*perf%execTimeBest;
    $[0 < perf;-1 "Solution ",(string `long$`time$perf),"ms slower than best (",perfPct,"%)";-1 "Solution ",(string `long$`time$perf),"ms faster than best (",perfPct,")"];


 };

 main[];
 exit 0