CREATE TABLE "public.patient" (
	"pat_ID" serial NOT NULL UNIQUE,
	"pat_name" TEXT NOT NULL,
	"pat_adress" TEXT NOT NULL,
	"pat_area" TEXT NOT NULL,
	"pat_city" TEXT NOT NULL,
	"pat_country" TEXT NOT NULL,
	"pat_mobile_number" integer NOT NULL,
	"pat_email" TEXT NOT NULL,
	"pat_gender" BOOLEAN NOT NULL,
	CONSTRAINT "patient_pk" PRIMARY KEY ("pat_ID")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.patientTest" (
	"pat_ID" TEXT NOT NULL,
	"test_ID" TEXT NOT NULL,
	"pat_test_result" TEXT
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.patientMedicine" (
	"pat_ID" TEXT NOT NULL,
	"med_ID" TEXT NOT NULL,
	"pat_med_dose" TEXT
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.patientAppointment" (
	"pat_ID" integer,
	"doc_ID" integer,
	"app_time" TIME,
	"app_shown" BOOLEAN,
	"app_ID" serial NOT NULL UNIQUE,
	"doc_cancel" BOOLEAN,
	"pat_cancel" BOOLEAN,
	"pat_postponed" BOOLEAN,
	"doc_postponed" BOOLEAN,
	"doc_no_show" BOOLEAN,
	"pat_no_show" BOOLEAN,
	"app_fee" integer,
	"app_doc_coll" BOOLEAN,
	"app_late_flag" BOOLEAN,
	"cus_pay_methode" TEXT,
	"doc_disc_ID" integer,
	"cus_disc_ID" integer,
	"fee" integer,
	"coll" BOOLEAN,
	CONSTRAINT "patientAppointment_pk" PRIMARY KEY ("app_ID")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.doctor" (
	"doc_ID" serial NOT NULL UNIQUE,
	"doc_name" TEXT NOT NULL,
	"doc_adress" TEXT NOT NULL,
	"doc_area" TEXT NOT NULL,
	"doc_city" TEXT NOT NULL,
	"doc_country" TEXT NOT NULL,
	"doc_mobile_number" integer NOT NULL,
	"doc_clinic_number" integer NOT NULL,
	"doc_email" TEXT NOT NULL,
	"doc_gender" BOOLEAN NOT NULL,
	"doc_speciality" TEXT,
	"doc_fee" integer,
	"doc_raiting" integer,
	"doc_warn" integer,
	"doc_sub_type" integer,
	CONSTRAINT "doctor_pk" PRIMARY KEY ("doc_ID")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.comments" (
	"ID" serial NOT NULL UNIQUE,
	"comment" TEXT NOT NULL,
	"com_ID" TEXT NOT NULL,
	"thread_ID" TEXT NOT NULL,
	CONSTRAINT "comments_pk" PRIMARY KEY ("ID")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.doctorDiscount" (
	"disc_ID" serial NOT NULL UNIQUE,
	"doc_ID" TEXT NOT NULL,
	"disc_value" TEXT NOT NULL,
	"disc_until" DATE NOT NULL,
	"disc_start" DATE NOT NULL,
	"coupon_code" TEXT NOT NULL,
	"redeamed" BOOLEAN NOT NULL,
	"permenant" BOOLEAN NOT NULL,
	CONSTRAINT "doctorDiscount_pk" PRIMARY KEY ("disc_ID")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.patientDiscount" (
	"disc_ID" serial NOT NULL,
	"pat_ID" TEXT NOT NULL,
	"disc_value" TEXT NOT NULL,
	"disc_until" DATE NOT NULL,
	"disc_start" DATE NOT NULL,
	"coupon_code" TEXT NOT NULL,
	"redeamed" BOOLEAN NOT NULL,
	CONSTRAINT "patientDiscount_pk" PRIMARY KEY ("disc_ID")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.test" (
	"test_ID" serial NOT NULL UNIQUE,
	"test_name" TEXT NOT NULL,
	"test_min" TEXT NOT NULL,
	"test_max" TEXT NOT NULL,
	"test_cat" TEXT NOT NULL,
	CONSTRAINT "test_pk" PRIMARY KEY ("test_ID")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "public.medicine" (
	"med_ID" serial NOT NULL UNIQUE,
	"med_name" TEXT NOT NULL,
	"med_min_dose" TEXT NOT NULL,
	"med_max_dose" TEXT NOT NULL,
	"med_cat" TEXT NOT NULL,
	"med_removed" BOOLEAN NOT NULL
) WITH (
  OIDS=FALSE
);

ALTER TABLE "patientTest" ADD CONSTRAINT "patientTest_fk0" FOREIGN KEY ("pat_ID") REFERENCES "patient"("pat_ID");
ALTER TABLE "patientTest" ADD CONSTRAINT "patientTest_fk1" FOREIGN KEY ("test_ID") REFERENCES "test"("test_ID");
ALTER TABLE "patientMedicine" ADD CONSTRAINT "patientMedicine_fk0" FOREIGN KEY ("pat_ID") REFERENCES "patient"("pat_ID");
ALTER TABLE "patientMedicine" ADD CONSTRAINT "patientMedicine_fk1" FOREIGN KEY ("med_ID") REFERENCES "medicine"("med_ID");
ALTER TABLE "patientAppointment" ADD CONSTRAINT "patientAppointment_fk0" FOREIGN KEY ("doc_disc_ID") REFERENCES "doctorDiscount"("disc_ID");
ALTER TABLE "patientAppointment" ADD CONSTRAINT "patientAppointment_fk1" FOREIGN KEY ("cus_disc_ID") REFERENCES "patientDiscount"("disc_ID");
ALTER TABLE "doctorDiscount" ADD CONSTRAINT "doctorDiscount_fk0" FOREIGN KEY ("doc_ID") REFERENCES "doctor"("doc_ID");
ALTER TABLE "patientDiscount" ADD CONSTRAINT "patientDiscount_fk0" FOREIGN KEY ("pat_ID") REFERENCES "patient"("pat_ID");
