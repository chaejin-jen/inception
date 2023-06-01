FROM alpine:3.17

RUN apk update \
    && apk add --no-cache nginx openssl \
    && rm -rf /var/cache/apk/*

# setup SSL
RUN openssl genrsa -out chaejkim.42.fr.key 4096; \
	openssl req -x509 -nodes -days 365 \
	-key chaejkim.42.fr.key \
	-out chaejkim.42.fr.crt \
	-subj "/C=KR/ST=SEOUL/L=Gaepo-dong/O=42/OU=Seoul/CN=chaejkim"; \
	chmod 644 chaejkim.42.fr.*; \
	# mv chaejkim.42.fr.crt /etc/nginx/certificate/;	\
	# mv chaejkim.42.fr.key /etc/nginx/certificate/
    mv chaejkim.42.fr.crt /etc/ssl/certs/;	\
	mv chaejkim.42.fr.key /etc/ssl/private/


# openssl dhparam -out dhparam.pem 4096; \
# mv dhparam.pem /etc/ssl/certs/; \
# cp /nginx-sites-available-default.conf /etc/nginx/sites-available/default

COPY ./conf/default.conf /etc/nginx/http.d/default.conf

# COPY ../tools/ /etc/nginx/ssl
# COPY index.html /usr/share/nginx/html
# COPY linux.png /usr/share/nginx/html

CMD ["nginx", "-g", "daemon off;"]

EXPOSE 443 	
