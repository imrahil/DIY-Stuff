//Max Value Screen (This shows the Max LD, RPM or AGT or Oil values)
void Screen8Init()
{
   lcd.init();
   
  lcd.commandWrite(0x80);                  //Line1
  lcd.printIn("Max ");
  lcd.commandWrite(0xC0);                  //Line=2
  lcd.printIn("LD:       RPM:");
  lcd.commandWrite(0x94);                  //Line=3
  lcd.printIn("LMM:      AGT:");
  lcd.commandWrite(0xD4);                  //Line=4
  lcd.printIn("V: ");

  RefResh = 2;
  val = 2;  
  
  //Selects the first MAX Screen
  val1 = 1;
  
  //Lets to the Conversion:
  DoCal = 1;
  
  //Fetch Typ K
  DoTypK = 1;

  //Select Serial Out Mode "Converted":
  if(SerOut!=2)
  {
    SerOut = 2;
    //print the Serial Header:
    HeaderPrint();
  }

}

void Screen8Work()
{ 
   
  //like screen2 it only updates every X repeatÂ´s
  
    if(val>=RefResh)
  {
     val = 0;
	
	//Header:
	lcd.commandWrite(0x80+4);                  //Line
	//lcd.printIn(itoa(val1, buf, 10));
        
        //But nice so it can be understand
        switch(val1){
          case 0:
            lcd.printIn("AGT  ");
            break;
          case 1:
            lcd.printIn("BOOST");
            break;
          case 2:
            lcd.printIn("RPM  ");
            break;
        }
            

    lcd.commandWrite(0xC0+3);                  //Max1LD
    
      if(MaxLDE[val1]<0.0)
      {
        lcd.printIn("-");
      }
      else
      {
        lcd.printIn(" ");
      } 
      printfloat(abs(MaxLDE[val1]),2);              //Shows current Boost
  
    
    lcd.commandWrite(0xC0+14);                 //Max1RPM
    lcd.printIn(itoa(MaxRPME[val1], buf, 10));
    Print2Blanks();
    lcd.commandWrite(0x94+4);                  //LMM
    lcd.printIn(itoa((MaxLMME[val1]), buf, 10));
    Print2Blanks();
    lcd.commandWrite(0x94+14);                 //Max1AGTVal
    lcd.printIn(itoa(MaxAGTValE[val1], buf, 10));
    Print2Blanks();
    
    
    //Show the current Supply Voltage: (nice to see...)
    lcd.commandWrite(0xD4+5);                  //Line=4
    printfloat(BatVolt,2);
    lcd.printIn(" V   ");
    
  }
  else
  {
    val++;
  }
  
  
}


