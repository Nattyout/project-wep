PGDMP  4                	    |            project    16.4    16.4 0    ,           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            -           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            .           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            /           1262    16450    project    DATABASE     �   CREATE DATABASE project WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = icu LOCALE = 'Thai_Thailand.874' ICU_LOCALE = 'th-TH';
    DROP DATABASE project;
                postgres    false            �            1259    16600    subject    TABLE     �   CREATE TABLE public.subject (
    id integer NOT NULL,
    subject character varying(100) NOT NULL,
    credit integer NOT NULL
);
    DROP TABLE public.subject;
       public         heap    postgres    false            �            1259    16599    subject_id_seq    SEQUENCE     �   CREATE SEQUENCE public.subject_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.subject_id_seq;
       public          postgres    false    220            0           0    0    subject_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.subject_id_seq OWNED BY public.subject.id;
          public          postgres    false    219            �            1259    16463 
   curriculum    TABLE     5  CREATE TABLE public.curriculum (
    id integer DEFAULT nextval('public.subject_id_seq'::regclass) NOT NULL,
    curr_name_th character varying(50) NOT NULL,
    curr_name_en character varying(50) NOT NULL,
    short_name_th character varying(50) NOT NULL,
    short_name_en character varying(50) NOT NULL
);
    DROP TABLE public.curriculum;
       public         heap    postgres    false    219            �            1259    16458    prefix    TABLE     �   CREATE TABLE public.prefix (
    id integer DEFAULT nextval('public.subject_id_seq'::regclass) NOT NULL,
    prefix character varying(25) NOT NULL
);
    DROP TABLE public.prefix;
       public         heap    postgres    false    219            �            1259    16481    section    TABLE     �   CREATE TABLE public.section (
    id integer DEFAULT nextval('public.subject_id_seq'::regclass) NOT NULL,
    section character varying(25) NOT NULL
);
    DROP TABLE public.section;
       public         heap    postgres    false    219            �            1259    16451    student    TABLE     W  CREATE TABLE public.student (
    id integer DEFAULT nextval('public.subject_id_seq'::regclass) NOT NULL,
    prefix_id integer NOT NULL,
    first_name character varying(40) NOT NULL,
    last_name character varying(40) NOT NULL,
    date_of_birth date NOT NULL,
    sex character(1) NOT NULL,
    curriculum_id integer NOT NULL,
    previous_school character varying(100) NOT NULL,
    address character varying(500) NOT NULL,
    telephone character varying(20) NOT NULL,
    email character varying(75),
    line_id character varying(50),
    status character(1) DEFAULT 'S'::bpchar NOT NULL
);
    DROP TABLE public.student;
       public         heap    postgres    false    219            �            1259    16739    student_list    TABLE     �   CREATE TABLE public.student_list (
    id integer NOT NULL,
    subject_id integer NOT NULL,
    student_id integer NOT NULL,
    active_date timestamp without time zone NOT NULL,
    status character(2) DEFAULT 'P'::bpchar NOT NULL
);
     DROP TABLE public.student_list;
       public         heap    postgres    false            �            1259    16738    student_list_id_seq    SEQUENCE     �   CREATE SEQUENCE public.student_list_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.student_list_id_seq;
       public          postgres    false    222            1           0    0    student_list_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.student_list_id_seq OWNED BY public.student_list.id;
          public          postgres    false    221            �            1259    16761    student_subject    TABLE     �   CREATE TABLE public.student_subject (
    number integer NOT NULL,
    student_id integer NOT NULL,
    subject_id integer NOT NULL,
    section_id integer
);
 #   DROP TABLE public.student_subject;
       public         heap    postgres    false            �            1259    24797    users    TABLE     �   CREATE TABLE public.users (
    id integer NOT NULL,
    username character varying(50) NOT NULL,
    password character varying(255) NOT NULL,
    subject_id integer NOT NULL
);
    DROP TABLE public.users;
       public         heap    postgres    false            �            1259    24796    users_id_seq    SEQUENCE     �   CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.users_id_seq;
       public          postgres    false    225            2           0    0    users_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;
          public          postgres    false    224            s           2604    16603 
   subject id    DEFAULT     h   ALTER TABLE ONLY public.subject ALTER COLUMN id SET DEFAULT nextval('public.subject_id_seq'::regclass);
 9   ALTER TABLE public.subject ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    219    220    220            u           2604    24800    users id    DEFAULT     d   ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);
 7   ALTER TABLE public.users ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    225    224    225            !          0    16463 
   curriculum 
   TABLE DATA           b   COPY public.curriculum (id, curr_name_th, curr_name_en, short_name_th, short_name_en) FROM stdin;
    public          postgres    false    217   ':                  0    16458    prefix 
   TABLE DATA           ,   COPY public.prefix (id, prefix) FROM stdin;
    public          postgres    false    216   ;       "          0    16481    section 
   TABLE DATA           .   COPY public.section (id, section) FROM stdin;
    public          postgres    false    218   @;                 0    16451    student 
   TABLE DATA           �   COPY public.student (id, prefix_id, first_name, last_name, date_of_birth, sex, curriculum_id, previous_school, address, telephone, email, line_id, status) FROM stdin;
    public          postgres    false    215   n;       &          0    16739    student_list 
   TABLE DATA           W   COPY public.student_list (id, subject_id, student_id, active_date, status) FROM stdin;
    public          postgres    false    222   �H       '          0    16761    student_subject 
   TABLE DATA           U   COPY public.student_subject (number, student_id, subject_id, section_id) FROM stdin;
    public          postgres    false    223   0K       $          0    16600    subject 
   TABLE DATA           6   COPY public.subject (id, subject, credit) FROM stdin;
    public          postgres    false    220   L       )          0    24797    users 
   TABLE DATA           C   COPY public.users (id, username, password, subject_id) FROM stdin;
    public          postgres    false    225   �L       3           0    0    student_list_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.student_list_id_seq', 47, true);
          public          postgres    false    221            4           0    0    subject_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.subject_id_seq', 2243213, false);
          public          postgres    false    219            5           0    0    users_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.users_id_seq', 1, false);
          public          postgres    false    224            {           2606    16467    curriculum curriculom_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.curriculum
    ADD CONSTRAINT curriculom_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.curriculum DROP CONSTRAINT curriculom_pkey;
       public            postgres    false    217            y           2606    16462    prefix prefix_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.prefix
    ADD CONSTRAINT prefix_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.prefix DROP CONSTRAINT prefix_pkey;
       public            postgres    false    216            }           2606    16487    section section_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.section
    ADD CONSTRAINT section_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.section DROP CONSTRAINT section_pkey;
       public            postgres    false    218            �           2606    16745    student_list student_list_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.student_list
    ADD CONSTRAINT student_list_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.student_list DROP CONSTRAINT student_list_pkey;
       public            postgres    false    222            w           2606    16457    student student_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.student
    ADD CONSTRAINT student_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.student DROP CONSTRAINT student_pkey;
       public            postgres    false    215            �           2606    16765 $   student_subject student_subject_pkey 
   CONSTRAINT     ~   ALTER TABLE ONLY public.student_subject
    ADD CONSTRAINT student_subject_pkey PRIMARY KEY (number, student_id, subject_id);
 N   ALTER TABLE ONLY public.student_subject DROP CONSTRAINT student_subject_pkey;
       public            postgres    false    223    223    223                       2606    16605    subject subject_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.subject
    ADD CONSTRAINT subject_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.subject DROP CONSTRAINT subject_pkey;
       public            postgres    false    220            �           2606    24802    users users_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            postgres    false    225            �           2606    24804    users users_username_key 
   CONSTRAINT     W   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);
 B   ALTER TABLE ONLY public.users DROP CONSTRAINT users_username_key;
       public            postgres    false    225            �           2606    16473 "   student student_curriculum_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.student
    ADD CONSTRAINT student_curriculum_id_fkey FOREIGN KEY (curriculum_id) REFERENCES public.curriculum(id);
 L   ALTER TABLE ONLY public.student DROP CONSTRAINT student_curriculum_id_fkey;
       public          postgres    false    217    4731    215            �           2606    16751 )   student_list student_list_student_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.student_list
    ADD CONSTRAINT student_list_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.student(id);
 S   ALTER TABLE ONLY public.student_list DROP CONSTRAINT student_list_student_id_fkey;
       public          postgres    false    4727    215    222            �           2606    16746 )   student_list student_list_subject_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.student_list
    ADD CONSTRAINT student_list_subject_id_fkey FOREIGN KEY (subject_id) REFERENCES public.subject(id);
 S   ALTER TABLE ONLY public.student_list DROP CONSTRAINT student_list_subject_id_fkey;
       public          postgres    false    4735    220    222            �           2606    16468    student student_prefix_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.student
    ADD CONSTRAINT student_prefix_id_fkey FOREIGN KEY (prefix_id) REFERENCES public.prefix(id);
 H   ALTER TABLE ONLY public.student DROP CONSTRAINT student_prefix_id_fkey;
       public          postgres    false    4729    216    215            �           2606    24903 /   student_subject student_subject_section_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.student_subject
    ADD CONSTRAINT student_subject_section_id_fkey FOREIGN KEY (section_id) REFERENCES public.section(id);
 Y   ALTER TABLE ONLY public.student_subject DROP CONSTRAINT student_subject_section_id_fkey;
       public          postgres    false    223    4733    218            �           2606    16766 /   student_subject student_subject_student_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.student_subject
    ADD CONSTRAINT student_subject_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.student(id);
 Y   ALTER TABLE ONLY public.student_subject DROP CONSTRAINT student_subject_student_id_fkey;
       public          postgres    false    215    4727    223            �           2606    16771 /   student_subject student_subject_subject_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.student_subject
    ADD CONSTRAINT student_subject_subject_id_fkey FOREIGN KEY (subject_id) REFERENCES public.subject(id);
 Y   ALTER TABLE ONLY public.student_subject DROP CONSTRAINT student_subject_subject_id_fkey;
       public          postgres    false    223    220    4735            �           2606    24805    users users_subject_id_fkey    FK CONSTRAINT        ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_subject_id_fkey FOREIGN KEY (subject_id) REFERENCES public.subject(id);
 E   ALTER TABLE ONLY public.users DROP CONSTRAINT users_subject_id_fkey;
       public          postgres    false    4735    225    220            !   �   x����
