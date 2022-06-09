select TO_CHAR(sum(montant), '9G999G999GL') as montant , trimestre, categorie 
from 
    vente v, produit p, temps t
where 
    v.TID = t.TID and v.PID = p.PID 
    group by trimestre, categorie   
    order by trimestre ASC , montant DESC;


select TO_CHAR(sum(montant), '9G999G999GL') as montant , trimestre, categorie 
from 
    vente v, produit p, temps t
where 
    v.TID = t.TID and v.PID = p.PID 
    group by rollup (trimestre, categorie)   
    order by trimestre ASC , montant DESC;

select TO_CHAR(sum(montant), '9G999G999GL') as montant , trimestre, categorie 
from 
    vente v, produit p, temps t
where 
    v.TID = t.TID and v.PID = p.PID 
    group by rollup (categorie ,trimestre)   
    order by trimestre ASC , montant DESC;
    

select TO_CHAR(sum(montant), '9G999G999GL') as montant ,  
 DECODE(grouping(trimestre), 1, 'TOTAL', trimestre) trimestre,
 DECODE(grouping(categorie), 1, 'TOTAL', categorie) categorie
from 
    vente v, produit p, temps t
where 
    v.TID = t.TID and v.PID = p.PID 
    group by rollup (categorie ,trimestre)   
    order by trimestre ASC , montant DESC;


select TO_CHAR(sum(montant), '9G999G999GL') as montant ,  
 DECODE(grouping(trimestre), 1, 'TOTAL', trimestre) trimestre,
 DECODE(grouping(categorie), 1, 'TOTAL', categorie) categorie ,
 DECODE(grouping(trimestre),
            1, 'null',
            DECODE(grouping(categorie),
                1, 'null',
                RANK() OVER (PARTITION BY
                trimestre, GROUPING(categorie)
                ORDER BY sum(montant) DESC))) rang
from 
    vente v, produit p, temps t
where 
    v.TID = t.TID and v.PID = p.PID 
    group by rollup (categorie ,trimestre)   
    order by trimestre ASC , montant DESC;


select TO_CHAR(sum(montant), '9G999G999GL') as montant ,  
 DECODE(grouping(trimestre), 1, 'TOTAL', trimestre) trimestre,
 DECODE(grouping(categorie), 1, 'TOTAL', categorie) categorie ,
 DECODE(grouping(trimestre), 1, 'null', DECODE(grouping(categorie),1, 'null',RANK() OVER (PARTITION BY trimestre, GROUPING(categorie) ORDER BY sum(montant) DESC))) rang,
 TO_CHAR(100*ratio_to_report(sum(montant)) over (PARTITION BY trimestre, grouping(categorie)), '999.99L', 'NLS_CURRENCY=%') ratio
from 
    vente v, produit p, temps t
where 
    v.TID = t.TID and v.PID = p.PID 
    group by rollup (categorie ,trimestre)   
    order by trimestre ASC , montant DESC;

select TO_CHAR(sum(montant), '9G999G999GL') as montant , 
    DECODE(grouping(pays), 1, 'TOTAL', pays) pays,
    DECODE(grouping(zonegeographique), 1, 'TOTAL', zonegeographique) zonegeographique,
    TO_CHAR(100*ratio_to_report(sum(montant)) over (PARTITION BY zonegeographique, grouping(pays)), '999.99L', 'NLS_CURRENCY=%') ratio
    from 
    vente v, localisation l
where 
    v.LID = l.LID
    group by cube (l.pays,l.zonegeographique)   
    order by montant DESC;

-- il faut grant la creation de view au user si vous n'êtes pas en mode admin -- 
Create view best_country as 
select TO_CHAR(sum(montant), '9G999G999GL') as montant , 
    DECODE(grouping(pays), 1, 'TOTAL', pays) pays,
    DECODE(grouping(zonegeographique), 1, 'TOTAL', zonegeographique) zonegeographique,
    TO_CHAR(100*ratio_to_report(sum(montant)) over (PARTITION BY zonegeographique, grouping(pays)), '999.99L', 'NLS_CURRENCY=%') ratio,
    ROW_NUMBER() OVER ( ORDER BY sum(montant) DESC ) nr
    from 
    vente v, localisation l
where 
    v.LID = l.LID
    group by cube (l.pays,l.zonegeographique)   
    order by montant DESC;
    
select montant, pays, zonegeographique, ratio from best_country where nr < 4;

Create view best_country_by_zn as 
select TO_CHAR(sum(montant), '9G999G999GL') as montant , 
    DECODE(grouping(pays), 1, 'TOTAL', pays) pays,
    DECODE(grouping(zonegeographique), 1, 'TOTAL', zonegeographique) zonegeographique,
    TO_CHAR(100*ratio_to_report(sum(montant)) over (PARTITION BY zonegeographique, grouping(pays)), '999.99L', 'NLS_CURRENCY=%') ratio,
    ROW_NUMBER() OVER ( PARTITION BY zonegeographique, grouping(pays) ORDER BY sum(montant) DESC ) nr
    from 
    vente v, localisation l
where 
    v.LID = l.LID
    group by cube (l.pays,l.zonegeographique)   
    order by montant DESC;

select montant, pays, zonegeographique, ratio from best_country_by_zn where pays <> 'TOTAL' and zonegeographique <> 'TOTAL' and nr < 4 order by zonegeographique;


select TO_CHAR(sum(montant), '9G999G999GL') as montant , 
 DECODE(grouping(trimestre), 1, 'TOTAL', trimestre) trimestre,
 DECODE(grouping(contact), 1, 'TOTAL', contact) contact,
 TO_CHAR(100*ratio_to_report(sum(montant)) over (PARTITION BY trimestre, grouping(contact)), '999.99L', 'NLS_CURRENCY=%') ratio
from vente v, temps t, client c
where v.TID = t.TID and v.CID = c.CID 
group by rollup (trimestre, contact)
order by trimestre ASC,montant DESC ;
