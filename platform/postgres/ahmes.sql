
--
-- reclog schema
--

create table file (
  id serial primary key,
  name varchar constraint file_name_key unique,
  size int,
  imported_on timestamp with time zone default current_timestamp
);

create table reclog (
  file_id serial references file(id) on delete cascade not null,
  line_number int,
  data jsonb not null,
  timestamp timestamp with time zone,
  primary key (file_id, line_number)
);

comment on column file.id is 'unique id for a file';
comment on column file.name is 'the S3 filename (without the directory)';
comment on column file.imported_on is 'when the record was added to this database';
comment on column reclog.data is 'the raw JSON data';
comment on column reclog.timestamp is 'timestamp (from the reclog JSON data)';

create table opmetrics (
  file_id int not null,
  line_number int not null,
  timestamp timestamp with time zone,
  member_number int not null,
  client varchar not null,
  external_plan_id varchar not null,
  health_provider_locations int,
  picwell_score int,
  picwell_tier varchar,
  realcost numeric,
  realcost_premium numeric,
  realcost_drugs numeric,
  realcost_health numeric,
  realcost_spending_account_balance_increase numeric,
  realcost_spending_account_benefit numeric,
  household_id varchar,
  enrolled_plan_id varchar,
  network_id varchar,
  survey_doctor_importance varchar,
  survey_time_with_doctor varchar,
  survey_planning_child varchar,
  survey_income varchar,
  survey_risk_10 varchar,
  survey_risk_50 varchar,
  external_user_id varchar,
  zip3 varchar,
  age int,
  gender varchar,
  prescriptions int,
  is_parent boolean,
  is_dependant boolean,
  is_policyholder boolean,
  coverage_type varchar,
  primary key(file_id, line_number, external_plan_id, member_number),
  CONSTRAINT positive_values CHECK (
    realcost_premium >= 0 AND realcost_drugs >= 0
    AND realcost_health >= 0 AND age >= 0
  ),
  FOREIGN KEY (file_id, line_number) REFERENCES reclog (file_id, line_number)
);

create index opmetrics_timestamp on opmetrics(timestamp);
