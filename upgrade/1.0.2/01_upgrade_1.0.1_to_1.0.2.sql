-- xiaomiev-mate 数据库升级脚本
-- 版本: v1.0.1 -> v1.0.2
-- 说明:
-- 1. 新增行程轨迹表 car_trip_track
-- 2. car_trip / car_trip_detail / car_day_summary 从 xiaomi_user_id 统一迁移到 user_id(Bigint)
-- 3. sync_record 新增 user_id 并回填
-- 4. sys_user 新增 user_role（1普通用户, 9管理员）

BEGIN;

-- =========================================================
-- 1) 行程轨迹表 car_trip_track
-- =========================================================
CREATE SEQUENCE IF NOT EXISTS public.car_trip_track_id_seq
    INCREMENT 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    START 1
    CACHE 1;

CREATE TABLE IF NOT EXISTS public.car_trip_track (
    id int8 NOT NULL DEFAULT nextval('car_trip_track_id_seq'::regclass),
    user_id int8 NOT NULL,
    car_id varchar(36) NOT NULL,
    trip_id varchar(255) NOT NULL,
    location_type int4 DEFAULT 0,
    track_points json,
    point_count int4 DEFAULT 0,
    trip_start_time varchar(255),
    trip_end_time varchar(255),
    created timestamp(0) NOT NULL DEFAULT now(),
    updated timestamp(0) NOT NULL DEFAULT now(),
    deleted int4 NOT NULL DEFAULT 0
);

ALTER SEQUENCE public.car_trip_track_id_seq OWNED BY public.car_trip_track.id;

DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM pg_constraint
        WHERE conname = 'car_trip_track_pkey'
          AND conrelid = 'public.car_trip_track'::regclass
    ) THEN
        ALTER TABLE public.car_trip_track
            ADD CONSTRAINT car_trip_track_pkey PRIMARY KEY (id);
    END IF;
END $$;

CREATE INDEX IF NOT EXISTS idx_car_trip_track_car_updated
    ON public.car_trip_track USING btree (car_id, updated DESC);
CREATE UNIQUE INDEX IF NOT EXISTS uk_car_trip_track_trip_id_deleted_0
    ON public.car_trip_track USING btree (trip_id)
    WHERE deleted = 0;

COMMENT ON COLUMN public.car_trip_track.user_id IS '系统用户ID';
COMMENT ON COLUMN public.car_trip_track.car_id IS '汽车ID';
COMMENT ON COLUMN public.car_trip_track.trip_id IS '行程ID';
COMMENT ON COLUMN public.car_trip_track.location_type IS '轨迹类型';
COMMENT ON COLUMN public.car_trip_track.track_points IS '完整轨迹点';
COMMENT ON COLUMN public.car_trip_track.point_count IS '轨迹点数量';
COMMENT ON COLUMN public.car_trip_track.trip_start_time IS '轨迹开始时间';
COMMENT ON COLUMN public.car_trip_track.trip_end_time IS '轨迹结束时间';
COMMENT ON COLUMN public.car_trip_track.created IS '数据创建时间';
COMMENT ON COLUMN public.car_trip_track.updated IS '数据修改时间';

-- =========================================================
-- 2) 用户字段统一: xiaomi_user_id -> user_id
-- =========================================================
ALTER TABLE public.car_trip ADD COLUMN IF NOT EXISTS user_id int8;
ALTER TABLE public.car_trip_detail ADD COLUMN IF NOT EXISTS user_id int8;
ALTER TABLE public.car_day_summary ADD COLUMN IF NOT EXISTS user_id int8;
ALTER TABLE public.sync_record ADD COLUMN IF NOT EXISTS user_id int8;

-- 优先通过 car.car_id 回填（最可靠）
UPDATE public.car_trip t
SET user_id = c.user_id
FROM public.car c
WHERE t.user_id IS NULL
  AND c.deleted = 0
  AND c.car_id = t.car_id;

UPDATE public.car_trip_detail t
SET user_id = c.user_id
FROM public.car c
WHERE t.user_id IS NULL
  AND c.deleted = 0
  AND c.car_id = t.car_id;

UPDATE public.car_day_summary t
SET user_id = c.user_id
FROM public.car c
WHERE t.user_id IS NULL
  AND c.deleted = 0
  AND c.car_id = t.car_id;

UPDATE public.sync_record s
SET user_id = c.user_id
FROM public.car c
WHERE s.user_id IS NULL
  AND c.deleted = 0
  AND c.car_id = s.car_id;

-- sync_record 再尝试通过 trip_id 回填
UPDATE public.sync_record s
SET user_id = t.user_id
FROM public.car_trip t
WHERE s.user_id IS NULL
  AND s.trip_id IS NOT NULL
  AND t.trip_id = s.trip_id;

