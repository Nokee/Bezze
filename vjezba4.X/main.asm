;******VJEZBA4*******
    
    list p=16f1939
    #include<p16f1939.inc>
    
    __CONFIG _CONFIG1, _FOSC_HS& _WDTE_OFF& _PWRTE_OFF&_MCLRE_ON& _CP_OFF&_CPD_OFF& _BOREN_OFF& _CLKOUTEN_OFF& _IESO_OFF& _FCMEN_OFF
    __CONFIG _CONFIG2, _WRT_OFF& _VCAPEN_OFF& _PLLEN_OFF &_STVREN_OFF &_LVP_OFF
    
;pomocna varijabla
pomocna equ 0x70;
    
;struktuta programske memorije
    ORG 0x00;
    goto program;
    ORG 0x04;
    goto program;
    
  
    
;Glavni dio program
program
    ;RD0 RD1 su ulazni pinovi
    banksel TRISD; BANK1
    movlw 0x03;
    movwf TRISD;
    ;PORTB su izlazni pinovi za diode
    movlw 0x00;
    movwf TRISB;
    ;RC7, RC3 je izlazni pin
    movlw 0x00;
    movwf TRISC;
    ;signal sa TTL je od 0,01 do 1kHz tako da period uzorkovanja 
    ;<1 ms
    
    banksel LATB; Banka 2
    bsf LATD,0x03;
    movlw 0x00;
    movwf LATB; brojac=0

petlja
    
    call broji ;

    
    goto petlja
    
    
    
broji
    banksel PORTD;
    btfss PORTD,0x00; if RD0!=0
    goto broji1;TODO
    btfsc PORTD,0x02; if RD3=0
    goto broji2;
    call brojac
    banksel LATD;
    bsf LATD, 0x02  ;RD3=1
broji2
    return
broji1
    banksel LATD;
    bcf PORTD, 0x02  ;RD3=0
    goto broji2
    
brojac
    call if135or0
    banksel PORTD;
    movf PORTD,0;
    banksel LATB;
    movwf pomocna
    btfss pomocna,0x01; if RD1!=1
    incf LATB; brojac++
    btfsc pomocna,0x01; if	RD2!=0
    decf LATB; brojac--
    return
    
if135or0
    banksel LATB;
    movlw b'01111000'; if 135=brojac
    xorwf LATB,0;
    movwf pomocna;
    incfsz pomocna;
    goto if0
    
    movlw 0x00;
    movwf LATB; brojac=0
    
if0
    movlw b'11111111';if 0=brojac
    xorwf LATB,0;
    movwf pomocna;
    incfsz pomocna;
    goto fi
    
    movlw 0x80;
    movwf LATB; brojac=135    
fi
    movlw 0x80
    movwf LATC;
    movlw 0x00
    movwf LATC;
    
    return
    
    END