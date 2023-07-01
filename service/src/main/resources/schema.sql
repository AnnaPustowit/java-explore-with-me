CREATE TABLE IF NOT EXISTS users (
    id    BIGINT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    name  varchar(512) NOT NULL,
    email varchar(512) NOT NULL,
    UNIQUE (email)
);

CREATE TABLE IF NOT EXISTS categories (
    id   BIGINT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    name varchar(512),
    UNIQUE (name)
);

CREATE TABLE IF NOT EXISTS events (
    id                 BIGINT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    title              varchar(512),
    description        varchar(7000),
    annotation         varchar(2000),
    state              varchar(100),
    category_id        int REFERENCES categories (id) ON DELETE CASCADE,
    created_on         TIMESTAMP,
    event_date         TIMESTAMP,
    published_on       TIMESTAMP,
    confirmed_requests int,
    location_id        BIGINT,
    initiator_id       BIGINT REFERENCES users (id) ON DELETE CASCADE,
    paid               boolean,
    participant_limit  int,
    request_moderation boolean
);

CREATE TABLE IF NOT EXISTS compilations (
    id     BIGINT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    title  varchar(512),
    pinned boolean default false
);

CREATE TABLE IF NOT EXISTS compilations_events (
    COMPILATION_ID BIGINT not null,
    EVENT_ID       BIGINT not null,
    CONSTRAINT PK_COMPILATION_EVENTS PRIMARY KEY (COMPILATION_ID, EVENT_ID),
    CONSTRAINT FK_COMPILATION_EVENT FOREIGN KEY (compilation_id) REFERENCES COMPILATIONS (id) ON DELETE CASCADE,
    CONSTRAINT FK_EVENT_COMP FOREIGN KEY (event_id) REFERENCES EVENTS (id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS participation_request (
    id           BIGINT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    created      TIMESTAMP,
    event_id     BIGINT REFERENCES events (id) ON DELETE CASCADE,
    requester_id BIGINT REFERENCES users (id) ON DELETE CASCADE,
    status       varchar(100)
);

CREATE TABLE IF NOT EXISTS location (
    id  BIGINT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    lat FLOAT,
    lon FLOAT
);