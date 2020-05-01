// NASDAQ publishes the listed symbols on its exchange on a daily basis. 
// Download the text file nasdaqlisted.txt from here and save the file on your personal computer. 
// The file you downloaded has a header and footer. For example

// Header

// Symbol|Security Name|Market Category|Test Issue|Financial Status|Round Lot Size|ETF|NextShares

// Footer

// File Creation Time: 0316202018:01|||||||

// Write a q script snippet to load this text file into kdb table nasdaqlisted with the following schema:

// q) meta nasdaqlisted
// | c              | t f a |
// |----------------|-------|
// | symbol         | s     |
// | securityName   | s     |
// | marketCategory | s     |
// | isTestIssue    | b     |
// | lotSize        | j     |
// | isETF          | b     |

nasdaqlisted:`symbol`securityName`marketCategory`isTestIssue`lotSize`isETF xcol("sssbjb";enlist"|")0: `:nasdaqlisted.txt;

// q)nasdaqlisted:`symbol`securityName`marketCategory`isTestIssue`lotSize`isETF xcol("sssbjb";enlist"|")0: `:nasdaqlisted.txt
// q)meta nasdaqlisted
// c             | t f a
// --------------| -----
// symbol        | s    
// securityName  | s    
// marketCategory| s    
// isTestIssue   | b    
// lotSize       | j    
// isETF         | b

//Missed that there were fields we didn't want
// so actual sol is:
nasdaqlisted:`symbol`securityName`marketCategory`isTestIssue`lotSize`isETF xcol("sssb jb ";enlist"|")0: `:nasdaqlisted.txt;
// spaces for fields we're ignoring
// did not know you could do that