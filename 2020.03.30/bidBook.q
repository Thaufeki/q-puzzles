simQuote:{[venueList;nRow]
    priceList:30+0.01*til 10;
    prices:asc -3?priceList;
    venues:3?venueList;
    bidPrices:(count each venues)#'prices;
    bidExchanges:raze venues;
    (bidPrices;bidExchanges)
  };

simLob:{
    nRows:20;
    seed:-314159;
    openTime:`time$09:30;
    closeTime:`time$16:00;
    litVenues:`XNYS`ARCX`XCHI`XASE`XCIS`XNAS`XBOS`XPHL`BATS`BATY`EDGA`EDGX`IEXG;

    system "S ",string seed;
    times:asc closeTime&openTime+nRows?390*60*1000;
    nExchanges:2+nRows?(count litVenues)-8;
    bidVenues:{y?x}[litVenues;] each nExchanges;
    quotes:simQuote[bidVenues;] each til nRows;

    :([]time:times;bidPrices:raze each quotes[;0];bidExchanges:quotes[;1]);
  };
lob:simLob[];

// my sol
tab:update bl:`XNYS =' bidExchanges from lob where any each bidExchanges in\: `XNYS;
orderBook:select time, bidPrices from update bidExchanges:{x where y}'[bidExchanges;bl],bidPrices:{x where y}'[bidPrices;bl:`XNYS =' bidExchanges] from tab

// their sol

lob:update nyseLoc:(where') `XNYS=bidExchanges from lob;
select time, bidPrices:bidPrices@' nyseLoc from lob

// admittedly a lot neater. I couldn't use each both with 'where', but for some reason my makeshift version worked
// enclose in parentheses like (+/), don't know why they need parentheses to work. It's the same in K
// apply each both. can just apply boolean lists to lists. was thinking of using an apply, but thought it might not work

// their sol with one liner

select time, bidPrices:bidPrices@' (where') `XNYS=bidExchanges from lob

// yeah, don't see the point of an extra col.
// 