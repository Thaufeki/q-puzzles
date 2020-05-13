simOrdersTIF:{
    nOrders:10000;
    seed:-314159;
    openTime:`time$09:30;
    closeTime:`time$16:00;
    listTifs:`Day,20#`IOC;

    system "S ",string seed;
    times:asc closeTime&openTime+nOrders?390*60*1000;

    system "S ",string seed;
    tifs:nOrders?listTifs;
    ([] time:times;tif:tifs)
  };
orders:simOrdersTIF[];

// Couldn't get it, was taking too long with it
// Will go through sol from page here

iocClusters:select time,tif,isIOC:`IOC=tif from orders;
iocClusters:update iocGroup:sums 1_(>)prior (0,isIOC) from iocClusters;
iocClusters:update duration:last time-first time by iocGroup from iocClusters where isIOC;
select from iocClusters where duration=max duration

// so second line is what needs to be broken down
// first thing is joining the zero + dropping first element is redundant
// q)l:exec isIOC from iocClusters
// q)((>)prior l)~1_(>)prior(0,l)
// 1b

// but what this checks is whether each element is less than the previous
// this acts as a split for IOC groups
// then apply sums to this list of booleans, what you get is a distinct number for every group of IOC
// this grouping does include the non-IOC value that ends the group
// so next you can easily do a subtract of first time from last time per group, but only where isIOC is true
// and then just grab your max value from there

// wish i stuck it out, was doable, but got tired of this one, sort of became a mental block