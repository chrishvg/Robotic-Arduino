//Código del robot con 3 sensores ultrasonido controlaba que fuera donde
//consiguiera el obstáculo
//Tarjeta Pingüino

#define PIC18F4550    // Habilita el uso de los pines: 18 en adelante
#define pingd 5
#define pingc 6
#define pingi 7

#define ou1 24
#define ou2 8
#define ou3 3
#define ou4 2

//recomendado 700
#define lim_ultrasonido 300

void pulso(unsigned char pin){
	pinMode(pin,OUTPUT);
	digitalwrite(pin,LOW);
	delay(2);
	digitalwrite(pin,HIGH);
	delay(5);
	digitalwrite(pin,LOW);
}
unsigned int duracion(unsigned char pin,unsigned int limite){
	unsigned int amplitud = 0;
	pinMode(pin,INPUT);
	//espera flanco de subida por el pin echo
	while(digitalread(pin) == LOW){
		amplitud++;
		if(amplitud>64)
			break;
	}
	amplitud = 0;
	//comienza a contar centimetros hasta que pin echo sea cero
	while(digitalread(pin) == HIGH){
	  amplitud++;
	  if (amplitud >= limite)
		return 0;
	}
	return amplitud;
}
void resetear()
{
	digitalWrite(ou1,LOW);
	digitalWrite(ou2,LOW);
	digitalWrite(ou3,LOW);
	digitalWrite(ou4,LOW);
}

void derecha(){
	digitalWrite(ou1,HIGH);
	digitalWrite(ou2,LOW);
	digitalWrite(ou3,HIGH);
	digitalWrite(ou4,LOW);
}

void izquierda(){
	digitalWrite(ou1,HIGH);
	digitalWrite(ou2,HIGH);
	digitalWrite(ou3,HIGH);
	digitalWrite(ou4,HIGH);
}

void retro(){
	digitalWrite(ou1,HIGH);
	digitalWrite(ou2,LOW);
	digitalWrite(ou3,HIGH);
	digitalWrite(ou4,HIGH);
}

void delante(){
	digitalWrite(ou1,HIGH);
	digitalWrite(ou2,HIGH);
	digitalWrite(ou3,HIGH);
	digitalWrite(ou4,LOW);
}

void setup()
{
pinMode(ou1,OUTPUT);
pinMode(ou2,OUTPUT);
pinMode(ou3,OUTPUT);
pinMode(ou4,OUTPUT);
}

unsigned int dur; //duracion

void loop()
{
resetear();
do{
	pulso(pingc);
  	dur = duracion(pingc,lim_ultrasonido);
	if (dur != 0){
	delante();}
}while(dur != 0);
do{
	pulso(pingd);
  	dur = duracion(pingd,lim_ultrasonido);
  	if (dur != 0){
		izquierda();}
}while(dur != 0);
do{
	pulso(pingi);
  	dur = duracion(pingi,lim_ultrasonido);
  	if (dur != 0){
		derecha();}
}while(dur != 0);
}
