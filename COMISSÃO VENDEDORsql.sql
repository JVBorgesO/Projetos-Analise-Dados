WITH COMISSAO AS (
SELECT 
	c.CODVEND,
	v.APELIDO,
	i.CODPROD,
	p.DESCRPROD,
	SUM((i.VLRTOT - i.VLRDESC)*t.GOLDEV)FATURAMENTO
FROM 
	TGFCAB c
	INNER JOIN TGFTOP t ON t.CODTIPOPER = c.CODTIPOPER
	INNER JOIN TGFITE i ON i.NUNOTA = c.NUNOTA
	INNER JOIN TGFPRO p ON p.CODPROD = i.CODPROD
	INNER JOIN TGFVEN v ON v.CODVEND = c.CODVEND
WHERE
	t.DHALTER = c.DHTIPOPER
	AND (t.GOLSINAL = -1)
	AND c.TIPMOV IN ('V','D')
	AND c.DTFATUR BETWEEN '2024-10-' AND '2024-10-31 23:59:59'
	AND c.CODVEND = 597
GROUP BY
	c.CODVEND,
	v.APELIDO,
	i.CODPROD,
	p.DESCRPROD
)
SELECT 
	com.*,
	(FATURAMENTO * 0.03)COMISS�O
FROM 
	COMISSAO com
