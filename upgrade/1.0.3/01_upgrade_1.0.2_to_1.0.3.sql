-- xiaomiev-mate 数据库升级脚本
-- 版本: v1.0.2 -> v1.0.3
-- 说明:
-- 1. 新增通知事件订阅表 notify_event_subscription（机器人通知配置）
-- 2. 支持按平台维护 value_box 扩展字段与事件白名单 event_codes
-- 3. 新增二维码登录能力（代码层）
-- 4. sys_user.xiaomi_sign 升级为 text，用于存储更长的 passToken

BEGIN;

-- =========================================================
-- 1) 通知事件订阅: sequence
-- =========================================================
CREATE SEQUENCE IF NOT EXISTS public.notify_event_subscription_id_seq
    INCREMENT 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    START 1
    CACHE 1;

-- =========================================================
-- 2) 通知事件订阅: table
-- =========================================================
CREATE TABLE IF NOT EXISTS public.notify_event_subscription (
    id int8 NOT NULL DEFAULT nextval('notify_event_subscription_id_seq'::regclass),
    user_id int8 NOT NULL,
    platform varchar(32) NOT NULL,
    value_box text,
    event_codes text,
    enabled int4 NOT NULL DEFAULT 0,
    created timestamp(0) NOT NULL DEFAULT now(),
    updated timestamp(0) NOT NULL DEFAULT now(),
    deleted int4 NOT NULL DEFAULT 0
);

COMMENT ON COLUMN public.notify_event_subscription.user_id IS '系统用户ID';
COMMENT ON COLUMN public.notify_event_subscription.platform IS '机器人平台: WECOM/DINGTALK/FEISHU';
COMMENT ON COLUMN public.notify_event_subscription.value_box IS '平台扩展参数JSON';
COMMENT ON COLUMN public.notify_event_subscription.event_codes IS '事件编码白名单, 逗号分隔, 为空表示全量事件';
COMMENT ON COLUMN public.notify_event_subscription.enabled IS '是否启用: 1启用, 0禁用';
COMMENT ON TABLE public.notify_event_subscription IS '通知事件订阅';

-- =========================================================
-- 2) 主键 / 索引 / 归属
-- =========================================================
ALTER SEQUENCE public.notify_event_subscription_id_seq
    OWNED BY public.notify_event_subscription.id;

DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM pg_constraint
        WHERE conname = 'notify_event_subscription_pkey'
          AND conrelid = 'public.notify_event_subscription'::regclass
    ) THEN
        ALTER TABLE public.notify_event_subscription
            ADD CONSTRAINT notify_event_subscription_pkey PRIMARY KEY (id);
    END IF;
END $$;

CREATE INDEX IF NOT EXISTS idx_notify_subscription_user_enabled
    ON public.notify_event_subscription USING btree (user_id, enabled);

CREATE UNIQUE INDEX IF NOT EXISTS uk_notify_subscription_user_platform_deleted_0
    ON public.notify_event_subscription USING btree (user_id, platform)
    WHERE deleted = 0;

-- =========================================================
-- 3) 二维码登录/登录态持久化
-- =========================================================
ALTER TABLE public.sys_user
    ALTER COLUMN xiaomi_sign TYPE text;

COMMIT;