�@�k�)���@A+k-m�85sba�bi#"AAEEa�6�(&l�i��bwf��rt�@!h��"��@��-ض�ŷĄ5��@g��e�	ɘϜ�m2/�m�3����Ȇv���,�l0�����B���8���@T~��]3j2�Y���s.�)�U�{��ہc=�4��Y�vG���兿 DK	!�,'�          )   x�3�|�c���X�eg�s#�v�3�s��qqq �V,      "      x�3�,NMV0�2�F\�`ژ+F��� d7           x��ZmO��<����f�c{��YV[m�lњ.��_n��'����ے"Aӥ�(/��/J�(j`�5��?�����;��!l 83�s�=/�s��r����hx>�OF�w���4���˫����\�zhypy0^��/F÷��%���G�c�o��7G����_���菆����>�Z}~�~,�^���Wv��#����\��~��&�U�q���Vc�l�a�Cz$|�'x��)Hv����Qe���KN���,<#e�c�������8 �/Hk�X����+� F��>�]�XNY}Y�c�J��\���@+��*���1�'���>��;�z��ՒS��ϯwE}Y��z��1W%��h1v�������?�0<��떼��u�[t�6=�荆��������P�D�9���2/8�,z
�����8�2Ƌ�#U�P97��/~UHԘHjXo�Ua����oH�M�|eyh�%W���s���;P;�i��$�-�Q�^��~�Z������ލ�����>%�v��y�2;4q�|�i��\|�5�$j��i�_����>oJOm��Ϡ+���~G���1Ky��켶G����1=�ݮ�f׭ǭn�	;1ԝG�B���\�6���ZoQD�y[`�kY%X�r	��x�o��i�G�^6ݎ��&�{jeo=Tw�1�˱c�-�D��z'4�Y�b�r��ʦ]��ѿ����)���x%�v}Ɣ�П]L�B�¾p�Dt�������g�{Y��򝑠�� ;*����d��\��Ǵ);�YTפ�%�������C��πqZ�;���uѶ��5@� �V�i��������Ӝw�O43���ZrkAƈ�:�<���'Y��v����$�C���i���["����J�[��*PSE����2؍K�䛆V��Kdp����~�����x۾�T>�:u:"ME�k��a޷"] �L�:�ǻ���
,���00�tN�km^��D��A�h���	��b;�]��q��ĉ�����8�_C3\*�oU@�W-ʣ_�����h���`���6tS��a/��cض���O��#Oq���K%�Z�Gz*�rLZ�7�p�r��r��ѽ�6xV܉l�H$�?�D�,D|E����(~����zJO��ȑީ��N7yO0-������[	�������jf�?[l6�ٹU��odJv'��?�1�ZJH�J^�@ឪ�暑8�o��W��H�u�����$��+���.�3�^nrd�i�y��p�|�����r�%��M�O)_3S4/\;a�g��0| � �^;�	Cz��4T,;(��cU#��շ�On
���Gqd������z����T`�(&�9�5������MM���}���]��n'L�j-�)�E�.�-e�	�q�=$�ж�ܚ!_�Uń�ŋ�B_T�K8l�MP[��{��$Cx[ ��V��«����-z�1L���~C��;cV(z!!dÝ=T�~�t�Os��U,��sEl�@��DdR�Ŀ��e4�&�|�/M��S(t���C���2Bc���I�#E�vf� ��Y�"��b�Z�0��@`b�<���+-/Pl����D��q/�e\�
b�n4�ƅ̳��5"��]�=��<�5g����{�A�l�Tmƛ��Aq��g�G_1��<����eK���v����PseG5��X��4C��j˩1�L
�p�7��[�-�1�_��k"j63-0�.�	-1��[UX&�E�٪]G����Loj�iS���%�5y:� &S�A�.�WeO�Lۨ�?=EE3 �85hl��#m�	��%NW�C��ej�h/;�B����L]�K��{��1�m�{��@6��7<eK�'N��I�,hj�n=����I"�"�SS�o�dq�ٜo�mԚgZf^��}zJ��8<��D�:�#�!S��9	��8a&W�e$	,��Ⱥ�6DU��F+�&�T�+ƀ�X�
��q4�*�����ڰ��@�@ݰ��~^�r�<z/��19B��}4����d����'�q�P��ޜ�}T3��s�a���3�;4FYn>n�I81HY W!��E���I�Վ�T0�A���[q�CE�|{#�Ҁ��H�U;L����i�ؼ�#��FD����q;�1U���1ܭ �)cu)��� 
&�|C$h��s�o�Gf��Q��)5=�.p�`�J�H�Ǹ�nw�E�����D���w�Gpc�/��|�\�%9UYs���Mt0�${�i��נ�R��p��f�|��B_��N3��郯�q��CԠ �n�XF�kЛ�"���Z�N�Mθ��F7r���5�3��R{�:���h���s
|u,�ø;�5� ��x�EX�&%[�>���*gC�PT�D�K\�S���{�=�˻�e�X��p�93}�(5�S�Ej��6b���:s���N�)��ِGG�E��WW�P/��Zׂ͆H��-��~�'B�=���PN��-����ɌM}g䄆�v'\@
� B`ץ�ª��Mz�,����Wy2<FB:�t��=��S��xy)PgDt�F)CE��P�h��l�뮠�l��qshL�NBs�BN8��Lq���T��G�@osC8�	�k%-�.�!pR���������)�p��/2)����zA��\E��i�[�� �EF��X��~ԽA��~=�ʡ�ʹ�sۊ"|��'\�����>�|?�2֕�V3�M���F�8�����&�=j@�f<(e_�ѺSP��S���+=���iV ǌ��D)�V��6���7��Co��Fr�s���sE�ب�R56�
<�+��|ƻ��B�A���m�}�������\�So|d�	g�����h�ANQ1���Mۡ�;��ݩy�Ny�A�g`�b�D���
�h �o��Qa�I��6�qu�Q������*�|��.�V���X�A��x���Q�C���[�IJ)�
�Eq^�5�\� �`5�n����G�j>rh���/��۾� �X�����ⷃ�?|���nkT������T�f���I���	�7^��Q���Ymd�8K��5Y����\nnv�:K�T�<��F�!QE���*�9�/�(�Bȥ|4�|� tޫ����.Q?Ww>Y��^� ����M�l,��s<ʉ�:j���N��m{e�>�Ҍ���`!�1��_��}\o;Q��9�a2V�6�U0�J�i��µ%�4�y�
�hO�0N΋1���/��Q7��ٙmnz�	:vI��ĳn�ٴa�ه,]��ޞ���?����      &   �  x�}�K�#!D��)|��@?~���`����hJ�/��"�$P~ 2 �C��	���W�=����zR�"z�U�-�OFiqZLq�aX�P�P�ʡ�B%Y�XJf%J�dVb��B%�B����q1�9t\�qs�C����q�_"�������0��tp�o��g(<urZ8Cye0�ʥ�9C��hA��Rb���\Jb�3�K)��R*"g(���M������b�s�x1�9t������e'�u6����T�d'JS, �X $@�/�0 � a �<K��9�֓L�,�3��X]�-GK�-n9��d�-G�
�r�Qj^�׸��뵥:^� ����;α�p(��5��.����K`���y�4 �T>�f�J~~�7�7C��jd�O�rG���6��//�]r�iRu=Fi">2�ё����"`m��-e�]J鉺�?C=&��>Hޮ�a�T�}2xo�}�q�6'�mN�}ۜ�8�߻h��{�ͱ��������L�vv�����"�=�h��+�x�V9�A��a�t��d'�n]���+�Z�Rء�:���V��h��D��(�%j�K�x3�%t6�T�ѥw��}<��i]��LP5ۥ�=|�����|>�aKL�      '   �   x�U���0���0Edɱ�K���w}1�&�(32�윹"ǌUlPG^@=�#o��|�Gw�F轇�Q��E/}�h�M5M7�5�rG�.O,�I}���Ӫ�O��U�%P/7P�6P��=��t���F�r#z��܈jnD77��L�܈zn���Q�T��h�h�� ��@����Fu�%E+�r#���܈nnD97��Q��c� ����      $   o   x��1�0�99�/ R�����"u`aq�#�Yz{*���)!]�C3���ti�Z	f����W��]M>�W'��f�Z�'FB�eHW��I�vZw��<��|"?      )   �   x�5�Ar�0 �59k ?ؖ����"X�n QQlǔӷ]��UU���=���8��br�%"O���)���rs�mI����8����UT��c�3V]?�=����[�^�Դ���N�o�Q�F��J�$l��ٻ6���y�7B ��|N�hś�����{g�/�.�G�g��R����֍�C���'�}8�_QA�     