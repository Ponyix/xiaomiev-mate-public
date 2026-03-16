/*
 Navicat Premium Dump SQL

 Source Server Type    : PostgreSQL
 Source Server Version : 150017 (150017)
 Source Catalog        : xiaomi_ev
 Source Schema         : public

 Target Server Type    : PostgreSQL
 Target Server Version : 150017 (150017)
 File Encoding         : 65001

 Date: 02/03/2026 11:13:34
*/


-- ----------------------------
-- Sequence structure for access_log_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."access_log_id_seq";
CREATE SEQUENCE "public"."access_log_id_seq"
    INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "public"."access_log_id_seq" OWNER TO "postgres";

-- ----------------------------
-- Sequence structure for car_charge_record_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."car_charge_record_id_seq";
CREATE SEQUENCE "public"."car_charge_record_id_seq"
    INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "public"."car_charge_record_id_seq" OWNER TO "postgres";

-- ----------------------------
-- Sequence structure for car_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."car_id_seq";
CREATE SEQUENCE "public"."car_id_seq"
    INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "public"."car_id_seq" OWNER TO "postgres";

-- ----------------------------
-- Sequence structure for car_status_history_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."car_status_history_id_seq";
CREATE SEQUENCE "public"."car_status_history_id_seq"
    INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "public"."car_status_history_id_seq" OWNER TO "postgres";

-- ----------------------------
-- Sequence structure for car_summary_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."car_summary_id_seq";
CREATE SEQUENCE "public"."car_summary_id_seq"
    INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "public"."car_summary_id_seq" OWNER TO "postgres";

-- ----------------------------
-- Sequence structure for car_trip_detail_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."car_trip_detail_id_seq";
CREATE SEQUENCE "public"."car_trip_detail_id_seq"
    INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "public"."car_trip_detail_id_seq" OWNER TO "postgres";

-- ----------------------------
-- Sequence structure for car_trip_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."car_trip_id_seq";
CREATE SEQUENCE "public"."car_trip_id_seq"
    INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "public"."car_trip_id_seq" OWNER TO "postgres";

-- ----------------------------
-- Sequence structure for car_trip_month_stats_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."car_trip_month_stats_id_seq";
CREATE SEQUENCE "public"."car_trip_month_stats_id_seq"
    INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "public"."car_trip_month_stats_id_seq" OWNER TO "postgres";

-- ----------------------------
-- Sequence structure for car_trip_stats_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."car_trip_stats_id_seq";
CREATE SEQUENCE "public"."car_trip_stats_id_seq"
    INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "public"."car_trip_stats_id_seq" OWNER TO "postgres";

-- ----------------------------
-- Sequence structure for sync_record_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."sync_record_id_seq";
CREATE SEQUENCE "public"."sync_record_id_seq"
    INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "public"."sync_record_id_seq" OWNER TO "postgres";

-- ----------------------------
-- Sequence structure for users_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "public"."users_id_seq";
CREATE SEQUENCE "public"."users_id_seq"
    INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
ALTER SEQUENCE "public"."users_id_seq" OWNER TO "postgres";

-- ----------------------------
-- Table structure for access_log
-- ----------------------------
DROP TABLE IF EXISTS "public"."access_log";
CREATE TABLE "public"."access_log" (
                                       "id" int8 NOT NULL DEFAULT nextval('access_log_id_seq'::regclass),
                                       "log_type" int4,
                                       "source" varchar(32) COLLATE "pg_catalog"."default",
                                       "module" varchar(64) COLLATE "pg_catalog"."default",
                                       "action" varchar(128) COLLATE "pg_catalog"."default",
                                       "request_path" varchar(255) COLLATE "pg_catalog"."default",
                                       "http_method" varchar(16) COLLATE "pg_catalog"."default",
                                       "ip" varchar(64) COLLATE "pg_catalog"."default",
                                       "user_agent" varchar(255) COLLATE "pg_catalog"."default",
                                       "user_id" int8,
                                       "user_name" varchar(64) COLLATE "pg_catalog"."default",
                                       "car_id" int8,
                                       "request_params" text COLLATE "pg_catalog"."default",
                                       "response_code" int4,
                                       "success" int4,
                                       "error_msg" text COLLATE "pg_catalog"."default",
                                       "error_stack" text COLLATE "pg_catalog"."default",
                                       "cost_ms" int8,
                                       "create_time" timestamp(6) DEFAULT now()
)
;
ALTER TABLE "public"."access_log" OWNER TO "postgres";
COMMENT ON COLUMN "public"."access_log"."id" IS '主键';
COMMENT ON COLUMN "public"."access_log"."log_type" IS '日志类型(1=API,2=任务,3=外部接口)';
COMMENT ON COLUMN "public"."access_log"."source" IS '来源(web/mini/server/unknown)';
COMMENT ON COLUMN "public"."access_log"."module" IS '模块(如 user/car/sync/xiaomi-api)';
COMMENT ON COLUMN "public"."access_log"."action" IS '动作(如 login/syncCarStatus/refreshToken)';
COMMENT ON COLUMN "public"."access_log"."request_path" IS '请求路径';
COMMENT ON COLUMN "public"."access_log"."http_method" IS '请求方法';
COMMENT ON COLUMN "public"."access_log"."ip" IS '调用者IP';
COMMENT ON COLUMN "public"."access_log"."user_agent" IS 'User-Agent';
COMMENT ON COLUMN "public"."access_log"."user_id" IS '用户ID';
COMMENT ON COLUMN "public"."access_log"."user_name" IS '用户名';
COMMENT ON COLUMN "public"."access_log"."car_id" IS '车辆ID';
COMMENT ON COLUMN "public"."access_log"."request_params" IS '请求参数(已脱敏)';
COMMENT ON COLUMN "public"."access_log"."response_code" IS '响应码';
COMMENT ON COLUMN "public"."access_log"."success" IS '是否成功(1成功/0失败)';
COMMENT ON COLUMN "public"."access_log"."error_msg" IS '错误信息(简要)';
COMMENT ON COLUMN "public"."access_log"."error_stack" IS '错误堆栈(完整)';
COMMENT ON COLUMN "public"."access_log"."cost_ms" IS '耗时(毫秒)';
COMMENT ON COLUMN "public"."access_log"."create_time" IS '创建时间';
COMMENT ON TABLE "public"."access_log" IS '系统访问日志';

