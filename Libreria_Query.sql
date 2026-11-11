USE Libreria;
SHOW TABLES;

SELECT * FROM libro;

SELECT * FROM autori;

SELECT * FROM genere;

SELECT * FROM copia;

INSERT INTO copia
(id_libro, casa_editrice, numero_copie)
VALUES
(1, 'Salani', 5),
(2, 'Mondadori', 3),
(3, 'Sperling & Kupfer', 4),
(4, 'Einaudi', 2),
(5, 'Mondadori', 3),
(6, 'Bompiani', 5),
(7, 'Mondadori', 4),
(8, 'Mondadori', 2);

SELECT * FROM copia;

SELECT * FROM libro_autori;

SELECT
	libro.titolo,
    autori.nome,
    autori.cognome
FROM libro 
INNER JOIN libro_autori 
	ON libro.id = libro_autori.id_libro
INNER JOIN autori
	ON libro_autori.id_autore = autori.id;

-- IMPORTANTE INFO SULLE ABBREVIAZIONI (ALIAS):
-- ALIAS: abbreviazioni dei nomi delle tabelle
-- l = libro
-- la = libro_autori
-- Servono per richiamare le tabelle più velocemente
-- senza dover scrivere ogni volta il loro nome completo.

-- VERIFICA DATI:
-- PER NON AVERE PROBLEMI CON DUPLICAZIONI DATI, 
-- DATI CHE NON CORRISPONDO, ECC. VERIFICO CON QUESTI COMANDI:

SELECT COUNT(*) AS totale_registrazioni
FROM copia;

SELECT 
	id_libro,
    COUNT(*) AS numero_registrazioni
FROM copia
GROUP BY id_libro;

SELECT
	libro.titolo,
    genere.nome,
    copia.casa_editrice,
	copia.numero_copie
FROM libro
INNER JOIN genere
	ON libro.id_genere = genere.id
LEFT JOIN copia
	ON libro.id = copia.id_libro;
    
SELECT
	genere.nome,
    COUNT(libro.id) AS totale_libri
FROM genere
LEFT JOIN libro
	ON genere.id = libro.id_genere
GROUP BY genere.nome;

SELECT
	nome
FROM genere
ORDER BY nome DESC;

SELECT 
	titolo,
    anno
FROM libro
ORDER BY anno DESC; 

-- VARI ESERCIZI CON MYSQL:
-- Esercizio 1 – Autori ordinati per cognome e poi per nome
-- N.B.: Il mio Database non ha due autori con lo stesso cognome,
-- quindi non serve il nome ASC, ma lo inserisco per rispettare l'esercizio.

SELECT
	nome,
    cognome
FROM autori
ORDER BY cognome ASC, nome ASC;

-- ESERCIZIO 2
-- Obiettivo: mostrare titolo e anno dei libri
-- pubblicati dopo il 2000.
-- WHERE serve a filtrare le righe in base a una condizione.

SELECT
	titolo,
    anno
FROM libro
WHERE anno > 2000;

-- ESERCIZIO 3
-- Obiettivo: trovare gli autori di nazionalità italiana.
-- WHERE seleziona soltanto le righe che soddisfano la condizione.

SELECT
	nome, 
    cognome,
    nazionalita
FROM autori
WHERE nazionalita = 'Italiana';

-- ESERCIZIO 4
-- Obiettivo: trovare i libri il cui titolo contiene la parola "Harry".
-- LIKE permette di cercare un testo attraverso uno schema.
-- Il simbolo % rappresenta qualsiasi sequenza di caratteri.

SELECT
	titolo
FROM libro
WHERE titolo LIKE '%Harry%';

-- ESERCIZIO 5
-- Obiettivo: elencare tutte le case editrici senza duplicati.
-- DISTINCT mostra ogni valore una sola volta.

SELECT DISTINCT 
	casa_editrice
FROM copia;

-- ESERCIZIO 6
-- Obiettivo: mostrare i 5 libri più recenti.
-- ORDER BY anno DESC ordina dal più recente al meno recente.
-- LIMIT 5 mostra soltanto i primi cinque risultati.

SELECT
	titolo,
    anno
FROM libro 
ORDER BY anno DESC
LIMIT 5; 

-- ESERCIZIO 7
-- Obiettivo: mostrare ogni libro con il nome del suo genere.
-- INNER JOIN collega le due tabelle attraverso le rispettive chiavi.

SELECT
	libro.titolo,
    genere.nome
FROM libro
INNER JOIN genere
	ON libro.id_genere = genere.id;
    
-- ESERCIZIO 8
-- Obiettivo: mostrare ogni libro con nome e cognome dei suoi autori.
-- libro_autori è la tabella ponte tra libri e autori.
-- I due INNER JOIN permettono di attraversare entrambi i collegamenti.

SELECT
	libro.titolo,
    autori.nome,
    autori.cognome
FROM libro
INNER JOIN libro_autori
	ON libro.id = libro_autori.id_libro
INNER JOIN autori
	ON libro_autori.id_autore = autori.id;
    
-- ESERCIZIO 9
-- Obiettivo: trovare tutti i libri scritti da un autore
-- dato il suo cognome.
-- WHERE filtra l'autore cercato.
-- I due INNER JOIN collegano autori e libri tramite la tabella ponte.

SELECT
	libro.titolo,
    autori.nome,
    autori.cognome
FROM autori
INNER JOIN libro_autori
	ON autori.id = libro_autori.id_autore
INNER JOIN libro
	ON libro_autori.id_libro = libro.id
WHERE autori.cognome = 'King';

-- ESERCIZIO 10
-- Obiettivo: trovare i libri di genere Fantasy
-- che hanno almeno una copia disponibile.
-- INNER JOIN collega libro, genere e copia.
-- WHERE seleziona Fantasy e almeno una copia.

SELECT
	libro.titolo,
    genere.nome,
    copia.casa_editrice,
    copia.numero_copie
FROM libro
INNER JOIN genere
	ON libro.id_genere = genere.id
INNER JOIN copia
    ON libro.id = copia.id_libro
WHERE genere.nome = 'Fantasy'
	AND copia.numero_copie >= 1;
    
-- ESERCIZIO 11
-- Obiettivo: mostrare gli autori che hanno scritto
-- almeno un libro di un determinato genere, senza duplicati.
-- DISTINCT evita che lo stesso autore compaia più volte.
-- I JOIN collegano autori, libri e generi.

SELECT DISTINCT 
    autori.nome,
    autori.cognome
FROM autori
INNER JOIN libro_autori
    ON autori.id = libro_autori.id_autore
INNER JOIN libro
    ON libro_autori.id_libro = libro.id
INNER JOIN genere
    ON libro.id_genere = genere.id
WHERE genere.nome = 'Fantasy';

SHOW CREATE TABLE libro;

SELECT
    TABLE_NAME,
    COLUMN_NAME,
    REFERENCED_TABLE_NAME,
    REFERENCED_COLUMN_NAME
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = 'libreria'
AND REFERENCED_TABLE_NAME IS NOT NULL;

SELECT SCHEMA_NAME
FROM INFORMATION_SCHEMA.SCHEMATA
WHERE SCHEMA_NAME = 'Libreria';