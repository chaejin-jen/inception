FROM alpine:3.17
RUN apk update && apk upgrade\
    && apk add --no-cache nginx openssl

# setup SSL
RUN set -eux; \
	openssl genrsa -out chaejkim.42.fr.key 4096; \
	openssl req -x509 -nodes -days 365 \
	-key chaejkim.42.fr.key \
	-out chaejkim.42.fr.crt \
	-subj "/C=KR/ST=SEOUL/L=Gaepo-dong/O=42/OU=Seoul/CN=chaejkim"; \
	chmod 644 chaejkim.42.fr.*; \
    mv chaejkim.42.fr.crt /etc/ssl/certs/;	\
	mv chaejkim.42.fr.key /etc/ssl/private/

# COPY ./conf/nginx.conf /etc/nginx/conf.d/nginx.conf
COPY ./conf/default.conf /etc/nginx/http.d/default.conf

EXPOSE 443
CMD ["nginx", "-g", "daemon off;"]
