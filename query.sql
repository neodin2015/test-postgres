select
	tft.project,
	tft.constructive,
	tft.under_constructive,
	tft.work_group,
	tft.block,
	tft.floor,
	tft.level,
	MIN(tft.base_plan_start_date) as min_base_plan_start_date,
	MAX(tft.base_plan_finish_date) as max_base_plan_finish_date,
	jsonb_agg(
        jsonb_build_object(
            'contractor',
	tft.contractor,
	'plan_value',
	tft.plan_value
        )
order by
	tft.contractor is null,
	tft.plan_value desc
    ) as contractors
from
	tft.table_first_task tft
group by
	tft.project,
	tft.constructive,
	tft.under_constructive,
	tft.work_group,
	tft.block,
	tft.floor,
	tft.level;