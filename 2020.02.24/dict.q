d:`firstName`lastName!`Tom`Jerry;

//answer

d:d,(enlist `age)!enlist 34;

// straightforward?

// So yeah that works as a solution. Literally the first thing I tried, but answer in doc is infomative

// if you try d[`age]:37 you'll get a type error
// I knew that, but I didn't know why, just had experienced it before
// it's because the existing dictionary is uniform in type
// can't just introduce a new type, have to define dict as mixed list

// what I did was essentially just creating a new dict and joining on
// can also use q-sql approach and use update like it's a table, didn't know that
// update age:37,zipcode:10583,address:"231 Park Ave" from d
// so long as you make it mixed list in the process

// what I don't understand is why? why is a dictionary of uniform type?
// Until you join another dictionary on, and then it's not?
// This still hasn't been explained
// Is it a feature of the language? Or a limitation at a lower level?
// Might be a good one for q-questions, if they consider lower-level questions relevant