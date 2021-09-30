FROM jcxldn/mono:latest

RUN wget https://github.com/Pryaxis/TShock/releases/download/v4.5.4/TShock4.5.4_Terraria1.4.2.3.zip -O TShock.zip && \
	mkdir /app && \
	unzip TShock.zip -d /app && \
	rm TShock.zip

WORKDIR /app
ENTRYPOINT ["mono", "TerrariaServer.exe", "-ip", "0.0.0.0", "-configpath", "/data", "-worldpath", "/data/worlds/", "-killinactivesocket", "--stats-optout"]