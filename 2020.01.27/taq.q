genTrades:{[seed;nTrades]
    / Randomly generate each trade's timestamp
    system "S ",string seed;
    times:`time$09:28:00.000+nTrades?392*60*1000;

    / Randomly generate trade size
    system "S ",string seed;
    volumes:`long$100*1+nTrades?10;

    / Randomly generate each trade's sale condition
    system "S ",string seed;
    saleConditions:{x?`B`C`H`L`N`P`R`T`U`V`X`Z`7`4`5`8} each nTrades?3;

    / Create a table of trades
    trades:([] time:times;volume:volumes;saleCondition:saleConditions);

    / Add the open and close auction trades
    trades:trades upsert (`time$09:30:00.000+rand 60000;24700j;`O`X);
    trades:trades upsert (`time$16:00:00.000+rand 2000;53800j;enlist `6);

    / Sort the trades time by time
    `time xasc trades
  };
simTrades:genTrades[-314159;10000];
simTrades

// To simplify the question, it is assumed that open/close auction trades are ALWAYS present. 
// The function genTrades above simulates 10,002 trades. Note that each trade has up to two sale condition codes. 
// Find the total volume between the two auction trades, inclusively.

//Just the volume of the 2 records?
// Yeah that's it

select sum volume from simTrades where any each saleCondition like\: "*[O6]*"