// The first thing to do in most quantitative analysis in the electronic trading is to determine the data scope, which covers two aspects:

//    the sample period, i.e. the start and end date/time of the data
//    the cross sectional space, i.e. the universe of securities included in the analysis

// A common approach to determine the security universe is to include the top n most actively traded symbols.

/*******************************************************************

// Assuming a trade table, which has three columns: date, ticker and volume, is simulated with the function simulateTrades defined below. 
// This function generates 500000 trades for all week days in March 2020. The stock ticker is generated as three random letters. 
// The column volume indicates how many shares are traded.

// Find the top 10 symbols that are most actively traded (measured by total traded shares) on each day. 
// The returned table should have 220 rows, i.e. 10 rows for each day and the following schema:

getTradingDays:{
    firstDate:2020.03.01;
    lastDate:2020.03.31;
    dates:firstDate+til (lastDate-firstDate)+1;
    dates where not (dates mod 7) in 0 1
  };

simulateTrades:{[seed;nTrades]
    tradingDays:getTradingDays[];

    system "S ",string seed;
    dates:nTrades?tradingDays;

    system "S ",string seed;
    tickers:nTrades?`3;

    system "S ",string seed;
    volumes:100*nTrades?1+til 100;

    ([] date:dates;ticker:tickers;volume:volumes)
  };
trades:simulateTrades[-314159;5000000]

// Solution

l:10#exec ticker from `volume xdesc select sum volume by ticker from trades;
0!select dailyVol:count i by date, ticker from trades where ticker in l
