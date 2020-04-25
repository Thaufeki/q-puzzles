// Didn't get this one

genOrders:{[nOrders;seed;openTime;closeTime]
    system "S ",string seed;
    submitTimes:asc closeTime&openTime+nOrders?390*60*1000;

    system "S ",string seed;
    exitTimes:closeTime&submitTimes+nOrders?60*1000;

    ([] orderId:1000+til nOrders;subT:submitTimes;exitT:exitTimes)
  };

openTime:`time$09:30;
closeTime:`time$16:00;
simOrders:genOrders[5000;-314159;openTime;closeTime];

//find the number of open orders at any given time

//times:update maxT:maxs exitT from simOrders;
//times:update noOrderDur:subT-prev maxT from times;
//times:update noOrderDur:subT-openTime from times where null noOrderDur;
//select startTime:`time$subT-noOrderDur,periodLength:`time$noOrderDur from times where noOrderDur>0


// At any time, the number of open orders is where the given time is greater than the startTime, and less than the endTime
// Didn't get it, checked and this is the actual solution
initOrder:([] time:enlist openTime;nOpenOrders:enlist 0);
addOrder:select time:subTime,nOpenOrders:1 from simOrders;
removeOrder:select time:exitTime,nOpenOrders:-1 from simOrders;
orders:select time,sums nOpenOrders from `time xasc initOrder,addOrder,removeOrder;
select time,nOpenOrders from orders where differ nOpenOrders

// it gets it at every single time, subT and exitT
// I was going to pick an arbitrary list of times, as they were never specified
// I dind't understand the question tbh, they just said 'any given time'
// Simple just gets startTimes and has a +1 for each, gets endTimes and a -1 for each
// joins the tables, sorts by time. and gets running sum of 
// This one is a loss




