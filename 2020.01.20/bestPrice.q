genCO:{[parentId;waveId;side]
    n:-5;

    system "S -314159";
    ids:`long$.z.N+n?1000;

    system "S -314159";
    prices:100+0.01*n?100;

    system "S -314159";
    sizes:100*1+n?10;

    ([] poid:parentId;wid:waveId;coid:ids;side:side;price:prices;size:sizes)
  };

genOrders:{
    buyOrders:raze {poid:`long$22:32:12.163;genCO[poid;x;`BUY]} each 101+til 20;
    sellOrders:raze {poid:`long$23:32:12.163;genCO[poid;x;`SELL]} each 101+til 20;
    buyOrders,sellOrders
  };

orders:genOrders[];

// Find the most aggressive order, i.e. buy order with the highest price and sell order with the lowest price, within each evaluation cycle.
// eval cycle = wid, by the looks of it

b:select from orders where side=`BUY,price=(max;price) fby wid;
s:select from orders where side=`SELL,price=(min;price) fby wid;
:b,s
