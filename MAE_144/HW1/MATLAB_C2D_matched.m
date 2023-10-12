numCT = [1 1];
denCT = [1, 10, 0];
Ts = 0.01;
method = 'matched';

sysCT = tf(numCT, denCT);

sysDT = c2d(sysCT, Ts, method);

[numDT, denDT] = tfdata(sysDT, 'v')

