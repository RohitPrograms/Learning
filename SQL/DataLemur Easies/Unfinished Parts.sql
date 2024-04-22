SELECT      part, assembly_step
FROM        parts_assembly
WHERE       finish_date IS NULL --Easily enough, the unfinished parts are just rows without a finish date