-- Mark skeleton monsters in SpadingData for the "Skeleton of Crimbo Past" familiar project
UPDATE "SpadingData"
SET "data" = jsonb_set(
    "data",
    '{skeleton}',
    to_jsonb(
      ("data"->>'monster') IN (
        '[1346]bog skeleton',
        '[198]Bonerdagon',
        '[1418]cold skeleton',
        '[1744]factory-irregular skeleton',
        '[187]giant skeelton',
        '[1417]hot skeleton',
        '[1547]model skeleton',
        '[1746]novelty tropical skeleton',
        '[2318]Orignial Bonerdagon',
        '[637]Padre Cadáver',
        '[988]reanimated baboon skeleton',
        '[986]reanimated bat skeleton',
        '[990]reanimated demon skeleton',
        '[991]reanimated giant spider skeleton',
        '[987]reanimated serpent skeleton',
        '[989]reanimated wyrm skeleton',
        '[1745]remaindered skeleton',
        '[1103]sexy sorority skeleton',
        '[379]skeletal cat',
        '[375]skeletal hamster',
        '[380]skeletal monkey',
        '[714]skeletal sommelier',
        '[29]skleleton',
        '[377]skullery maid',
        '[1421]sleaze skeleton',
        '[40]Smart Skelton',
        '[185]spiny skelelton',
        '[1419]spooky skeleton',
        '[1420]stench skeleton',
        '[1743]swarm of skulls',
        '[402]tapdancing skeleton',
        '[1755]the former owner of the Skeleton Store',
        '[1391]The Unkillable Skeleton',
        '[-85]The Unkillable Skeleton (Hard Mode)',
        '[186]toothy sklelton'
      )
    )
)
WHERE "project" = 'Skeleton of Crimbo Past';