-- ----------------------------
-- Table structure for car
-- ----------------------------
DROP TABLE IF EXISTS "public"."car";
CREATE TABLE "public"."car" (
                                "id" int8 NOT NULL DEFAULT nextval('car_id_seq'::regclass),
                                "car_id" varchar(36) COLLATE "pg_catalog"."default" NOT NULL,
                                "car_name" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
                                "user_id" int8 NOT NULL,
                                "created" timestamp(0) DEFAULT now(),
                                "updated" timestamp(0) DEFAULT now(),
                                "deleted" int4 DEFAULT 0,
                                "car_model" varchar(20) COLLATE "pg_catalog"."default"
)
;
ALTER TABLE "public"."car" OWNER TO "postgres";

-- ----------------------------
-- Table structure for car_charge_record
-- ----------------------------
DROP TABLE IF EXISTS "public"."car_charge_record";
CREATE TABLE "public"."car_charge_record" (
                                              "id" int8 NOT NULL DEFAULT nextval('car_charge_record_id_seq'::regclass),
                                              "car_id" varchar(64) COLLATE "pg_catalog"."default" NOT NULL,
                                              "start_time" timestamp(6) NOT NULL,
                                              "end_time" timestamp(6) NOT NULL,
                                              "start_battery" numeric(10,2) DEFAULT NULL::numeric,
                                              "end_battery" numeric(10,2) DEFAULT NULL::numeric,
                                              "charge_battery" numeric(10,2) DEFAULT NULL::numeric,
                                              "start_range" numeric(10,2) DEFAULT NULL::numeric,
                                              "end_range" numeric(10,2) DEFAULT NULL::numeric,
                                              "charge_range" numeric(10,2) DEFAULT NULL::numeric,
                                              "charge_energy" numeric(10,2),
                                              "duration_minutes" int4,
                                              "location_name" varchar(255) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
                                              "latitude" varchar(32) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
                                              "longitude" varchar(32) COLLATE "pg_catalog"."default" DEFAULT NULL::character varying,
                                              "create_time" timestamp(0) DEFAULT CURRENT_TIMESTAMP,
                                              "update_time" timestamp(0) DEFAULT CURRENT_TIMESTAMP
)
;
ALTER TABLE "public"."car_charge_record" OWNER TO "postgres";
COMMENT ON COLUMN "public"."car_charge_record"."id" IS '主键ID';
COMMENT ON COLUMN "public"."car_charge_record"."car_id" IS '车辆ID';
COMMENT ON COLUMN "public"."car_charge_record"."start_time" IS '充电开始时间';
COMMENT ON COLUMN "public"."car_charge_record"."end_time" IS '充电结束时间';
COMMENT ON COLUMN "public"."car_charge_record"."start_battery" IS '开始电量(%)';
COMMENT ON COLUMN "public"."car_charge_record"."end_battery" IS '结束电量(%)';
COMMENT ON COLUMN "public"."car_charge_record"."charge_battery" IS '充电电量(%)';
COMMENT ON COLUMN "public"."car_charge_record"."start_range" IS '开始续航(km)';
COMMENT ON COLUMN "public"."car_charge_record"."end_range" IS '结束续航(km)';
COMMENT ON COLUMN "public"."car_charge_record"."charge_range" IS '增加续航(km)';
COMMENT ON COLUMN "public"."car_charge_record"."duration_minutes" IS '充电时长(分)';
COMMENT ON COLUMN "public"."car_charge_record"."location_name" IS '充电位置(参考)';
COMMENT ON COLUMN "public"."car_charge_record"."latitude" IS '纬度';
COMMENT ON COLUMN "public"."car_charge_record"."longitude" IS '经度';
COMMENT ON COLUMN "public"."car_charge_record"."charge_energy" IS '充电电量(kWh)';
COMMENT ON TABLE "public"."car_charge_record" IS '车辆充电记录表';

