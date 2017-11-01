-- script to determine counts of ADTs and programs for previous day
select esr.clientname, esr.Encounter_Source, year(ef.create_date) as Year , Month(ef.create_date) as month , day(ef.create_date) as Day, count(ef.create_date) as [ADT Messages in Pre-Load], count(distinct master_member_id) as [Distinct Members], count(identifi_program_id) as [Programs]
--,case when count(identifi_program_id) > 0 THEN count(identifi_program_id) ELSE NULL END as Programs
from [PreLoad].[dbo].[ENCOUNTER_FACT]  (nolock) ef
 right outer join operations.dbo.adt_encounter_source_ref  (nolock) esr on esr.encounter_source = ef.encounter_source
where cast(create_date as date) = cast(getdate() as date)
group by esr.clientname, esr.Encounter_Source, year(create_date), month(create_date), day(create_date)
order by esr.clientname, esr.encounter_source, year(create_date) desc, month(create_date) desc, day(create_date) desc


-- script to determine counts of ADTs and programs for previous week based on LOBs
select esr.clientname, esr.Encounter_Source, pld.LOB_Desc, year(ef.create_date) as Year , Month(ef.create_date) as month , day(ef.create_date) as Day, count(ef.create_date) as [ADT Messages in Pre-Load], count(distinct master_member_id) as [Distinct Members], count(identifi_program_id) as [Programs]
from [PreLoad].[dbo].[ENCOUNTER_FACT]  (nolock) ef
left join preload.dbo.plan_dim pld (nolock) on pld.plan_dim_key = ef.plan_dim_key
right join operations.dbo.adt_encounter_source_ref  (nolock) esr on esr.encounter_source = ef.encounter_source
where ef.create_date > getdate()-5 and ef.create_date <= getdate()
group by esr.clientname, esr.Encounter_Source, pld.LOB_Desc, year(ef.create_date), month(ef.create_date), day(ef.create_date)
order by esr.clientname, esr.encounter_source, pld.LOB_Desc, year(ef.create_date) desc, month(ef.create_date) desc, day(ef.create_date) desc





select  distinct identifi_program_id, ,CREATE_DATE from preload.dbo.ENCOUNTER_FACT nolock 
 where cast(create_date as date) = cast(getdate() as date) order by 1 desc