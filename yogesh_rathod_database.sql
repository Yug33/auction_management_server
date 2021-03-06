PGDMP                         w            auction    10.10     11.5 (Ubuntu 11.5-1.pgdg18.04+1)     .           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false            /           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                       false            0           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                       false            1           1262    16395    auction    DATABASE     m   CREATE DATABASE auction WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_IN' LC_CTYPE = 'en_IN';
    DROP DATABASE auction;
             auction    false                        3079    16449 
   btree_gist 	   EXTENSION     >   CREATE EXTENSION IF NOT EXISTS btree_gist WITH SCHEMA public;
    DROP EXTENSION btree_gist;
                  false            2           0    0    EXTENSION btree_gist    COMMENT     T   COMMENT ON EXTENSION btree_gist IS 'support for indexing common datatypes in GiST';
                       false    2            �            1259    16411    auction    TABLE     �   CREATE TABLE public.auction (
    auction_id integer NOT NULL,
    seller_id integer NOT NULL,
    title text,
    description text,
    initial_bid real NOT NULL,
    exp_date date,
    image_url text,
    vector tsvector
);
    DROP TABLE public.auction;
       public         admin    false            �            1259    16409    auction_auction_id_seq    SEQUENCE     �   CREATE SEQUENCE public.auction_auction_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.auction_auction_id_seq;
       public       admin    false    200            3           0    0    auction_auction_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.auction_auction_id_seq OWNED BY public.auction.auction_id;
            public       admin    false    199            �            1259    16426    bidding    TABLE     }   CREATE TABLE public.bidding (
    auction_id integer NOT NULL,
    user_id integer NOT NULL,
    bid_amount real NOT NULL
);
    DROP TABLE public.bidding;
       public         admin    false            �            1259    16398    user    TABLE     �   CREATE TABLE public."user" (
    user_id integer NOT NULL,
    email text NOT NULL,
    passroword text NOT NULL,
    jwt_token text,
    "Name" text
);
    DROP TABLE public."user";
       public         admin    false            �            1259    16396    user_user_id_seq    SEQUENCE     �   CREATE SEQUENCE public.user_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.user_user_id_seq;
       public       admin    false    198            4           0    0    user_user_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.user_user_id_seq OWNED BY public."user".user_id;
            public       admin    false    197            �           2604    16414    auction auction_id    DEFAULT     x   ALTER TABLE ONLY public.auction ALTER COLUMN auction_id SET DEFAULT nextval('public.auction_auction_id_seq'::regclass);
 A   ALTER TABLE public.auction ALTER COLUMN auction_id DROP DEFAULT;
       public       admin    false    199    200    200            �           2604    16401    user user_id    DEFAULT     n   ALTER TABLE ONLY public."user" ALTER COLUMN user_id SET DEFAULT nextval('public.user_user_id_seq'::regclass);
 =   ALTER TABLE public."user" ALTER COLUMN user_id DROP DEFAULT;
       public       admin    false    198    197    198            *          0    16411    auction 
   TABLE DATA               v   COPY public.auction (auction_id, seller_id, title, description, initial_bid, exp_date, image_url, vector) FROM stdin;
    public       admin    false    200   #       +          0    16426    bidding 
   TABLE DATA               B   COPY public.bidding (auction_id, user_id, bid_amount) FROM stdin;
    public       admin    false    201   �       (          0    16398    user 
   TABLE DATA               O   COPY public."user" (user_id, email, passroword, jwt_token, "Name") FROM stdin;
    public       admin    false    198   �       5           0    0    auction_auction_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.auction_auction_id_seq', 7, true);
            public       admin    false    199            6           0    0    user_user_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.user_user_id_seq', 1, false);
            public       admin    false    197            �           2606    16419    auction auction_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.auction
    ADD CONSTRAINT auction_pkey PRIMARY KEY (auction_id);
 >   ALTER TABLE ONLY public.auction DROP CONSTRAINT auction_pkey;
       public         admin    false    200            �           2606    16408 
   user email 
   CONSTRAINT     H   ALTER TABLE ONLY public."user"
    ADD CONSTRAINT email UNIQUE (email);
 6   ALTER TABLE ONLY public."user" DROP CONSTRAINT email;
       public         admin    false    198            �           2606    16406    user user_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (user_id);
 :   ALTER TABLE ONLY public."user" DROP CONSTRAINT user_pkey;
       public         admin    false    198            �           1259    16425    fki_referUserId    INDEX     J   CREATE INDEX "fki_referUserId" ON public.auction USING btree (seller_id);
 %   DROP INDEX public."fki_referUserId";
       public         admin    false    200            �           1259    16442    fki_toTheUser    INDEX     I   CREATE INDEX "fki_toTheUser" ON public.bidding USING btree (auction_id);
 #   DROP INDEX public."fki_toTheUser";
       public         admin    false    201            �           1259    16448 	   fki_toUsr    INDEX     B   CREATE INDEX "fki_toUsr" ON public.bidding USING btree (user_id);
    DROP INDEX public."fki_toUsr";
       public         admin    false    201            �           2606    16420    auction referUserId    FK CONSTRAINT     �   ALTER TABLE ONLY public.auction
    ADD CONSTRAINT "referUserId" FOREIGN KEY (seller_id) REFERENCES public."user"(user_id) ON UPDATE CASCADE ON DELETE CASCADE;
 ?   ALTER TABLE ONLY public.auction DROP CONSTRAINT "referUserId";
       public       admin    false    198    200    2981            �           2606    16437    bidding toTheUser    FK CONSTRAINT     �   ALTER TABLE ONLY public.bidding
    ADD CONSTRAINT "toTheUser" FOREIGN KEY (auction_id) REFERENCES public.auction(auction_id) ON UPDATE CASCADE ON DELETE CASCADE;
 =   ALTER TABLE ONLY public.bidding DROP CONSTRAINT "toTheUser";
       public       admin    false    201    2983    200            �           2606    16443    bidding toUsr    FK CONSTRAINT     �   ALTER TABLE ONLY public.bidding
    ADD CONSTRAINT "toUsr" FOREIGN KEY (user_id) REFERENCES public."user"(user_id) ON UPDATE CASCADE ON DELETE CASCADE;
 9   ALTER TABLE ONLY public.bidding DROP CONSTRAINT "toUsr";
       public       admin    false    2981    201    198            *   a   x�-�A
� ��_Zj������FOL/�}�-l����AV�t��| �-3Ћr�t`4�i��jh�wml����њY�W�]��ʴ�_��      +      x������ � �      (   9   x�3�,J,��OqH�M���K�ύ��44261�4,OM+NIL��OO-������� ��#     