-- ----------------------------
-- Table structure for car_day_summary
-- ----------------------------
DROP TABLE IF EXISTS "public"."car_day_summary";
CREATE TABLE "public"."car_day_summary" (
                                            "id" int8 NOT NULL DEFAULT nextval('car_summary_id_seq'::regclass),
                                            "xiaomi_user_id" varchar(36) COLLATE "pg_catalog"."default" NOT NULL,
                                            "car_id" varchar(36) COLLATE "pg_catalog"."default" NOT NULL,
                                            "day_str" varchar(10) COLLATE "pg_catalog"."default" NOT NULL,
                                            "day_driving_mileage" int4,
                                            "day_driving_duration" int4,
                                            "created" timestamp(0) NOT NULL DEFAULT now()
)
;
ALTER TABLE "public"."car_day_summary" OWNER TO "postgres";
COMMENT ON COLUMN "public"."car_day_summary"."xiaomi_user_id" IS '小米用户ID';
COMMENT ON COLUMN "public"."car_day_summary"."car_id" IS '汽车ID';
COMMENT ON COLUMN "public"."car_day_summary"."day_str" IS '时间';
COMMENT ON COLUMN "public"."car_day_summary"."day_driving_mileage" IS '当天行程里程';
COMMENT ON COLUMN "public"."car_day_summary"."day_driving_duration" IS '当天行程时长';
COMMENT ON COLUMN "public"."car_day_summary"."created" IS '数据创建时间';

-- ----------------------------
-- Table structure for car_status_history
-- ----------------------------
DROP TABLE IF EXISTS "public"."car_status_history";
CREATE TABLE "public"."car_status_history" (
                                               "id" int8 NOT NULL DEFAULT nextval('car_status_history_id_seq'::regclass),
                                               "car_id" varchar(64) COLLATE "pg_catalog"."default" NOT NULL,
                                               "status_time" timestamp(6) NOT NULL,
                                               "remaining_range" numeric(10,2) DEFAULT NULL::numeric,
                                               "battery_level" numeric(10,2) DEFAULT NULL::numeric,
                                               "total_mileage" numeric(10,2) DEFAULT NULL::numeric,
                                               "create_time" timestamp(0) DEFAULT CURRENT_TIMESTAMP,
                                               "charge_state" int4,
                                               "current_speed" int4 DEFAULT 0,
                                               "inside_temp" numeric(10,2),
                                               "preset_temp" numeric(10,2),
                                               "raw_data" text COLLATE "pg_catalog"."default",
                                               "value_box" text COLLATE "pg_catalog"."default",
                                               "gear_position" int4 DEFAULT 0
)
;
ALTER TABLE "public"."car_status_history" OWNER TO "postgres";
COMMENT ON COLUMN "public"."car_status_history"."id" IS '主键ID';
COMMENT ON COLUMN "public"."car_status_history"."car_id" IS '车辆ID';
COMMENT ON COLUMN "public"."car_status_history"."status_time" IS '状态记录时间';
COMMENT ON COLUMN "public"."car_status_history"."remaining_range" IS '剩余续航(km)';
COMMENT ON COLUMN "public"."car_status_history"."battery_level" IS '电池电量(%)';
COMMENT ON COLUMN "public"."car_status_history"."total_mileage" IS '总里程(km)';
COMMENT ON COLUMN "public"."car_status_history"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."car_status_history"."charge_state" IS '充电状态 (0:未充电,1:已插枪未充电,2:正在充电,3:充电完成 ,5:动能回收)';
COMMENT ON COLUMN "public"."car_status_history"."current_speed" IS '当前车速';
COMMENT ON COLUMN "public"."car_status_history"."inside_temp" IS '车内温度';
COMMENT ON COLUMN "public"."car_status_history"."preset_temp" IS '预设温度';
COMMENT ON COLUMN "public"."car_status_history"."raw_data" IS '原始API响应JSON(用于调试和观察未解析字段)';
COMMENT ON COLUMN "public"."car_status_history"."value_box" IS '扩展字段';
COMMENT ON COLUMN "public"."car_status_history"."gear_position" IS '档位';
COMMENT ON TABLE "public"."car_status_history" IS '车辆状态历史记录表';

-- ----------------------------
-- Table structure for car_trip
-- ----------------------------
DROP TABLE IF EXISTS "public"."car_trip";
CREATE TABLE "public"."car_trip" (
                                     "id" int8 NOT NULL DEFAULT nextval('car_trip_id_seq'::regclass),
                                     "xiaomi_user_id" varchar(36) COLLATE "pg_catalog"."default" NOT NULL,
                                     "car_id" varchar(36) COLLATE "pg_catalog"."default" NOT NULL,
                                     "day_str" varchar(10) COLLATE "pg_catalog"."default" NOT NULL,
                                     "trip_id" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
                                     "driving_mileage" int4 NOT NULL,
                                     "driving_duration" int4 NOT NULL,
                                     "start_location" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
                                     "end_location" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
                                     "trip_start_time" int8 NOT NULL,
                                     "trip_end_time" int8 NOT NULL,
                                     "remote_location_switch" int4 NOT NULL,
                                     "created" timestamp(0) NOT NULL DEFAULT now(),
                                     "updated" timestamp(0) NOT NULL DEFAULT now(),
                                     "deleted" int4 NOT NULL DEFAULT 0
)
;
ALTER TABLE "public"."car_trip" OWNER TO "postgres";
COMMENT ON COLUMN "public"."car_trip"."xiaomi_user_id" IS '小米用户ID';
COMMENT ON COLUMN "public"."car_trip"."car_id" IS '汽车ID';
COMMENT ON COLUMN "public"."car_trip"."day_str" IS '行程日期';
COMMENT ON COLUMN "public"."car_trip"."trip_id" IS '行程ID';
COMMENT ON COLUMN "public"."car_trip"."driving_mileage" IS '行程里程';
COMMENT ON COLUMN "public"."car_trip"."driving_duration" IS '行程时长';
COMMENT ON COLUMN "public"."car_trip"."start_location" IS '行程开始地点';
COMMENT ON COLUMN "public"."car_trip"."end_location" IS '行程结束地点';
COMMENT ON COLUMN "public"."car_trip"."trip_start_time" IS '行程开始时间';
COMMENT ON COLUMN "public"."car_trip"."trip_end_time" IS '行程结束时间';
COMMENT ON COLUMN "public"."car_trip"."remote_location_switch" IS '远程位置开关';
COMMENT ON COLUMN "public"."car_trip"."created" IS '数据创建时间';
COMMENT ON COLUMN "public"."car_trip"."updated" IS '数据修改时间';

