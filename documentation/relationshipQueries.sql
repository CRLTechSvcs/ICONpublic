SELECT * FROM bib_relationships WHERE relationship_from = 'sn97066018';
SELECT * FROM bib_relationships WHERE relationship_from <> 'sn2005058508';


SELECT relationship_from, COUNT(*) AS numRelationships 
	FROM bib_relationships 
	GROUP BY relationship_from 
	ORDER BY numRelationships DESC;