-- car_id 无法命中的历史数据，回退按旧 xiaomi_user_id -> sys_user.id 回填
DO $$
BEGIN
    IF EXISTS (
        SELECT 1
        FROM information_schema.columns
        WHERE table_schema = 'public'
          AND table_name = 'car_trip'
          AND column_name = 'xiaomi_user_id'
    ) THEN
        EXECUTE '
            UPDATE public.car_trip t
            SET user_id = u.id
            FROM public.sys_user u
            WHERE t.user_id IS NULL
              AND t.xiaomi_user_id IS NOT NULL
              AND u.deleted = 0
              AND u.xiaomi_user_id = t.xiaomi_user_id
        ';
    END IF;
END $$;

DO $$
BEGIN
    IF EXISTS (
        SELECT 1
        FROM information_schema.columns
        WHERE table_schema = 'public'
          AND table_name = 'car_trip_detail'
          AND column_name = 'xiaomi_user_id'
    ) THEN
        EXECUTE '
            UPDATE public.car_trip_detail t
            SET user_id = u.id
            FROM public.sys_user u
            WHERE t.user_id IS NULL
              AND t.xiaomi_user_id IS NOT NULL
              AND u.deleted = 0
              AND u.xiaomi_user_id = t.xiaomi_user_id
        ';
    END IF;
END $$;

DO $$
BEGIN
    IF EXISTS (
        SELECT 1
        FROM information_schema.columns
        WHERE table_schema = 'public'
          AND table_name = 'car_day_summary'
          AND column_name = 'xiaomi_user_id'
    ) THEN
        EXECUTE '
            UPDATE public.car_day_summary t
            SET user_id = u.id
            FROM public.sys_user u
            WHERE t.user_id IS NULL
              AND t.xiaomi_user_id IS NOT NULL
              AND u.deleted = 0
              AND u.xiaomi_user_id = t.xiaomi_user_id
        ';
    END IF;
END $$;

-- 三张核心表必须全部回填成功，否则中断
DO $$
BEGIN
    IF EXISTS (SELECT 1 FROM public.car_trip WHERE user_id IS NULL) THEN
        RAISE EXCEPTION 'car_trip 存在无法回填 user_id 的数据，请先人工处理';
    END IF;
    IF EXISTS (SELECT 1 FROM public.car_trip_detail WHERE user_id IS NULL) THEN
        RAISE EXCEPTION 'car_trip_detail 存在无法回填 user_id 的数据，请先人工处理';
    END IF;
    IF EXISTS (SELECT 1 FROM public.car_day_summary WHERE user_id IS NULL) THEN
        RAISE EXCEPTION 'car_day_summary 存在无法回填 user_id 的数据，请先人工处理';
    END IF;
END $$;

ALTER TABLE public.car_trip ALTER COLUMN user_id SET NOT NULL;
ALTER TABLE public.car_trip_detail ALTER COLUMN user_id SET NOT NULL;
ALTER TABLE public.car_day_summary ALTER COLUMN user_id SET NOT NULL;

ALTER TABLE public.car_trip DROP COLUMN IF EXISTS xiaomi_user_id;
ALTER TABLE public.car_trip_detail DROP COLUMN IF EXISTS xiaomi_user_id;
ALTER TABLE public.car_day_summary DROP COLUMN IF EXISTS xiaomi_user_id;

COMMENT ON COLUMN public.car_trip.user_id IS '系统用户ID';
COMMENT ON COLUMN public.car_trip_detail.user_id IS '系统用户ID';
COMMENT ON COLUMN public.car_day_summary.user_id IS '系统用户ID';
COMMENT ON COLUMN public.sync_record.user_id IS '系统用户ID';

CREATE INDEX IF NOT EXISTS idx_car_trip_user_id
    ON public.car_trip USING btree (user_id);
CREATE INDEX IF NOT EXISTS idx_car_trip_detail_user_id
    ON public.car_trip_detail USING btree (user_id);
CREATE INDEX IF NOT EXISTS idx_car_day_summary_user_id
    ON public.car_day_summary USING btree (user_id);
CREATE INDEX IF NOT EXISTS idx_sync_record_user_created
    ON public.sync_record USING btree (user_id, created);

-- =========================================================
-- 3) 账号角色
-- =========================================================
ALTER TABLE public.sys_user ADD COLUMN IF NOT EXISTS user_role int4;

UPDATE public.sys_user
SET user_role = 9
WHERE user_role IS NULL;

ALTER TABLE public.sys_user ALTER COLUMN user_role SET DEFAULT 1;
ALTER TABLE public.sys_user ALTER COLUMN user_role SET NOT NULL;

COMMENT ON COLUMN public.sys_user.user_role IS '用户角色: 1普通用户, 9管理员';

CREATE INDEX IF NOT EXISTS idx_sys_user_role
    ON public.sys_user USING btree (user_role);

COMMIT;