-- ----------------------------
-- Table structure for car_trip_detail
-- ----------------------------
DROP TABLE IF EXISTS "public"."car_trip_detail";
CREATE TABLE "public"."car_trip_detail" (
                                            "id" int8 NOT NULL DEFAULT nextval('car_trip_detail_id_seq'::regclass),
                                            "xiaomi_user_id" varchar(36) COLLATE "pg_catalog"."default" NOT NULL,
                                            "car_id" varchar(36) COLLATE "pg_catalog"."default" NOT NULL,
                                            "trip_id" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
                                            "iccc_vid" varchar(255) COLLATE "pg_catalog"."default",
                                            "trip_start_time" varchar(255) COLLATE "pg_catalog"."default",
                                            "trip_end_time" varchar(255) COLLATE "pg_catalog"."default",
                                            "trip_start_location" varchar(255) COLLATE "pg_catalog"."default",
                                            "trip_end_location" varchar(255) COLLATE "pg_catalog"."default",
                                            "trip_start_longitude" varchar(255) COLLATE "pg_catalog"."default",
                                            "trip_start_latitude" varchar(255) COLLATE "pg_catalog"."default",
                                            "trip_end_longitude" varchar(255) COLLATE "pg_catalog"."default",
                                            "trip_end_latitude" varchar(255) COLLATE "pg_catalog"."default",
                                            "driving_duration" int4,
                                            "driving_mileage" int4,
                                            "trip_gps_type" int4 DEFAULT 0,
                                            "avg_speed" numeric(5,2),
                                            "max_speed" int4,
                                            "driving_performance" json,
                                            "noa_mileage" int4,
                                            "noa_duration" int4,
                                            "noa_mileage_percent" int4,
                                            "noa_duration_percent" int4,
                                            "lcc_acc_mileage" int4,
                                            "lcc_acc_duration" int4,
                                            "lcc_acc_mileage_percent" int4,
                                            "lcc_acc_duration_percent" int4,
                                            "trip_energy_consumption" varchar(5) COLLATE "pg_catalog"."default",
                                            "total_power_consumption" varchar(5) COLLATE "pg_catalog"."default",
                                            "idle_power_consumption" varchar(5) COLLATE "pg_catalog"."default",
                                            "energy_performance" json,
                                            "create_time" varchar(255) COLLATE "pg_catalog"."default",
                                            "update_time" varchar(255) COLLATE "pg_catalog"."default",
                                            "deleted" int4 DEFAULT 0,
                                            "start_remaining_range" numeric(10,2) DEFAULT NULL::numeric,
                                            "end_remaining_range" numeric(10,2) DEFAULT NULL::numeric,
                                            "consumed_range" numeric(10,2) DEFAULT NULL::numeric,
                                            "consumption_achievement_rate" numeric(10,1)
)
;
ALTER TABLE "public"."car_trip_detail" OWNER TO "postgres";
COMMENT ON COLUMN "public"."car_trip_detail"."xiaomi_user_id" IS '小米用户ID';
COMMENT ON COLUMN "public"."car_trip_detail"."car_id" IS '汽车ID';
COMMENT ON COLUMN "public"."car_trip_detail"."trip_id" IS '行程ID';
COMMENT ON COLUMN "public"."car_trip_detail"."trip_start_time" IS '行程开始时间';
COMMENT ON COLUMN "public"."car_trip_detail"."trip_end_time" IS '行程结束时间';
COMMENT ON COLUMN "public"."car_trip_detail"."trip_start_location" IS '行程开始地址';
COMMENT ON COLUMN "public"."car_trip_detail"."trip_end_location" IS '行程结束地址';
COMMENT ON COLUMN "public"."car_trip_detail"."trip_start_longitude" IS '行程开始经';
COMMENT ON COLUMN "public"."car_trip_detail"."trip_start_latitude" IS '行程开始纬';
COMMENT ON COLUMN "public"."car_trip_detail"."trip_end_longitude" IS '行程结束经';
COMMENT ON COLUMN "public"."car_trip_detail"."trip_end_latitude" IS '行程结束纬';
COMMENT ON COLUMN "public"."car_trip_detail"."driving_duration" IS '行程时长';
COMMENT ON COLUMN "public"."car_trip_detail"."driving_mileage" IS '行程里程';
COMMENT ON COLUMN "public"."car_trip_detail"."trip_gps_type" IS '行程GPS类型';
COMMENT ON COLUMN "public"."car_trip_detail"."avg_speed" IS '平均车速';
COMMENT ON COLUMN "public"."car_trip_detail"."max_speed" IS '最高车速';
COMMENT ON COLUMN "public"."car_trip_detail"."driving_performance" IS '驾驶性能';
COMMENT ON COLUMN "public"."car_trip_detail"."noa_mileage" IS 'NOA里程';
COMMENT ON COLUMN "public"."car_trip_detail"."noa_duration" IS 'NOA时长';
COMMENT ON COLUMN "public"."car_trip_detail"."noa_mileage_percent" IS 'NOA里程百分比';
COMMENT ON COLUMN "public"."car_trip_detail"."noa_duration_percent" IS 'NOA时长百分比';
COMMENT ON COLUMN "public"."car_trip_detail"."lcc_acc_mileage" IS 'LCC里程';
COMMENT ON COLUMN "public"."car_trip_detail"."lcc_acc_duration" IS 'LCC时长';
COMMENT ON COLUMN "public"."car_trip_detail"."lcc_acc_mileage_percent" IS 'LCC里程百分比';
COMMENT ON COLUMN "public"."car_trip_detail"."lcc_acc_duration_percent" IS 'LCC时长百分比';
COMMENT ON COLUMN "public"."car_trip_detail"."trip_energy_consumption" IS '行程能耗';
COMMENT ON COLUMN "public"."car_trip_detail"."total_power_consumption" IS '累计耗电';
COMMENT ON COLUMN "public"."car_trip_detail"."idle_power_consumption" IS '怠速耗电';
COMMENT ON COLUMN "public"."car_trip_detail"."energy_performance" IS '耗电分类';
COMMENT ON COLUMN "public"."car_trip_detail"."create_time" IS '创建时间';
COMMENT ON COLUMN "public"."car_trip_detail"."update_time" IS '修改时间';
COMMENT ON COLUMN "public"."car_trip_detail"."start_remaining_range" IS '行程开始剩余续航';
COMMENT ON COLUMN "public"."car_trip_detail"."end_remaining_range" IS '行程结束剩余续航';
COMMENT ON COLUMN "public"."car_trip_detail"."consumed_range" IS '消耗续航里程';
COMMENT ON COLUMN "public"."car_trip_detail"."consumption_achievement_rate" IS '续航达成率';

