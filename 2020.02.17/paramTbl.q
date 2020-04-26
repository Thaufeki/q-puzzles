// In the algorithmic trading world, parameterization is so common that some algorithms are configured with hundreds or thousands of parameters. 
// An algorithmic parent order can easily has hundreds of parameters and some of which are exposed to algorithm users 
// so that they can update the order attributes. 
// For example, the participation rate of a POV (Percent Of Volume) order can be amended by end users at any time during the trading duration. 
// A common question encountered in the analysis of algorithm and/or smart order router behavior is

//   - what parameters are modified, and
//   - how they are updated

// when an amend event is initiated by an algorithmic trader.

// Below is an example history of a few selected parameters of a POV order. 
// Create a table to show the parameter history with each parameter name as the column name in the table. 
// You need to treat the change in order quantity and/or price limit the same as parameter change.

paramTbl:([]time:`time$();orderQty:`long$();limitPrice:`float$();params:());
`paramTbl insert (09:30:56.123;500000;0n;`StartTime`PovRate!(10:00:00.000;0.08));
`paramTbl insert (09:35:44.735;500000;0n;`StartTime`PovRate!(09:40:00.000;0.08));
`paramTbl insert (10:01:25.941;500000;0n;`StartTime`PovRate!(09:40:00.000;0.12));
`paramTbl insert (10:10:32.356;500000;0n;`StartTime`PovRate`MinPovRate`MaxPovRate!(09:40:00.000;0.12;0.10;0.14));
`paramTbl insert (10:30:39.475;500000;45.23;`StartTime`PovRate`MinPovRate`MaxPovRate!(09:40:00.000;0.12;0.10;0.14));
`paramTbl insert (11:00:52.092;600000;45.27;`StartTime`PovRate`MinPovRate`MaxPovRate!(09:40:00.000;0.12;0.10;0.14));
`paramTbl insert (11:00:52.092;1000000;0n;`StartTime`PovRate!(09:40:00.000;0.15));



// Answer
params:raze exec params from paramTbl;
nulls:((key params)!enlist each value params)[;1];
paramTab:nulls ,/: params;
tab:select time, orderQty, limitPrice from paramTbl;
tab,'paramTab

// You can index OOB to get nulls
// Can join a null dictionary with cols we want to a full one to normalize a schema and fill with nulls, so we get a table
