;******VJEZBA3*******
    
    list p=16f1939
    #include<p16f1939.inc>
    
    __CONFIG _CONFIG1, _FOSC_HS& _WDTE_OFF& _PWRTE_OFF&_MCLRE_ON& _CP_OFF&_CPD_OFF& _BOREN_OFF& _CLKOUTEN_OFF& _IESO_OFF& _FCMEN_OFF
    __CONFIG _CONFIG2, _WRT_OFF& _VCAPEN_OFF& _PLLEN_OFF &_STVREN_OFF &_LVP_OFF
    
    
;****** deklaracija promjenjiv ******
brojacA equ 0x70;
brojacB equ 0x71;
brojacC equ 0x72;
brojacD equ 0x73

    
;****** Struktura programse memorije ****
    ORG 0x00;
    goto Program;
    ORG 0x04;
    goto Program
    

;******    Program    ******
Program
    bsf BSR,BSR0; BSR=00000001
    movlw 0x00;
    movwf TRISD;
    bcf BSR,BSR0; BSR=00000000
    bsf BSR,BSR1; BSR=00000010
    
    bcf LATD,0;
    
    ;2-1-1-2-1
Petlja
    bsf LATD,0;
    call milisec
    call milisec
    
    bcf LATD,0;
    call milisec
    
    bsf LATD,0;
    call milisec
    
    bcf LATD,0;
    call milisec
    call milisec
    
    bsf LATD,0;
    call milisec
    
    bcf LATD,0;
    call milisec;
    
    goto Petlja
    
    
    
;******   Podprogrami   *****
    ;2000 treba da traje
milisec
    movlw d'54';
    movwf brojacA;
    
L1
    movlw d'11';
    movwf brojacB;

L2 
    
    decfsz brojacB,1;
    goto L2
    
    decfsz brojacA,1;
    goto L1;
    return;
  
    
    
    
    
    end