-- ----------------------------
-- Table structure for car_trip_month_stats
-- ----------------------------
DROP TABLE IF EXISTS "public"."car_trip_month_stats";
CREATE TABLE "public"."car_trip_month_stats" (
                                                 "id" int8 NOT NULL DEFAULT nextval('car_trip_month_stats_id_seq'::regclass),
                                                 "car_id" varchar(32) COLLATE "pg_catalog"."default" NOT NULL,
                                                 "user_id" int8 NOT NULL,
                                                 "month" varchar(6) COLLATE "pg_catalog"."default",
                                                 "month_mileage" numeric(10,2),
                                                 "avail_days" int4,
                                                 "day_mileages" jsonb,
                                                 "max_trip_mileage" numeric,
                                                 "max_trip_duration" numeric,
                                                 "ad_duration" int4,
                                                 "hnoa_mileage" numeric,
                                                 "cnoa_mileage" numeric,
                                                 "basic_pilot_mileage" numeric,
                                                 "cnoa_mileage_percent" int4,
                                                 "hnoa_mileage_percent" int4,
                                                 "basic_pilot_mileage_percent" int4,
                                                 "apa_cnt" int4,
                                                 "avp_cnt" int4,
                                                 "total_energy_consumption" numeric,
                                                 "avg_energy_consumption" numeric,
                                                 "best_energy_consumption" numeric,
                                                 "driving_energy_percent" int4,
                                                 "temp_ctrl_energy_percent" int4,
                                                 "device_energy_percent" int4,
                                                 "other_energy_percent" int4,
                                                 "created" timestamp(0) DEFAULT now(),
                                                 "updated" timestamp(0) DEFAULT now()
)
;
ALTER TABLE "public"."car_trip_month_stats" OWNER TO "postgres";
COMMENT ON COLUMN "public"."car_trip_month_stats"."car_id" IS '车辆ID (vid)';
COMMENT ON COLUMN "public"."car_trip_month_stats"."user_id" IS '系统用户ID';
COMMENT ON COLUMN "public"."car_trip_month_stats"."month" IS '统计月份';
COMMENT ON COLUMN "public"."car_trip_month_stats"."month_mileage" IS '月度总里程(km)';
COMMENT ON COLUMN "public"."car_trip_month_stats"."avail_days" IS '可用天数';
COMMENT ON COLUMN "public"."car_trip_month_stats"."day_mileages" IS '每日里程详情 ';
COMMENT ON COLUMN "public"."car_trip_month_stats"."max_trip_mileage" IS '单次最长里程';
COMMENT ON COLUMN "public"."car_trip_month_stats"."max_trip_duration" IS '单次最长时长';
COMMENT ON COLUMN "public"."car_trip_month_stats"."ad_duration" IS '智驾时长';
COMMENT ON COLUMN "public"."car_trip_month_stats"."hnoa_mileage" IS '高速领航里程';
COMMENT ON COLUMN "public"."car_trip_month_stats"."cnoa_mileage" IS '城市领航里程';
COMMENT ON COLUMN "public"."car_trip_month_stats"."basic_pilot_mileage" IS '基础辅助驾驶里程';
COMMENT ON COLUMN "public"."car_trip_month_stats"."cnoa_mileage_percent" IS '城市领航占比(%)';
COMMENT ON COLUMN "public"."car_trip_month_stats"."hnoa_mileage_percent" IS '高速领航占比(%)';
COMMENT ON COLUMN "public"."car_trip_month_stats"."basic_pilot_mileage_percent" IS '基础辅助占比(%)';
COMMENT ON COLUMN "public"."car_trip_month_stats"."apa_cnt" IS '自动泊车次数';
COMMENT ON COLUMN "public"."car_trip_month_stats"."avp_cnt" IS '代客泊车次数';
COMMENT ON COLUMN "public"."car_trip_month_stats"."total_energy_consumption" IS '总能耗(kWh)';
COMMENT ON COLUMN "public"."car_trip_month_stats"."avg_energy_consumption" IS '平均能耗(kWh/100km)';
COMMENT ON COLUMN "public"."car_trip_month_stats"."best_energy_consumption" IS '最佳能耗(kWh/100km)';
COMMENT ON COLUMN "public"."car_trip_month_stats"."driving_energy_percent" IS '行驶能耗占比(%)';
COMMENT ON COLUMN "public"."car_trip_month_stats"."temp_ctrl_energy_percent" IS '空调能耗占比(%)';
COMMENT ON COLUMN "public"."car_trip_month_stats"."device_energy_percent" IS '设备能耗占比(%)';
COMMENT ON COLUMN "public"."car_trip_month_stats"."other_energy_percent" IS '其他能耗占比(%)';
COMMENT ON COLUMN "public"."car_trip_month_stats"."created" IS '创建时间';
COMMENT ON COLUMN "public"."car_trip_month_stats"."updated" IS '更新时间';

