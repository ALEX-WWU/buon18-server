CREATE TYPE gender_type AS ENUM ('M', 'F', 'U'); 
-- M = Male
-- F = Female
-- U = Unknown

CREATE TABLE "account" (
    id BIGINT GENERATED BY DEFAULT AS IDENTITY (START WITH 1000) PRIMARY KEY,

    -- Personal information
    code VARCHAR(32) NOT NULL UNIQUE,
    name VARCHAR(64) NOT NULL,
    email VARCHAR(64) UNIQUE,
    gender gender_type NOT NULL DEFAULT 'U',
    address VARCHAR(256),
    phone VARCHAR(16) NOT NULL UNIQUE,
    secondary_phone VARCHAR(16) UNIQUE,

    -- Flags
    deleted BOOLEAN NOT NULL DEFAULT FALSE,

    -- Timestamps
    cid bigint NOT NULL,
    ctime timestamp with time zone NOT NULL,
    mid bigint NOT NULL,
    mtime timestamp with time zone NOT NULL  
);

CREATE TABLE "social_media" (
    id BIGINT GENERATED BY DEFAULT AS IDENTITY (START WITH 1000) PRIMARY KEY,

    -- Foreign keys
    account_id BIGINT NOT NULL REFERENCES account(id) ON DELETE CASCADE,

    -- Social media information
    platform VARCHAR(25) NOT NULL, -- will store in lowercase
    url VARCHAR(256) NOT NULL,

    -- Timestamps
    cid BIGINT NOT NULL,
    ctime TIMESTAMP WITH TIME ZONE NOT NULL,
    mid BIGINT NOT NULL,
    mtime TIMESTAMP WITH TIME ZONE NOT NULL
);
