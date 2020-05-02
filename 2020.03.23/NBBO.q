// There might be multiple exchanges quoting at the National Best Bid and Offer (NBBO) price level at any given time. 
// It is assumed that child orders are always placed at NBBO and can be placed to any lit exchanges. 
// The below function simChildOrders simulates some BUY orders with execution destination (exDest). 
// See the definition of FIX tag for exDest. 
// It also has a column nbbExchanges, which shows the list of lit exchanges that are present at the best bid price level.

simChildOrders:{[nOrders]
    seed:-314159;
    openTime:`time$09:30;
    closeTime:`time$16:00;
    litVenues:`XNYS`ARCX`XCHI`XASE`XCIS`XNAS`XBOS`XPHL`BATS`BATY`EDGA`EDGX`IEXG;

    system "S ",string seed;
    submitTimes:asc closeTime&openTime+nOrders?390*60*1000;

    system "S ",string seed;
    exDest:nOrders?litVenues;

    system "S ",string seed;
    nExchanges:3+nOrders?(count litVenues)-3;
    system "S ",string seed;
    nbbVenues:{y?x}[litVenues;] each nExchanges;

    ([] time:submitTimes;side:`BUY;exDest:exDest;nbbVenues:nbbVenues)
  };

childOrders:simChildOrders[5000];

// Find the number of orders which are placed to exchanges present at NBB (National Best Bid).
select from childOrders where exDest in' nbbVenues
//simple each both. checkes if each single element exDest in corresponding nbbVenue