-- ----------------------------
-- Table structure for car_trip_stats
-- ----------------------------
DROP TABLE IF EXISTS "public"."car_trip_stats";
CREATE TABLE "public"."car_trip_stats" (
                                           "id" int8 NOT NULL DEFAULT nextval('car_trip_stats_id_seq'::regclass),
                                           "car_id" varchar(36) COLLATE "pg_catalog"."default" NOT NULL,
                                           "user_id" int8 NOT NULL,
                                           "car_bind_days" int4,
                                           "total_mileage" int4,
                                           "car_name" varchar(255) COLLATE "pg_catalog"."default",
                                           "car_model" varchar(255) COLLATE "pg_catalog"."default",
                                           "energy_rank" varchar(255) COLLATE "pg_catalog"."default",
                                           "energy_title" varchar(255) COLLATE "pg_catalog"."default",
                                           "best_energy_consumption" numeric(5,2),
                                           "avg_energy_consumption" numeric(5,2),
                                           "avg_energy_consumption_slope" numeric(5,2),
                                           "province" varchar(32) COLLATE "pg_catalog"."default",
                                           "ad_mileage" int4,
                                           "human_mileage" int4,
                                           "ad_mileage_percent" int4,
                                           "human_mileage_percent" int4,
                                           "created" timestamp(0) DEFAULT now(),
                                           "updated" timestamp(0) DEFAULT now()
)
;
ALTER TABLE "public"."car_trip_stats" OWNER TO "postgres";
COMMENT ON COLUMN "public"."car_trip_stats"."car_id" IS '车辆ID';
COMMENT ON COLUMN "public"."car_trip_stats"."user_id" IS '系统用户ID';
COMMENT ON COLUMN "public"."car_trip_stats"."car_bind_days" IS '车辆绑定天数';
COMMENT ON COLUMN "public"."car_trip_stats"."total_mileage" IS '总里程(km)';
COMMENT ON COLUMN "public"."car_trip_stats"."car_name" IS '车辆名称''';
COMMENT ON COLUMN "public"."car_trip_stats"."car_model" IS '车辆型号';
COMMENT ON COLUMN "public"."car_trip_stats"."energy_rank" IS '能耗排名';
COMMENT ON COLUMN "public"."car_trip_stats"."energy_title" IS '能耗称号';
COMMENT ON COLUMN "public"."car_trip_stats"."best_energy_consumption" IS '最佳能耗(kWh/100km)';
COMMENT ON COLUMN "public"."car_trip_stats"."avg_energy_consumption" IS '平均能耗(kWh/100km)';
COMMENT ON COLUMN "public"."car_trip_stats"."avg_energy_consumption_slope" IS '带坡度平均能耗';
COMMENT ON COLUMN "public"."car_trip_stats"."province" IS '省份';
COMMENT ON COLUMN "public"."car_trip_stats"."ad_mileage" IS '智驾里程(km)';
COMMENT ON COLUMN "public"."car_trip_stats"."human_mileage" IS '人驾里程(km)';
COMMENT ON COLUMN "public"."car_trip_stats"."ad_mileage_percent" IS '智驾比例(%)';
COMMENT ON COLUMN "public"."car_trip_stats"."human_mileage_percent" IS '人驾比例(%)';
COMMENT ON COLUMN "public"."car_trip_stats"."created" IS '创建时间';
COMMENT ON COLUMN "public"."car_trip_stats"."updated" IS '更新时间';

