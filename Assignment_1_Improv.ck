/////////////////////////////////////////////////////
// My first project
// Date: 24/10/2013
// Name: Assignment_1_Improv
// Solo in high and low pitch in C Major
///////////////////////////////////////////////////

//sound network
SinOsc k => dac; //playing key of the chord
SinOsc t => dac; // plays the third
SinOsc f => dac; // plays the fifth
SqrOsc sq => dac; // plays high pitch
TriOsc tr => dac; // plays low pitch

// file name
<<< "Assignment_1_Improv" >>>;

// intialize array with frequencies from C major key
[ 261.6, 293.7, 329.6, 392.0, 440.0] @=> float key[];

// establishing duration
24::second => dur half;
half + now => time stop;

// Establishing a counter
0 => int round;
0 => int solo;


//creating loop for the piece
while(now < stop)
{
    //turning volume of osc down for high pitch solo
    if ((round%4==0) && (solo == 0))
    {
        0 => k.gain;
        0 => t.gain;
        0 => f.gain;
        0.1 => sq.gain;
        0 => tr.gain; 
        solo++; 
    }
    
    //second time around the volume solo 
    //of low and high pitch 
    else if ((round%4==0) && (solo == 1))
    {
        0 => k.gain;
        0 => t.gain;
        0 => f.gain;
        0.1 => sq.gain;
        0.3 => tr.gain; 
        
    }
    
    //turning volume of osc down for low pitch solo
    else if (round%4==2)
    {
        //Volume of osc
        0 => k.gain;
        0 => t.gain;
        0 => f.gain;
        0 => sq.gain;
        0.3 => tr.gain;  
    }
    
    // volume of osc for main part
    else
    {
        //Volume of osc
        0.2 => k.gain;
        0.2 => t.gain;
        0.2 => f.gain;
        0.1 => sq.gain;
        0.3 => tr.gain;
    }
    
    // First chord repeat at random time
    for (0 => int i; i < 8; i++)
    {
        // C chord
        261.6 => k.freq; // C
        329.6 => t.freq; // E
        392.0 => f.freq; // G
        // Random frequency for low pitch (triangle wave), chosen from array with pentatonic scale
        key[Math.random2(0,4)]/4 => tr.freq;
        // Random improvisation of the square wave, chosen from array with pentatonic scale
        // created a variable "p" to allow the frequency to be an octave higher
        Math.random2(1,2) => int p;
        // every solo of high pitch make the frequency an octave higher
        if (round%4==0)
        {
            p*2=> p;
        }    
        p*key[Math.random2(0,4)]=> sq.freq;
        // Random time
        p * 0.1::second => now;
        
    }
    
    // Second chord repeat at random time
    for (0 => int i; i < 8; i++)
    {
        // F Chord
        349.2*4 => k.freq; // F
        440.0 => t.freq; // A
        261.6 => f.freq; // C
        // Random frequency for low pitch (triangle wave), chosen from array with pentatonic scale
        // created a variable q to allow the note to be an octave higher
        Math.random2(1,2) => int q;
        // Divided the frequency from the array by four to have a very low pitch sound 
        q*key[Math.random2(0,4)]/4 => tr.freq;
        // Random improvisation of the square wave, chosen from array with pentatonic scale
        // created a variable "p" to allow the frequency to be an octave higher
        Math.random2(1,2) => int p;
        p*key[Math.random2(0,4)]=> sq.freq;
        p* 0.1::second => now;
    }
    
    // Third chord repeat at random time
    for (0 => int i; i < 8; i++)
    {
        // G Chord
        392.0 => k.freq; // G
        493.9 => t.freq; // B
        370.0 => f.freq; // D
        // Random frequency for low pitch (triangle wave), chosen from array with pentatonic scale
        // Divided the frequency from the array by four to have a very low pitch sound 
        key[Math.random2(0,4)]/4 => tr.freq;
        // Improvisation of the square wave, chosen from array with pentatonic scale
        // created a variable "a" to allow the frequency to be an octave higher
        Math.random2(1,2) => int p;
        // every solo of high pitch make the frequency an octave higher
        if (round%4==0)
        {
            p*2=> p;
        }
        p*key[Math.random2(0,4)]=> sq.freq;
        p* 0.1::second => now;
    }
    
    // Repeat first chord for 13 times at random time
    for (0 => int i; i < 6; i++)
    {
        // Final C Chord
        261.6*2 => k.freq;
        329.6 => t.freq;
        392.0 => f.freq;
        // Random frequency for low pitch (triangle wave), chosen from array with pentatonic scale
        // created a variable q to allow the note to be an octave higher
        Math.random2(1,2) => int q;
        Math.pow(2,q) $ int =>  q;
        // Divided the frequency from the array by four to have a very low pitch sound      
        q*key[Math.random2(0,4)]/4 => tr.freq;
        // Random improvisation of the square wave, chosen from array with pentatonic scale
        // created a variable p to allow the frequency to be an octave higher
        Math.random2(1,2) => int p;  
        p*key[Math.random2(0,4)]=> sq.freq;
        p*0.1::second => now;
    }
    
    // Final C chord with solos also in C for clousure purpose
    // Doubled the frequency of first note of the chord
    261.6*2 => k.freq;
    329.6 => t.freq;
    392.0 => f.freq;
    // triangle frequency in C
    key[0]/4 => tr.freq;
    // Square frequency in C
    key[0]=> sq.freq;
    // Hard coded time to really set the ending
    0.5::second => now;
    
    // Increase counter by one, for the solo purpose
    round++;
    
    
}

//Volume of osc
0.2 => k.gain;
0.2 => t.gain;
0.2 => f.gain;
0.1 => sq.gain;
0.3 => tr.gain;

// Final C chord with solos also in C for clousure purpose
// Doubled the frequency of first note of the chord
261.6*2 => k.freq;
329.6 => t.freq;
392.0 => f.freq;
// triangle frequency in C
key[0]/4 => tr.freq;
// Square frequency in C
key[0]=> sq.freq;
// Hard coded time to really set the ending
1::second => now;