-- ----------------------------
-- Table structure for sync_record
-- ----------------------------
DROP TABLE IF EXISTS "public"."sync_record";
CREATE TABLE "public"."sync_record" (
                                        "id" int8 NOT NULL DEFAULT nextval('sync_record_id_seq'::regclass),
                                        "car_id" varchar(36) COLLATE "pg_catalog"."default",
                                        "trip_id" text COLLATE "pg_catalog"."default",
                                        "sync_type" int4,
                                        "sync_status" int4,
                                        "created" timestamp(0) DEFAULT now(),
                                        "updated" timestamp(0) DEFAULT now(),
                                        "deleted" int4 DEFAULT 0,
                                        "failure_info" varchar(255) COLLATE "pg_catalog"."default",
                                        "param" text COLLATE "pg_catalog"."default"
)
;
ALTER TABLE "public"."sync_record" OWNER TO "postgres";
COMMENT ON COLUMN "public"."sync_record"."sync_type" IS '历史数据1，每天数据2';
COMMENT ON COLUMN "public"."sync_record"."sync_status" IS '任务状态 1=进行中，2=成功，3失败，4任务取消';
COMMENT ON COLUMN "public"."sync_record"."param" IS '请求接口传参';

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS "public"."sys_user";
CREATE TABLE "public"."sys_user" (
                                     "id" int8 NOT NULL DEFAULT nextval('users_id_seq'::regclass),
                                     "user_name" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
                                     "password" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
                                     "email" varchar(255) COLLATE "pg_catalog"."default",
                                     "xiaomi_user_id" varchar(36) COLLATE "pg_catalog"."default",
                                     "service_token" text COLLATE "pg_catalog"."default",
                                     "created" timestamp(0) NOT NULL DEFAULT now(),
                                     "updated" timestamp(0) NOT NULL DEFAULT now(),
                                     "deleted" int4 NOT NULL DEFAULT 0,
                                     "xiaomi_account" varchar(255) COLLATE "pg_catalog"."default",
                                     "xiaomi_password" varchar(255) COLLATE "pg_catalog"."default",
                                     "xiaomi_sign" varchar(255) COLLATE "pg_catalog"."default",
                                     "xiaomi_eui" text COLLATE "pg_catalog"."default",
                                     "xiaomi_device_id" varchar(255) COLLATE "pg_catalog"."default"
)
;
ALTER TABLE "public"."sys_user" OWNER TO "postgres";
COMMENT ON COLUMN "public"."sys_user"."xiaomi_account" IS '小米账号';
COMMENT ON COLUMN "public"."sys_user"."xiaomi_password" IS '小米密码';
COMMENT ON COLUMN "public"."sys_user"."xiaomi_sign" IS '小米签名';
COMMENT ON COLUMN "public"."sys_user"."xiaomi_eui" IS '小米eui';
COMMENT ON COLUMN "public"."sys_user"."xiaomi_device_id" IS '小米设备ID';

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."access_log_id_seq"
    OWNED BY "public"."access_log"."id";

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."car_charge_record_id_seq"
    OWNED BY "public"."car_charge_record"."id";

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."car_id_seq"
    OWNED BY "public"."car"."id";

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."car_status_history_id_seq"
    OWNED BY "public"."car_status_history"."id";

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."car_summary_id_seq"
    OWNED BY "public"."car_day_summary"."id";

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."car_trip_detail_id_seq"
    OWNED BY "public"."car_trip_detail"."id";

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."car_trip_id_seq"
    OWNED BY "public"."car_trip"."id";

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."car_trip_month_stats_id_seq"
    OWNED BY "public"."car_trip_month_stats"."id";

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."car_trip_stats_id_seq"
    OWNED BY "public"."car_trip_stats"."id";

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."sync_record_id_seq"
    OWNED BY "public"."sync_record"."id";

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "public"."users_id_seq"
    OWNED BY "public"."sys_user"."id";

-- ----------------------------
-- Indexes structure for table access_log
-- ----------------------------
CREATE INDEX "idx_access_log_source" ON "public"."access_log" USING btree (
    "source" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
    );
CREATE INDEX "idx_access_log_time" ON "public"."access_log" USING btree (
    "create_time" "pg_catalog"."timestamp_ops" ASC NULLS LAST
    );
CREATE INDEX "idx_access_log_type" ON "public"."access_log" USING btree (
    "log_type" "pg_catalog"."int4_ops" ASC NULLS LAST
    );

-- ----------------------------
-- Primary Key structure for table access_log
-- ----------------------------
ALTER TABLE "public"."access_log" ADD CONSTRAINT "access_log_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table car
-- ----------------------------
CREATE INDEX "idx_car_user_id" ON "public"."car" USING btree (
    "user_id" "pg_catalog"."int8_ops" ASC NULLS LAST
    );
CREATE UNIQUE INDEX "uk_car_id_deleted_0" ON "public"."car" USING btree (
    "car_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
    ) WHERE deleted = 0;

-- ----------------------------
-- Primary Key structure for table car
-- ----------------------------
ALTER TABLE "public"."car" ADD CONSTRAINT "car_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table car_charge_record
-- ----------------------------
CREATE INDEX "idx_charge_car_time" ON "public"."car_charge_record" USING btree (
    "car_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST,
    "start_time" "pg_catalog"."timestamp_ops" ASC NULLS LAST
    );

-- ----------------------------
-- Primary Key structure for table car_charge_record
-- ----------------------------
ALTER TABLE "public"."car_charge_record" ADD CONSTRAINT "car_charge_record_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table car_day_summary
-- ----------------------------
CREATE UNIQUE INDEX "uk_car_day_summary_car_day" ON "public"."car_day_summary" USING btree (
    "car_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST,
    "day_str" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
    );

-- ----------------------------
-- Primary Key structure for table car_day_summary
-- ----------------------------
ALTER TABLE "public"."car_day_summary" ADD CONSTRAINT "car_day_summary_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table car_status_history
-- ----------------------------
CREATE INDEX "idx_car_id_status_time" ON "public"."car_status_history" USING btree (
    "car_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST,
    "status_time" "pg_catalog"."timestamp_ops" ASC NULLS LAST
    );

-- ----------------------------
-- Primary Key structure for table car_status_history
-- ----------------------------
ALTER TABLE "public"."car_status_history" ADD CONSTRAINT "car_status_history_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table car_trip
-- ----------------------------
CREATE INDEX "idx_car_trip_car_day" ON "public"."car_trip" USING btree (
    "car_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST,
    "day_str" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
    );
CREATE INDEX "idx_car_trip_car_start_time" ON "public"."car_trip" USING btree (
    "car_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST,
    "trip_start_time" "pg_catalog"."int8_ops" DESC NULLS FIRST
    );
CREATE UNIQUE INDEX "uk_car_trip_trip_id" ON "public"."car_trip" USING btree (
    "trip_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
    );
CREATE UNIQUE INDEX "uk_car_trip_trip_id_deleted_0" ON "public"."car_trip" USING btree (
    "trip_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
    ) WHERE deleted = 0;

-- ----------------------------
-- Primary Key structure for table car_trip
-- ----------------------------
ALTER TABLE "public"."car_trip" ADD CONSTRAINT "car_trip_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table car_trip_detail
-- ----------------------------
CREATE INDEX "idx_car_trip_detail_car_time" ON "public"."car_trip_detail" USING btree (
    "car_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST,
    "trip_start_time" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
    );
CREATE UNIQUE INDEX "uk_car_trip_detail_trip_id" ON "public"."car_trip_detail" USING btree (
    "trip_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
    );
CREATE UNIQUE INDEX "uk_car_trip_detail_trip_id_deleted_0" ON "public"."car_trip_detail" USING btree (
    "trip_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
    ) WHERE deleted = 0;

-- ----------------------------
-- Primary Key structure for table car_trip_detail
-- ----------------------------
ALTER TABLE "public"."car_trip_detail" ADD CONSTRAINT "car_trip_detail_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table car_trip_month_stats
-- ----------------------------
CREATE UNIQUE INDEX "uk_car_month" ON "public"."car_trip_month_stats" USING btree (
    "car_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST,
    "month" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" DESC NULLS FIRST
    );
CREATE UNIQUE INDEX "uk_car_trip_month_stats_car_month" ON "public"."car_trip_month_stats" USING btree (
    "car_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST,
    "month" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
    );

-- ----------------------------
-- Primary Key structure for table car_trip_month_stats
-- ----------------------------
ALTER TABLE "public"."car_trip_month_stats" ADD CONSTRAINT "car_trip_month_stats_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table car_trip_stats
-- ----------------------------
CREATE INDEX "idx_car_trip_stats_car_created" ON "public"."car_trip_stats" USING btree (
    "car_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST,
    "created" "pg_catalog"."timestamp_ops" DESC NULLS FIRST
    );
CREATE INDEX "idx_car_trip_stats_car_id_bind_days" ON "public"."car_trip_stats" USING btree (
    "car_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST,
    "car_bind_days" "pg_catalog"."int4_ops" ASC NULLS LAST
    );

-- ----------------------------
-- Primary Key structure for table car_trip_stats
-- ----------------------------
ALTER TABLE "public"."car_trip_stats" ADD CONSTRAINT "car_trip_stats_pkey" PRIMARY KEY ("id", "user_id");

-- ----------------------------
-- Indexes structure for table sync_record
-- ----------------------------
CREATE INDEX "idx_sync_record_query" ON "public"."sync_record" USING btree (
    "car_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST,
    "sync_status" "pg_catalog"."int4_ops" ASC NULLS LAST,
    "sync_type" "pg_catalog"."int4_ops" ASC NULLS LAST,
    "created" "pg_catalog"."timestamp_ops" ASC NULLS LAST
    );

-- ----------------------------
-- Primary Key structure for table sync_record
-- ----------------------------
ALTER TABLE "public"."sync_record" ADD CONSTRAINT "sync_record_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table sys_user
-- ----------------------------
CREATE UNIQUE INDEX "uk_sys_user_username" ON "public"."sys_user" USING btree (
    "user_name" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
    );
CREATE UNIQUE INDEX "uk_sys_user_xiaomi_id" ON "public"."sys_user" USING btree (
    "xiaomi_user_id" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
    );

-- ----------------------------
-- Uniques structure for table sys_user
-- ----------------------------
ALTER TABLE "public"."sys_user" ADD CONSTRAINT "user_name" UNIQUE ("user_name");

-- ----------------------------
-- Primary Key structure for table sys_user
-- ----------------------------
ALTER TABLE "public"."sys_user" ADD CONSTRAINT "users_pkey" PRIMARY KEY ("id");
